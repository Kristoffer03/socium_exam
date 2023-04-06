
import 'package:flutter/cupertino.dart';

class AppLoading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}