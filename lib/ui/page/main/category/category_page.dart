import 'package:flutter/material.dart';
import 'package:flutter_app02/generated/l10n.dart';


class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("_CategoryPageState.initState");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("_CategoryPageState.build");
    return Center(
      child: Text(S.of(context).category,
        style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}