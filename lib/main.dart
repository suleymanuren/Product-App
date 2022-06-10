import 'package:flutter/material.dart';
import 'package:product_app/login/register/login_page.dart';
import 'package:product_app/main_page/main_page.dart';
import 'package:product_app/provider/product_detail_provider.dart';
import 'package:product_app/provider/product_provider.dart';
import 'package:product_app/splash/splash_page.dart';
import 'package:product_app/ui/routes.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
String? userToken;

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userToken = prefs.getString('token');
  print(userToken);
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
      home: userToken=="süleyman" || userToken==null ? LoginPage() : MainPage(),
        routes: routes,
      ),
    );
  }
}