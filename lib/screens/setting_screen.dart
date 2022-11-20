import 'package:contintal/bloc/theme_cubit/theme_cubit.dart';
import 'package:contintal/bloc/theme_cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/show_theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getThemeColor(context),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Change Color'),
                Switch(
                  value:
                      context.watch<ThemeCubit>().state.themes == Themes.Light,
                  onChanged: (_) {
                    context.read<ThemeCubit>().changeTheme();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
