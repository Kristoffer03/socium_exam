
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socium_exam/features/products/model/product_details_model.dart';

import '../../../utlities/api_status.dart';
import '../../../utlities/user_services.dart';
import '../model/product_list_model.dart';
import '../model/user_error.dart';

class ProductViewModel extends ChangeNotifier{
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _loading = false;
  int _skip = 0;
  ProductListModel? _productListModel;
  ProductDetailsModel? _productDetailsModel;
  UserError? _userError;
  final _refreshController = RefreshController();

  TextEditingController get phoneNumberController => _phoneNumberController;
  bool get loading => _loading;
  int get skip => _skip;
  ProductListModel? get productListModel => _productListModel;
  ProductDetailsModel? get productDetailsModel => _productDetailsModel;
  UserError? get userError => _userError;
  RefreshController get refreshController => _refreshController;



  setLoading(bool loading) async{
    _loading = loading;
    notifyListeners();
  }

  ProductViewModel(){
    fetchProductData();
  }

  setRefreshController(){
    refreshController.loadComplete();
    refreshController.refreshCompleted();
    notifyListeners();
  }

  setProductListModelData(ProductListModel productListModel,
      {bool loadMore = false}){
    if(loadMore){
      _productListModel?.products.addAll(productListModel.products);
    }else{
      _productListModel = productListModel;
    }
    notifyListeners();
  }

  void setProductDetailsModelData(ProductDetailsModel productDetailsModel) {
    _productDetailsModel = productDetailsModel;
    notifyListeners();
  }

  setUserError(UserError  userError){
    _userError = userError;
  }

  fetchProductData() async{
    setLoading(true);
    var response = await UserServices.getProductListData();
    if(response is Success){
      setProductListModelData(response.response as ProductListModel);
    }
    if(response is Failure){
      UserError userError = UserError(code: response.code??-1, errorResponse: response.errorResponse);
      setUserError(userError);
    }
    setLoading(false);
  }

  fetchProductNewData({bool loadMore = false}) async{

    if(loadMore){
      _skip +=10;
    }else{
      _skip = 0;
    }

    var response = await UserServices.getProductListData(skip: _skip);
    if(response is Success){
      setProductListModelData(response.response as ProductListModel, loadMore: loadMore);
    }
    if(response is Failure){
      UserError userError = UserError(code: response.code??-1, errorResponse: response.errorResponse);
      setUserError(userError);
    }
    setRefreshController();
  }

  fetchProductDetailsData(String productId) async{
    print("FETCH PRODUCT DETAILS ");
    setLoading(true);
    var response = await UserServices.getProductDetailsData(productId);
    if(response is Success){
      setProductDetailsModelData(response.response as ProductDetailsModel);
    }
    if(response is Failure){
      UserError userError = UserError(code: response.code??-1, errorResponse: response.errorResponse);
      setUserError(userError);
    }
    setLoading(false);
  }



}