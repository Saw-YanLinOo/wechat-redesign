import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wechat_redesign/main.dart';
import 'package:wechat_redesign/persistence/hive_constants.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/utils/material_color_generator.dart';

enum ThemeType { light, dark, system }

class ThemeBloc extends ChangeNotifier {
  String currentTheme = ThemeType.system.name;

  ThemeMode get themeMode {
    if (currentTheme == ThemeType.light.name) {
      return ThemeMode.light;
    } else if (currentTheme == ThemeType.dark.name) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  var box = Hive.box<String>(BOX_NAME_THEME);

  ThemeBloc() {
    currentTheme = box.get(KEY_THEME) ?? "system";
  }

  void setTheme(BuildContext context, String theme) {
    if (theme == ThemeType.light.name) {
      currentTheme = ThemeType.light.name;
    } else if (theme == ThemeType.dark.name) {
      currentTheme = ThemeType.dark.name;
    } else {
      currentTheme = ThemeType.system.name;
    }

    box.put(KEY_THEME, currentTheme);
    notifyListeners();
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const MyApp()),
    //     (route) => false);
  }

// Theme Color
  final darkTheme = ThemeData(
    primarySwatch: generateMaterialColor(Colors.black),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );

  final lightTheme = ThemeData(
    primarySwatch: generateMaterialColor(PRIMARY_COLOR),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: PRIMARY_COLOR,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: PRIMARY_COLOR,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: PRIMARY_COLOR),
      bodyMedium: TextStyle(color: PRIMARY_COLOR),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );
}
