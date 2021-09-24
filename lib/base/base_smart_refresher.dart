import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseSmartRefresher extends StatefulWidget {

  const BaseSmartRefresher({
    Key? key,
    required this.controller,
    this.child,
    this.onRefresh,
    this.onLoading}) : super(key: key);

  final RefreshController controller;

  final Widget? child;

  final VoidCallback? onRefresh;

  final VoidCallback? onLoading;

  @override
  State<StatefulWidget> createState() => _BaseSmartRefresherState();
}

class _BaseSmartRefresherState extends State<BaseSmartRefresher> {

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          builder: (BuildContext context,LoadStatus? mode){
            Widget body ;
            if(mode==LoadStatus.idle) {
              body = const Text("pull up load");
            } else if(mode==LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if(mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if(mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: widget.controller,
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoading,
        child: widget.child,
    );
  }


}