import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socium_exam/features/products/view_model/product_view_model.dart';

import '../../components/app_error.dart';
import '../../components/app_loading.dart';
import '../../components/shimmer_loader.dart';
import '../../utlities/asset_images.dart';
import 'model/product_list_model.dart';

class ProductDetailsViewArgs {
  ProductDetailsViewArgs({required this.selectedProduct});

  Products? selectedProduct;
}

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({Key? key, required this.args}) : super(key: key);
  final ProductDetailsViewArgs args;
  static const String route = 'product-details-page';

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ProductViewModel>(context, listen: false)
            .fetchProductDetailsData(
                widget.args.selectedProduct?.id.toString() ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.args.selectedProduct?.title}"),
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

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                fit: BoxFit.scaleDown,
                                imageUrl: productViewModel
                                        .productDetailsModel?.thumbnail ??
                                    "",
                                placeholder: (context, string) {
                                  return const ShimmerLoader();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            productViewModel.productDetailsModel?.title ?? "",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${productViewModel.productDetailsModel?.description}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                "${productViewModel.productDetailsModel?.rating}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ])),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) =>
                        CachedNetworkImage(
                          fit: BoxFit.contain,
                            imageUrl: productViewModel
                                    .productDetailsModel?.images[index] ??
                                ""),
                    childCount: productViewModel
                        .productDetailsModel?.images.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10.0,
                  spreadRadius: 10.0,
                  offset: Offset(2.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$${productViewModel.productDetailsModel?.price.toString()}",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "-${productViewModel.productDetailsModel?.discountPercentage.toString()}\%",
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
