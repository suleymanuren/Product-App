import 'package:flutter/material.dart';
import 'package:product_app/ui/responsive.dart';
import 'package:product_app/ui/routes.dart';

import 'login/register/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: routes,
    );
  }
}

