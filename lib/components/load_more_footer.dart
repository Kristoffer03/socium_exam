
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadMoreFooter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
      Widget body ;
      print("$mode");
      if(mode==LoadStatus.idle){
        body =  const Text("No more data");
      }
      else if(mode==LoadStatus.loading){
        body =  const CupertinoActivityIndicator();
      }
      else if(mode == LoadStatus.failed){
        body = const Text("Load Failed! Retry");
      }
      else if(mode == LoadStatus.canLoading){
        body = const Text("release to load more");
      }
      else{
        body = const Text("No more Data");
      }
      return SizedBox(
        height: 55.0,
        child: Center(child:body),
      );
    },

    );
  }
}