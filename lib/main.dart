import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socium_exam/features/products/view_model/product_view_model.dart';
import 'package:socium_exam/utlities/app_router.dart';

import 'features/products/product_list_view.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    final _navigatorKey = GlobalKey<NavigatorState>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>(
          create: (_) => ProductViewModel(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: MaterialApp(
          title: "Socium",
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(scaffoldBackgroundColor: Colors.white),
          home: Navigator(
            key: _navigatorKey,
            initialRoute: ProductListView.route,
            onGenerateRoute: AppRouter.generateRoute,
          ),
        ),
      ),
    );
  }
}
