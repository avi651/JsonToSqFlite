import 'package:equatable/equatable.dart';

enum Themes {
  Light,
  Dark,
}

class ThemeState extends Equatable {
  final Themes themes;
  const ThemeState({
    required this.themes,
  });

  @override
  List<Object> get props => [themes];

  factory ThemeState.initial() => const ThemeState(themes: Themes.Light);

  ThemeState copyWith({
    Themes? theme,
  }) {
    return ThemeState(
      themes: theme ?? this.themes,
    );
  }

  @override
  String toString() => 'TextThemeState(textTheme: $themes)';

  enumToString() => themes.toString().split('.').last.split(')').first;
}
