import 'dart:io';

import 'package:contintal/bloc/continental_state.dart';
import 'package:contintal/components/home_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/continental_cubit.dart';
import '../database/db_provider.dart';
import '../widget/wid_txt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = false;
  List<Map<String, dynamic>>? sqliteDB;

  // This will check the connection at the beginning
  @override
  void initState() {
    _checkInternetConnection();
    super.initState();
  }

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        setState(() {
          isConnected = true;
          //await context.read<ContinentalCubit>().fetchContintinentalData();
          BlocProvider.of<ContinentalCubit>(context).fetchContintinentalData();
        });
      }
    } on SocketException catch (err) {
      setState(() {
        isConnected = false;
      });
      debugPrint(err.toString());
    }
  }

  Future _fetchDataFromDB() async {
    sqliteDB = await DatabaseHelper.instance.queryAllRows();
  }

  @override
  Widget build(BuildContext context) {
    return (isConnected == true)
        ? BlocBuilder<ContinentalCubit, ContinentalState>(
            builder: (context, state) {
              if (state is ContinetalStateInitial) {
                return Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              if (state is ContinetalStateLoading) {
                return Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              if (state is ContinetalStateError) {
                return Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: Text('Error'),
                  ),
                );
              }
              if (state is ContinentalStateSuccess) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(state.contintalModel.title ?? ""),
                  ),
                  body: HomeComponent(
                    continentalData: state.contintalModel,
                    isConnectedToInternet: isConnected,
                    getSqliteDB: sqliteDB,
                  ),
                );
              }
              return Scaffold(
                appBar: AppBar(),
                body: Container(),
              );
            },
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Continental'),
            ),
            body: FutureBuilder(
                future: _fetchDataFromDB(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Text('Please wait its loading...'));
                  } else {
                    if (sqliteDB?.isEmpty == true) {
                      return const Center(
                          child: WidText(
                        title: "No Internect Connection",
                        widColor: Colors.blue,
                      ));
                    } else {
                      return HomeComponent(
                        isConnectedToInternet: isConnected,
                        getSqliteDB: sqliteDB,
                      );
                    }
                  }
                }),
          );
  }
}
