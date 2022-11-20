import 'dart:convert';
import 'dart:developer';
import 'package:contintal/constans/constants.dart';
import 'package:contintal/exceptions/http_error_handler.dart';
import 'package:http/http.dart' as http;
import '../exceptions/api_exceptions.dart';
import '../models/continental_model.dart';

class ContinentalApiServices {
  Future<ContinentalModel>? getContinentalApiServices() async {
    /*final Uri uri = Uri(
      scheme: 'https',
      host: kHostApi,
      path: kPath,
    );*/

    const url = kHostApi + kPath;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        log(response.body);
        final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw ApiExceptions('Cannot get the data');
        }
        return ContinentalModel.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }
}
