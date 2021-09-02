import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/viewmodel/theme_view_model.dart';
import 'package:flutter_app02/generated/l10n.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ThemeViewModel>(context, listen: false).init();
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
            themeMode: model.themeMode,
            theme: model.lightTheme,
            darkTheme: model.darkTheme,
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

  }

}


