import 'package:flutter/material.dart';

import '../models/continental_model.dart';
import '../widget/list_view_widget.dart';

class HomeComponent extends StatelessWidget {
  final ContinentalModel? continentalData;
  bool? isConnectedToInternet;
  final List<Map<String, dynamic>>? getSqliteDB;
  HomeComponent({
    Key? key,
    this.continentalData,
    this.isConnectedToInternet,
    this.getSqliteDB,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewWidget(
      continentalData: continentalData,
      isConnectedToInternet: isConnectedToInternet,
      fetchSqliteDB: getSqliteDB,
    );
  }
}
