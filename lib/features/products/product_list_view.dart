
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socium_exam/features/products/product_details_view.dart';
import 'package:socium_exam/features/products/view_model/product_view_model.dart';
import 'package:socium_exam/features/products/widgets/product_item.dart';
import '../../components/app_error.dart';
import '../../components/app_loading.dart';
import '../../components/load_more_footer.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  static const String route = 'product-list-page';

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: _ui(productViewModel, context),
    );
  }

  _ui(ProductViewModel productViewModel, BuildContext context) {
    if (productViewModel.loading) {
      return AppLoading();
    }
    if (productViewModel.userError != null) {
      return AppError(error: productViewModel.userError);
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SmartRefresher(
        controller: productViewModel.refreshController,
        onRefresh: () => fetchNewData(productViewModel),
        enablePullUp: true,
        enablePullDown: true,
        onLoading: () => fetchMoreData(productViewModel),
        footer: LoadMoreFooter(),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 40,
          ),
          itemBuilder: (context, index) {
            return ProductItem(
                products: productViewModel.productListModel?.products[index],
                onViewItem: (){
                  productViewModel.setLoading(true);
                  Navigator.pushNamed(
                      context, ProductDetailsView.route,
                      arguments: ProductDetailsViewArgs(
                          selectedProduct:
                          productViewModel.productListModel?.products[index]));
                });
          },
          itemCount: productViewModel.productListModel?.products.length ?? 0,
        ),
      ),
    );
  }

  fetchNewData(ProductViewModel productViewModel){
    productViewModel.fetchProductNewData();
  }
  fetchMoreData(ProductViewModel productViewModel){
    productViewModel.fetchProductNewData(loadMore: true);
  }
}
