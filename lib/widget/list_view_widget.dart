import 'package:cached_network_image/cached_network_image.dart';
import 'package:contintal/screens/home_detail_screen.dart';
import 'package:flutter/material.dart';

import '../database/db_provider.dart';
import '../helpers/create_route.dart';
import '../models/continental_model.dart';
import 'wid_txt.dart';

class ListViewWidget extends StatelessWidget {
  final List<Map<String, dynamic>>? fetchSqliteDB;
  final ContinentalModel? continentalData;
  bool? isConnectedToInternet;
  ListViewWidget({
    Key? key,
    this.continentalData,
    this.fetchSqliteDB,
    this.isConnectedToInternet,
  }) : super(key: key);
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const Key("homelist"),
      itemCount: isConnectedToInternet == true
          ? continentalData?.rows?.length ?? 0
          : fetchSqliteDB?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (fetchSqliteDB == null || fetchSqliteDB?.isEmpty == true) {
          _insert(
              continentalData?.rows?[index].title ?? "",
              continentalData?.rows?[index].description ?? "",
              continentalData?.rows?[index].imageHref ?? "");
        }

        return GestureDetector(
          onTap: () {
            isConnectedToInternet == true
                ? Navigator.push(
                    context,
                    createRoute(
                      HomeDetailScreen(
                        title: continentalData?.rows?[index].title ?? "",
                        description:
                            continentalData?.rows?[index].description ?? "",
                        imageHref:
                            continentalData?.rows?[index].imageHref ?? "",
                      ),
                    ),
                  )
                : Navigator.push(
                    context,
                    createRoute(
                      HomeDetailScreen(
                        title: fetchSqliteDB?[index]['title'] ?? "-",
                        description:
                            fetchSqliteDB?[index]['description'] ?? "-",
                        imageHref: fetchSqliteDB?[index]['imageHref'],
                      ),
                    ),
                  );
          },
          child: ListTile(
            leading: (isConnectedToInternet == true)
                ? (continentalData?.rows?[index].imageHref == null ||
                        continentalData?.rows?[index].imageHref == "")
                    ? const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.not_interested,
                          color: Colors.red,
                        ),
                      )
                    : SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl:
                                continentalData?.rows?[index].imageHref ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.red,
                                    BlendMode.colorBurn,
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                : (fetchSqliteDB?[index]['imageHref'] == null ||
                        fetchSqliteDB?[index]['imageHref'] == "")
                    ? const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.not_interested,
                          color: Colors.red,
                        ),
                      )
                    : SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl: fetchSqliteDB?[index]['imageHref'],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.red,
                                    BlendMode.colorBurn,
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
            title: WidText(
              title: (isConnectedToInternet == true)
                  ? (continentalData?.rows?[index].title ?? "-")
                  : fetchSqliteDB?[index]['title'] ?? "-",
              widColor: Colors.blue,
            ),
            subtitle: WidText(
              title: (isConnectedToInternet == true)
                  ? (continentalData?.rows?[index].description ?? "-")
                  : fetchSqliteDB?[index]['description'] ?? "-",
              //"-",
              widColor: Colors.grey,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  Future _insert(String title, String description, String imageHref) async {
    Map<String, dynamic> row = {
      DatabaseHelper.title: title,
      DatabaseHelper.description: description,
      DatabaseHelper.imageHref: imageHref,
    };

    final id = await dbHelper.insert(row);
    debugPrint("Id is:   $id");
  }
}
