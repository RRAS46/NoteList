import 'package:flutter/material.dart';

var light_Mode=ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade400,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
    surface: Colors.grey.shade900
  )

);

ThemeData dark_Mode=ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    surface: Colors.grey.shade200
  )
);


class LightDarkMode{
  String themeName;
  IconData themeicon;
  bool isDarkMode;



  LightDarkMode({this.themeName="Light Mode",this.themeicon=Icons.light_mode,this.isDarkMode=false,});


  LightDarkMode initLightMode(){
    return LightDarkMode(themeName: "Light Mode",themeicon: Icons.light_mode,isDarkMode: false);
  }
  LightDarkMode initDarkMode(){
    return LightDarkMode(themeName: "Dark Mode",themeicon: Icons.dark_mode,isDarkMode: true);
  }

}
