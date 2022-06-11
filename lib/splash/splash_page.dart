import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/register/login_page.dart';
import '../main_page/main_page.dart';
import '../ui/responsive.dart';

class SplashPage extends StatefulWidget {
  
  static String routeName = "/SplashPage";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    saveSharedLoggingControl();
  }
  


  Future saveSharedLoggingControl() async {
    
    Future.delayed(Duration(seconds: 3), () {
      
     Navigator.pushReplacementNamed(context, LoginPage.routeName);

    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.97),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * .3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.screenHeight * .2,
                      width: SizeConfig.screenWidth - 100,
                      decoration: const BoxDecoration(
                        image:  DecorationImage(
                            image: AssetImage("assets/images/piton_logo.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * .3,
                child: Text(
                  "Piton",
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "primaryFont",
                    fontSize: SizeConfig.screenWidth * .06,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
