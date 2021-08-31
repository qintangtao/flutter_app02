import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  int _currentIndex = 0;

  String _title = '';

  final _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = <Widget>[
    HomePage(),
    CategoryPage(),
    MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    /*
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height
        ),
        designSize: const Size(360, 690),
        orientation: Orientation.portrait
    );
  */
    if (_title.isEmpty) {
      _title = S.of(context).home;
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: PageView(
        onPageChanged: _pageChange,
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar (
        items: [
          BottomNavigationBarItem (icon: const Icon(Icons.home), label: S.of(context).home),
          BottomNavigationBarItem (icon: const Icon(Icons.category), label: S.of(context).category),
          BottomNavigationBarItem (icon: const Icon(Icons.settings), label: S.of(context).mine),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));},//_showToast,
        tooltip: '点击选中最后一个',
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: _showDrawer(),
    );
  }

  Widget _showDrawer() {
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
            leading: const Icon(Icons.color_lens),
            title: Text(S.of(context).theme),
            trailing:const  Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              _showThemeDialog();
            },
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
            child: Container(
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
                      Provider.of<ThemeViewModel>(context, listen: false).setTheme(position);
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

  void _showToast() {
    Fluttertoast.showToast(msg: "选中",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Theme.of(context).primaryColor,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
    _onItemTapped(2);
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0:
          _title = S.of(context).home;
          break;
        case 1:
          _title = S.of(context).category;
          break;
        case 2:
          _title = S.of(context).mine;
          break;
      }
    });
  }
}