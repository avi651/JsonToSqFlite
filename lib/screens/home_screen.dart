import 'dart:io';
import 'package:contintal/components/home_components.dart';
import 'package:contintal/screens/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/continetal_cubit/continental_cubit.dart';
import '../bloc/continetal_cubit/continental_state.dart';
import '../database/db_provider.dart';
import '../helpers/create_route.dart';
import '../helpers/show_theme.dart';
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
                  backgroundColor: getThemeColor(context),
                  appBar: AppBar(
                    actions: [
                      FlatButton(
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            createRoute(const SettingScreen()),
                          );
                        },
                        child: const Text("Settings"),
                        shape: const CircleBorder(
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ],
                  ),
                  body: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              if (state is ContinetalStateLoading) {
                return Scaffold(
                  backgroundColor: getThemeColor(context),
                  appBar: AppBar(
                    actions: [
                      FlatButton(
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            createRoute(const SettingScreen()),
                          );
                        },
                        child: const Text("Settings"),
                        shape: const CircleBorder(
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ],
                  ),
                  body: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              if (state is ContinetalStateError) {
                return Scaffold(
                  backgroundColor: getThemeColor(context),
                  appBar: AppBar(
                    actions: [
                      FlatButton(
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            createRoute(const SettingScreen()),
                          );
                        },
                        child: const Text("Settings"),
                        shape: const CircleBorder(
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ],
                  ),
                  body: const Center(
                    child: Text('Error'),
                  ),
                );
              }
              if (state is ContinentalStateSuccess) {
                return Scaffold(
                  backgroundColor: getThemeColor(context),
                  appBar: AppBar(
                    title: Text(state.contintalModel.title ?? ""),
                    actions: [
                      FlatButton(
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            createRoute(const SettingScreen()),
                          );
                        },
                        child: const Text("Settings"),
                        shape: const CircleBorder(
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ],
                  ),
                  body: HomeComponent(
                    continentalData: state.contintalModel,
                    isConnectedToInternet: isConnected,
                    getSqliteDB: sqliteDB,
                  ),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: getThemeColor(context),
                  actions: [
                    FlatButton(
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          createRoute(const SettingScreen()),
                        );
                      },
                      child: const Text("Settings"),
                      shape: const CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ],
                ),
                body: Container(),
              );
            },
          )
        : Scaffold(
            backgroundColor: getThemeColor(context),
            appBar: AppBar(
              title: const Text('Continental'),
              actions: [
                FlatButton(
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      createRoute(const SettingScreen()),
                    );
                  },
                  child: const Text("Settings"),
                  shape: const CircleBorder(
                      side: BorderSide(color: Colors.transparent)),
                ),
              ],
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
