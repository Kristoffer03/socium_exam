
import 'package:flutter/material.dart';
import '../features/products/model/user_error.dart';

class AppError extends StatelessWidget{
  const AppError({Key? key, required this.error}) : super(key: key);
  final UserError? error;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Text(error?.errorResponse.toString()??"", style: TextStyle(color: Colors.red, fontSize: 18),),
      ),
    );
  }
}