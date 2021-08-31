import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/viewmodel/theme_view_model.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/res/colors.dart';
import 'package:flutter_app02/ui/page/main/main_page.dart';

void main() async {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeViewModel>.value(value: ThemeViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

//class MyApp extends StatelessWidget {

  //const MyApp({Key? key}) : super(key: key);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    //int index = await _getTheme();
    int index = await Provider.of<ThemeViewModel>(context, listen: false).getTheme();
    print("default theme ${index}");
    Provider.of<ThemeViewModel>(context, listen: false).setTheme(index);
  }

  Future<int> _getTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt("themeIndex") ?? 0;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    print("_MyAppState.build");

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => Consumer<ThemeViewModel>(
        builder: (context,model,child) {

          print("screenWidth: ${ScreenUtil().screenWidth}");
          print("screenHeight: ${ScreenUtil().screenHeight}");
          print("scaleWidth: ${ScreenUtil().scaleWidth}");
          print("scaleHeight: ${ScreenUtil().scaleHeight}");
          print("scaleText: ${ScreenUtil().scaleText}");

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor:  YColors.themeColor[model.index]["primaryColor"],
              appBarTheme: AppBarTheme(
                color: YColors.themeColor[model.index]["primaryColor"],
              ),
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              PickerLocalizationsDelegate.delegate,
              S.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const MainPage(),
          );
        },
      ),
    );
    /*
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height
        ),
        designSize: const Size(360, 690),
        orientation: Orientation.portrait
    );

    return Consumer<ThemeViewModel>(
      builder: (context,model,child) {
        //int indexa = model.index;
        //var priColor = YColors.themeColor[model.index]["primaryColor"];
        //print('ThemeProvide setTheme ${indexa} ${priColor}');
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor:  YColors.themeColor[model.index]["primaryColor"],
            appBarTheme: AppBarTheme(
              color: YColors.themeColor[model.index]["primaryColor"],
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            PickerLocalizationsDelegate.delegate,
            S.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const MainPage(),
        );
      },
    );
*/
  }



}


