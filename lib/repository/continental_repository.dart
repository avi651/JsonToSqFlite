import 'dart:developer';

import 'package:contintal/exceptions/api_exceptions.dart';
import 'package:contintal/models/continental_model.dart';
import 'package:contintal/services/continental_api_services.dart';
import 'package:flutter/foundation.dart';

import '../helpers/custom_error.dart';

class ContinentalRepository {
  final ContinentalApiServices contintalApiServices;

  ContinentalRepository({
    required this.contintalApiServices,
  });

  Future<ContinentalModel> fetchContintalData() async {
    try {
      final ContinentalModel? continentalModel =
          await contintalApiServices.getContinentalApiServices();

      if (kDebugMode) {
        log('Contintal: ${continentalModel!}');
      }
      final contintalMap =
          ContinentalModel.fromJson(continentalModel!.toJson());

      return contintalMap;
    } on ApiExceptions catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
