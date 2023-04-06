import 'package:flutter/material.dart';

import '../features/products/product_details_view.dart';
import '../features/products/product_list_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProductListView.route:
        return MaterialPageRoute<dynamic>(builder: (_) => const ProductListView());

      case ProductDetailsView.route:
        final args = settings.arguments as ProductDetailsViewArgs;
        return MaterialPageRoute<dynamic>(
            builder: (_) => ProductDetailsView(
              args: args,
            ));

      default:
        return MaterialPageRoute<dynamic>(builder: (_) {
          return Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          );
        });
    }
  }
}
