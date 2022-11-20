import 'package:bloc/bloc.dart';
import 'package:contintal/bloc/theme_cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());
  void changeTheme() {
    emit(state.copyWith(
      theme: state.themes == Themes.Dark ? Themes.Light : Themes.Dark,
    ));
  }
}
