import 'package:flutter/material.dart';
import 'package:product_app/login/register/register_page.dart';

import '../login/register/login_page.dart';





final Map<String, WidgetBuilder> routes = {

  LoginPage.routeName: (context) => LoginPage(),
    RegisterPage.routeName: (context) => RegisterPage(),


};
