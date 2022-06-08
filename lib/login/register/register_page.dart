import 'package:flutter/material.dart';
import 'package:product_app/ui/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ui/validators.dart';
import 'login_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);
static String routeName = '/RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
var maskFormatter = new MaskTextInputFormatter(mask: '+## (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formGlobalKey,
        child: Padding(
            padding:  EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding:  EdgeInsets.all(10),
                    child:  Text(
                      'E-Katalog',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding:  EdgeInsets.all(10),
                    child:  Text(
                      'KAYIT OL',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding:  EdgeInsets.all(10),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'İsim',
                      ),
                    ),
                  ),
                ),                
                SizedBox(height: SizeConfig.screenHeight*.015,),          


                Container(
                  padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
inputFormatters: [],
                    obscureText: false,
                    controller: surnameController,
                    decoration:  InputDecoration(
                      
                      border: OutlineInputBorder(),
                      labelText: 'Soyisim',
                    ),
                  ),
                ),                
                SizedBox(height: SizeConfig.screenHeight*.015,),          

                                Container(
                  padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
       keyboardType: TextInputType.number,
inputFormatters: [maskFormatter],
                    obscureText: false,
                    controller: telephoneController,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefon No',
                    ),
                  ),
                ),                SizedBox(height: SizeConfig.screenHeight*.015,),          

                                Container(
                  padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (input) => input!.isValidEmail()
                          ? null
                          : "Geçerli bir email giriniz",
                    obscureText: false,
                    controller: emailController,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mail',
                    ),
                  ),
                ),                SizedBox(height: SizeConfig.screenHeight*.015,),          

                                Container(
                  padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                             obscureText: _isObscure1,
                    validator: (input) => input!.isValidPassword()
                        ? null
                        : "Şifreniz 6 ila 20 karakter arasında olmalı ve harf içermelidir",
                    controller: passwordController,
                    decoration:  InputDecoration(
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
                      border: OutlineInputBorder(),
                      labelText: 'Şifrenizi Giriniz',
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*.015,),          
                                   Container(
                  padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: _isObscure2,
                    validator: (input) => input!.isValidPassword()
                        ? null
                        : "Şifreniz 6 ila 20 karakter arasında olmalı ve harf içermelidir",
                    controller: repasswordController,
                    decoration:  InputDecoration(
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
                      border: OutlineInputBorder(),
                      labelText: 'Şifrenizi Tekrar Giriniz',
                    ),
                  ),
                ),
SizedBox(height: SizeConfig.screenHeight*.075,),
                Container(
                    height: 50,
                    padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child:  Text('Kayıt Ol'),
                      onPressed: () {

                        print(emailController.text);
                        print(passwordController.text);
                      },
                    )),
                Row(
                  children: <Widget>[
                     Text('Hesabınız var mı?'),
                    TextButton(
                      child:  Text(
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


}
