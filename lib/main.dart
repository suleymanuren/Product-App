import 'package:flutter/material.dart';
import 'package:product_app/login/register/login_page.dart';
import 'package:product_app/provider/product_detail_provider.dart';
import 'package:product_app/provider/product_provider.dart';
import 'package:product_app/ui/routes.dart';
import 'package:provider/provider.dart';

import 'main_page/main_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: routes,
      ),
    );
  }
}
