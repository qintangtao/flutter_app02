import 'package:flutter/material.dart';
import 'package:flutter_app02/generated/l10n.dart';


class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("_MinePageState.initState");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("_MinePageState.build");
    return Center(
      child: Text(S.of(context).mine,
        style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}