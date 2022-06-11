import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:product_app/login/register/register_page.dart';
import 'package:product_app/main.dart';
import 'package:product_app/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../ui/user_fail_login_alert.dart';
import '../../ui/responsive.dart';
import '../../ui/validators.dart';
import 'package:http/http.dart' as http;

String? userToken;
const snackBar = SnackBar(
  content: Text('Ürün Sepete Eklendi'),
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String routeName = '/LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

_storeOnboardInfo(userToken) async {
  print("Shared pref called");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', userToken);
  print(prefs.getString('token'));
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure2 = true;
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Form(
        key: _formKey,
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
                  child: TextFormField(
                    validator: (val) {
                      if (!val!.isValidEmail()) {
                        return 'Geçerli bir email giriniz';
                      }
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (val) {
                      if (!val!.isValidPassword()) {
                        return 'Şifreniz 6 ila 20 karakter arasında olmalı ve harf içermelidir';
                      }
                    },
                    obscureText: _isObscure2, //şifre görümünü kapatıyor
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
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
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: const Color(0xff00C8E8),
                        value: _isChecked,
                        onChanged: _handleRemeberme),
                    const SizedBox(width: 10.0),
                    const Text("Beni Hatırla",
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //String? userToken;
                          Map data = {
                            'password': passwordController.text,
                            'email': emailController.text,
                          };
                          //print(data);

                          String body = json.encode(data);
                          var url =
                              'https://assignment-api.piton.com.tr/api/v1/user/login';
                          var response = await http.post(
                            Uri.parse(url),
                            body: body,
                            headers: {
                              "Content-Type": "application/json",
                              "accept": "application/json",
                              "Access-Control-Allow-Origin": "*"
                            },
                          );
                          //print("${response.body}");
                          if (response.statusCode == 200) {
                            setState(() {
                              Map<String, dynamic> json =
                                  jsonDecode(response.body);
                              if (response.body.length > 15) {
                                var userToken = json['token'];
                                //BAŞARISIZ GİRİŞLERDE "token" BOŞ DÖNDÜĞÜ İÇİN GİRİŞİN BAŞARILI OLUP OLMADIĞINI ANCAK DÖNEN VERİRİN UZUNLUĞU İLE KIYASLAYABİLCEĞİMİ DÜŞÜNDÜM
                                // BU ŞEKİLDE KONTROL İLE DÖNEN VERİ 15 TEN UZUN OLDUĞU SÜRECE BAŞARILI GİRİŞ OLARAK GÖRÜLÜP HEM LOGİN İŞLEMİ TAMAMLANIYOR HEM DE
                                // KULLANICI GİRİŞİNDEN DÖNEN TOKEN HAFIZAYA KAYDEDİLİYOR
                                _storeOnboardInfo(userToken);

                                return userToken;
                              } else {}
                            });
                          } else {}

                          if (response.body.length < 20) {
                            //print("giriş başarısız");

                            return showAlertDialog(context);
                          } else if (_isChecked == true) {
                            //BENİ HATIRLA KONTROLÜ SAĞLANIYOR VE KULLANICI BENİ HATIRLAYI İŞARETLEDİYSE GİRİŞ DEVAM EDİYOR

                            print("token kaydedildi");
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                message: "Giriş başarılı!!",
                              ),
                            );
                            print(
                                "TOKEN BENİ HATIRLADAN DOLAYI HAFIZADA DURMAYA DEVAM EDİYOR");
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pushNamed(context, MainPage.routeName);
                            });

                            //print("giriş başarılı");
                          } else if (_isChecked == false) {
                            //BENİ HATIRLA KONTROLÜ SAĞLANIYOR VE KULLANICI BENİ HATIRLAYI İŞARETLEMEDİYSE KAYDEDİLEN SHARED CLEAR İLE TEMİZLENİYOR
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            print(
                                "TOKEN BENİ HATIRLA İŞARETLENMEDİĞİNDEN DOLAYI HAFIZADAN ÖLDÜRÜLÜYOR");

                            print("token kaydedilmedi");
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                message: "Giriş başarılı!!",
                              ),
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pushNamed(context, MainPage.routeName);
                            });

                            //print("giriş başarılı");
                          }
                        } else {
                          //print("başarısız");
                        }
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
                        Navigator.pushNamed(context, RegisterPage.routeName);
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
                        Navigator.pushNamed(context, MainPage.routeName);
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

  void _handleRemeberme(bool? checkBoxState) async {
    //print("Handle Rember Me");
    _isChecked = checkBoxState!;
    print("Shared pref called");

    _storeOnboardInfo(userToken);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", checkBoxState);
        prefs.setString('password', passwordController.text);
      },
    );
    print(prefs.getString('token'));

    setState(() {
      print(prefs.getString('token'));

      _isChecked = checkBoxState;
    });
  }
}
