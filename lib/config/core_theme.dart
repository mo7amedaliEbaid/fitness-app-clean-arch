
part of 'app_theme.dart';

const fontFamily = '';

final themeLight = ThemeData(
  iconTheme: IconThemeData(size: 35,color: Colors.white),
  fontFamily: fontFamily,
  primaryColor: AppTheme.light.primary,
  brightness: Brightness.light,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Color(0xffd5e6b1), colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: AppTheme.light.primary,
        background: AppTheme.light.background,
      ).copyWith(primary: Colors.teal, background: Colors.white).copyWith(secondary: AppTheme.light.primary),
);

final themeDark = ThemeData(
  fontFamily: fontFamily,
  primaryColor: AppTheme.light.primary,
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.grey[900], colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: AppTheme.light.primary,
        background: AppTheme.light.background,
        brightness: Brightness.dark,
      ).copyWith(background: Colors.grey[800]),
);
