import 'package:flutter/material.dart';
import 'package:flutter_app02/generated/l10n.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initAsync();
    print("_HomePageState.initState");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("_HomePageState.build");
    return Center(
      child: Text(S.of(context).home,
        style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}