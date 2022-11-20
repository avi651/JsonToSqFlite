import 'package:contintal/bloc/theme_cubit/theme_cubit.dart';
import 'package:contintal/bloc_observer/bloc_observer.dart';
import 'package:contintal/services/continental_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/continetal_cubit/continental_cubit.dart';
import 'repository/continental_repository.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ContinentalBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ContinentalRepository(
        contintalApiServices: ContinentalApiServices(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ContinentalCubit>(
            create: (context) => ContinentalCubit(
              continentalRepository: context.read<ContinentalRepository>(),
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'cont',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
