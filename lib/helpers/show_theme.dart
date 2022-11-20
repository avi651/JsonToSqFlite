import 'package:contintal/bloc/theme_cubit/theme_cubit.dart';
import 'package:contintal/bloc/theme_cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Color getThemeColor(BuildContext context) {
  final colorTheme = context.watch<ThemeCubit>().state.themes;
  if (colorTheme == Themes.Light) {
    return Colors.white;
  }
  return Colors.blueGrey;
}
