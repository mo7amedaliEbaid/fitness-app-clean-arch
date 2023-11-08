part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class InitialThemeSetEvent extends ThemeEvent {}

class ThemeSwitchEvent extends ThemeEvent {}