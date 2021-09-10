import 'package:flutter/material.dart';
import 'package:flutter_app02/generated/l10n.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("_HomePageState.initState");
  }

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("_HomePageState.build");
    return Center(
      child: Column(
        children: [
          Text(S.of(context).home,
            style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),
          ),
          Switch(
            value: selected,
            onChanged: (value){
              setState(() {
                selected = value;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}