import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product_app/login/register/register_page.dart';
import 'package:product_app/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product_models.dart';
import '../../ui/responsive.dart';
import '../../ui/validators.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String routeName = '/LogiPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AllProducts allProducts = AllProducts();

    return Scaffold(
      body: Form(
        key: formGlobalKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.screenHeight * .05,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'E-Katalog',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Giriş Yap',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    child: TextFormField(
                      validator: (input) => input!.isValidEmail()
                          ? null
                          : "Geçerli bir email giriniz",
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (input) => input!.isValidPassword()
                        ? null
                        : "Şifreniz 6 ila 20 karakter arasında olmalı ve harf içermelidir",
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Color(0xff00C8E8),
                        value: _isChecked,
                        onChanged: _handleRemeberme),
                    SizedBox(width: 10.0),
                    Text("Beni Hatırla",
                        style: TextStyle(
                            color: Color(0xff646464),
                            fontSize: 12,
                            fontFamily: 'Rubic')),
                  ],
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        setState(() {});
                        login(
                          passwordController.text,
                          emailController.text,
                        );

                        print(emailController.text);
                        print(passwordController.text);
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Hesabınız yok mu?'),
                    TextButton(
                      child: const Text(
                        'Kayıt Ol',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, RegisterPage.routeName);
                      },
                    ),
                                       
                  ],
                  
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                   Row(
                  children: <Widget>[
            const Text('Test aşamasında'),
                    TextButton(
                      child: const Text(
                        'Doğrudan giriş',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, MainPage.routeName);
                      },
                    )
                                       
                  ],
                  
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
     
              ],
            )),
      ),
    );
  }

  void _handleRemeberme(bool? checkBoxState) {
    print("Handle Rember Me");
    _isChecked = checkBoxState!;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", checkBoxState);
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = checkBoxState;
    });
  }

  login(String password, email) async {
    String userToken;
    Map data = {
      'password': passwordController.text,
      'email': emailController.text,
    };
    print(data);

    String body = json.encode(data);
    var url = 'https://assignment-api.piton.com.tr/api/v1/user/login';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    print("${response.body}");
    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> json = jsonDecode(response.body);
        var userToken = json['token'];
        print("${"${userToken}"}");

        return userToken;
      });
    } else {
      print('error');
    }
  }
}
