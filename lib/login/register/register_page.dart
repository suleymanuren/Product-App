import 'package:flutter/material.dart';
import 'package:product_app/ui/responsive.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../screens/main_page.dart';
import '../../ui/register_password_doesnt_match.dart';
import '../../ui/validators.dart';
import 'login_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'dart:convert';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static String routeName = '/RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

const snackBar = SnackBar(
  content: Text('Ürün Sepete Eklendi'),
);

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure1 = true;
  bool _isObscure2 = true;

  var maskFormatter =  MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('AppBar'),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }), 
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'E-Katalog',
                      style:  TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'KAYIT',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen isim giriniz';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'İsim',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .015,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen soyisim giriniz';
                      }
                      return null;
                    },
                    obscureText: false,
                    controller: surnameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Soyisim',
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .015,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen telefon numarası giriniz';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [maskFormatter],
                    obscureText: false,
                    controller: telephoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefon No',
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .015,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (input) => input!.isValidEmail()
                        ? null
                        : "Geçerli bir email giriniz",
                    obscureText: false,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mail',
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .015,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: _isObscure1,
                    validator: (input) => input!.isValidPassword()
                        ? null
                        : "Şifreniz 6 ila 20 karakter arasında olmalı ve harf içermelidir",
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure1
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure1 = !_isObscure1;
                            });
                          }),
                      border: const OutlineInputBorder(),
                      labelText: 'Şifrenizi Giriniz',
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .015,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: _isObscure2,
                    validator: (input) => input!.isValidPassword()
                        ? null
                        : "Şifreniz 6 ila 20 karakter arasında olmalı ve harf içermelidir",
                    controller: repasswordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure2
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          }),
                      border: const OutlineInputBorder(),
                      labelText: 'Şifrenizi Tekrar Giriniz',
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .04,
                ),
                Container(
                    height: SizeConfig.screenHeight * .06,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Kayıt Ol'),
                      onPressed: () async {
                        setState(() {});
                        if (_formKey.currentState!.validate()) {
                          if (nameController.value.text == "" ||
                              surnameController.value.text == "" ||
                              telephoneController.value.text == "" ||
                              emailController.value.text == "" ||
                              passwordController.value.text == "" ||
                              repasswordController.value.text == "") {
                            //print("hata");
                          } else if (passwordController.text !=
                              repasswordController.text) {
                            //print("form düzgün ama şifreler eşleşmedi");
                            return showAlertDialogNotMatchPassword(context);
                          } else {
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                message: "Kayıt başarılı!!",
                              ),
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pushReplacementNamed(
                                  context, MainPage.routeName);
                            });

                            register(nameController.text,
                                passwordController.text, emailController.text);
                          }
                        } else {
                          //print("hata");
                        }
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Hesabınız var mı?'),
                    TextButton(
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.routeName);
                        //signup screen
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

  register(String name, password, email) async {
    Map data = {
      'name': nameController.text,
      'password': passwordController.text,
      'email': emailController.text,
    };
    //print(data);

    String body = json.encode(data);
    var url = 'https://assignment-api.piton.com.tr/api/v1/user/register';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    //print(response.body);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      //Or put here your next screen using Navigator.push() method
      //print('success');
    } else {
      //print('error');
    }
  }
}
