import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/res/colors.dart';
import 'package:flutter_app02/viewmodel/theme_view_model.dart';
import 'home/home_page.dart';
import 'category/category_page.dart';
import 'mine/mine_page.dart';
import '../login/login_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;

  String? title;

  //final titleNotifier = ValueNotifier<String>('');

  PageController? pageController;// = PageController(initialPage: 0);

  final pages = <Widget>[
    const HomePage(),
    const CategoryPage(),
    const MinePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('_MainPageState initState');
    pageController ??= PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    print('_MainPageState build');
    //Theme.of(context)  会导致重复build，原因未知
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title ?? S.of(context).home),
        /*
        title: ValueListenableBuilder<String>(
          valueListenable: titleNotifier,
          builder: (context, value, child) {
            return Text(value);
          },
        ),
         */
      ),
      body: PageView(
        onPageChanged: _onPageChanged,
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar (
        items: [
          BottomNavigationBarItem (icon: const Icon(Icons.home), label: S.of(context).home),
          BottomNavigationBarItem (icon: const Icon(Icons.category), label: S.of(context).category),
          BottomNavigationBarItem (icon: const Icon(Icons.settings), label: S.of(context).mine),
        ],
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));},
        //tooltip: '点击选中最后一个',
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: _showDrawer(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController?.dispose();
    super.dispose();
  }

  Widget _showDrawer() {
    final ThemeViewModel themeViewModel = ThemeViewModel.of(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: GestureDetector(
                child: ClipOval(
                  child: Image.network(
                      "https://avatars3.githubusercontent.com/u/19725223?s=400&u=f399a2d73fd0445be63ee6bc1ea4a408a62454f5&v=4"
                  ),
                ),
              ),
              accountName: Text(
                "Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(22),
                ),
              ),
              accountEmail: const Text("wanandroid@qq.com")
          ),

          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: Text(S.of(context).favorite),
            trailing: const Icon(Icons.chevron_right),
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(S.of(context).about),
            trailing: const Icon(Icons.chevron_right),
          ),

          ListTile(
            leading: const Icon(Icons.share),
            title: Text(S.of(context).share),
            trailing: const Icon(Icons.chevron_right),
          ),

          ListTile(
            enabled: themeViewModel.themeMode == ThemeMode.light,
            leading: const Icon(Icons.color_lens),
            title: Text(S.of(context).theme),
            trailing:const  Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              _showThemeDialog();
            },
          ),

          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('夜间模式'),
            //trailing:const  Icon(Icons.chevron_right),
            trailing: Switch(
                value: themeViewModel.themeMode == ThemeMode.dark,
                //activeColor: Theme.of(context).primaryColor,
                onChanged: (value) => {
                  if (value) {
                      themeViewModel.themeMode = ThemeMode.dark
                  } else {
                      themeViewModel.themeMode = ThemeMode.light
                  }
                },
            ),
            /*
            onTap: () {
              //final ThemeViewModel themeViewModel = Provider.of<ThemeViewModel>(context, listen: false);
              final ThemeViewModel themeViewModel = ThemeViewModel.of(context);
              if (themeViewModel.themeMode == ThemeMode.light) {
                themeViewModel.themeMode = ThemeMode.dark;
              } else {
                themeViewModel.themeMode = ThemeMode.light;
              }
              Navigator.of(context).pop();
            },*/
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.block),
            title: Text(S.of(context).logout),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              _showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).prompt),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).cancel,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).confirm,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
            )
          ],
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(S.of(context).logout_prompt),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemeDialog() {
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).switch_theme),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).close,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
            )
          ],
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: YColors.themeColor.keys.length,
                itemBuilder: (BuildContext context, int position) {
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.only(bottom: 15),
                      color: YColors.themeColor[position]["primaryColor"],
                    ),
                    onTap: () {
                      //Provider.of<ThemeViewModel>(context, listen: false).themeIndex = position;
                      ThemeViewModel.of(context).themeIndex = position;
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    pageController?.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int index) {
    if (currentIndex == index) return;
    print('_onPageChanged ${index}');
    setState(() {
      currentIndex = index;
      switch(index) {
        case 0:
          title = S.of(context).home;
          break;
        case 1:
          title = S.of(context).category;
          break;
        case 2:
          title = S.of(context).mine;
          break;
      }
    });

    /*
    currentIndex = index;
    switch(index) {
      case 0:
        title = S.of(context).home;
        break;
      case 1:
        title = S.of(context).category;
        break;
      case 2:
        title = S.of(context).mine;
        break;
    }
    titleNotifier.value = title!;
     */

  }
}