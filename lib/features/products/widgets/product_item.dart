import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../components/shimmer_loader.dart';
import '../model/product_list_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key, required this.products, required this.onViewItem})
      : super(key: key);

  final Products? products;
  final VoidCallback onViewItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewItem,
      child: Container(
        color: Colors.white,
        height: 120,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                imageUrl: products?.thumbnail ?? "",
                placeholder: (context, string) {
                  return const ShimmerLoader();
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products?.title ?? "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Stocks left: ${products?.stock}",
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${products?.price.toString()}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "-${products?.discountPercentage.toString()}\%",
                              style: const TextStyle(fontSize: 14, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
