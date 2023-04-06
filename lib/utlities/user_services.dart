import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:socium_exam/features/products/model/product_details_model.dart';
import '../features/products/model/product_list_model.dart';
import 'api_status.dart';
import 'constants.dart';

class UserServices{
  static Future<Object> getProductListData({int skip = 0}) async{
    try{
      var response =  await http.get(Uri.https("dummyjson.com", "/products",{"limit": "10" , "skip": "$skip", "select":"title,price,thumbnail,stock,discountPercentage"}));

      if(response.statusCode == 200){

        return Success(response: ProductListModel.fromJson(jsonDecode(response.body)));
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> getProductDetailsData(String productId) async{
    try{
      var response =  await http.get(Uri.https("dummyjson.com", "/products/$productId"));

      if(response.statusCode == 200){

        return Success(response: ProductDetailsModel.fromJson(jsonDecode(response.body)));
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}