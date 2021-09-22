import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app02/res/colors.dart';

class ThemeViewModel with ChangeNotifier {

  ThemeViewModel() {
    //_init();
  }

  static ThemeViewModel of(BuildContext context) {
    return Provider.of<ThemeViewModel>(context, listen: false);
  }

  void init() async {
    ThemeMode oldThemeMode = themeMode;
    int oldThemeIndex = themeIndex;

    await _init();

    print("_themeMode:${themeMode.index}, _themeIndex:${themeIndex}");
    if (oldThemeMode != themeMode || oldThemeIndex != themeIndex) {
      notifyListeners();
    }
  }


  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode newModel) {
    if (newModel == _themeMode) return;
    _themeMode = newModel;
    _saveThemeMode();
    notifyListeners();
  }

  int _themeIndex = 0;
  int get themeIndex => _themeIndex;
  set themeIndex(int newIndex) {
    if (newIndex == _themeIndex) return;
    if (newIndex >= YColors.themeColor.length) return;
    _themeIndex = newIndex;
    _saveThemeIndex();
    notifyListeners();
  }

  ThemeData get lightTheme => _lightTheme();
  ThemeData get darkTheme => _dartTheme();

  Color get primaryColor => YColors.themeColor[themeIndex]["primaryColor"];
  Color get primaryColorDark => YColors.themeColor[themeIndex]["primaryColorDark"];
  Color get primaryColorLight => YColors.themeColor[themeIndex]["primaryColorLight"];
  Color get accentColor => YColors.themeColor[themeIndex]["accentColor"];

  ThemeData _lightTheme() {
     return ThemeData.light().copyWith(
       primaryColor: primaryColor,
       appBarTheme: AppBarTheme(
         backgroundColor: primaryColor,
       ),
       bottomNavigationBarTheme: BottomNavigationBarThemeData(
         selectedItemColor: primaryColor,
         elevation: 8.0,
       ),
       switchTheme : SwitchThemeData(
         thumbColor: MaterialStateProperty.resolveWith(
                 (states) {
               if (states.contains(MaterialState.selected)) {
                 return primaryColor;
               }
               return null;
             }
         ),
         trackColor: MaterialStateProperty.resolveWith(
                 (states) {
               if (states.contains(MaterialState.selected)) {
                 return primaryColor.withAlpha(180);
               }
               return null;
             }
         ),
       ),
     );
    return ThemeData.from(
      colorScheme: ColorScheme.light(
          primary: primaryColor,
          //primaryVariant: Colors.white,
          //secondary: const Color(0xff1976D2),
          //secondaryVariant: const Color(0xff1976D2),
          //background: const Color(0xffF5F5F5),
          //surface: Colors.white,
          //onSurface: Colors.white,
          //onPrimary: Colors.white
      ),
    ).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
      ),
    );
  }

  ThemeData _dartTheme() {
    return ThemeData.dark().copyWith(
      //shadowColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[800]!,
        unselectedItemColor: Colors.grey[600]!,
        selectedItemColor: Colors.white,
        elevation: 8.0,
      ),
      switchTheme : SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white70;
              }
              return null;
            }
        ),
        trackColor: MaterialStateProperty.resolveWith(
                (states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white54;
              }
              return null;
            }
        ),
      ),
    );
    return ThemeData.from(
      colorScheme: const ColorScheme.dark(
          primary: Colors.white, //Color(0xff212121),
          //primaryVariant: Color(0xff212121),
          //secondary: Colors.blueAccent,
          //secondaryVariant: Colors.blueAccent,
          //background: Colors.black,
          //surface: Color(0xff212121),
          //onPrimary: Colors.white,
          //onSurface: Colors.white
      ),
    ).copyWith(
      applyElevationOverlayColor: false,
      //appBarTheme: AppBarTheme(
        //color: primaryColor,
      //),
    );
  }

  Future<void> _saveThemeMode() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("themeMode", themeMode.index);
  }

  Future<int> _loadThemeMode() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt("themeMode") ?? ThemeMode.system.index;
  }

  Future<void> _saveThemeIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("themeIndex", themeIndex);
  }

  Future<int> _loadThemeIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt("themeIndex") ?? 0;
  }

  Future _init() async {
    int index = await _loadThemeMode();
    if (index == ThemeMode.light.index) {
      _themeMode = ThemeMode.light;
    } else if (index == ThemeMode.dark.index) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    _themeIndex = await _loadThemeIndex();
  }
}