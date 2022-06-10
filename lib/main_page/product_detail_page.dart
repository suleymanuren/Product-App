import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_models.dart';
import '../provider/product_provider.dart';
import '../ui/responsive.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ProductDetailPage extends StatefulWidget {
  static String routeName = "/ProductDetailPage";

  ProductDetailPage({Key? key}) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    AllProducts allProducts = AllProducts();
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: FutureBuilder(
            future: context.read<ProductProvider>().searchProductStateRequest(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //TÜRKÇE

              return Consumer<ProductProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                return Container(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          height: SizeConfig.screenHeight * .4,
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            //color: Colors.yellow,
                            image: DecorationImage(
                                image: AssetImage(
                                    "static/${value.productStateModel.products?[1].id.toString()}.jpeg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: SizeConfig.screenHeight * .65,
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, -2),
                                  color: Colors.black.withOpacity(.4),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.screenHeight * .02,
                                  ),
                                  Container(
                                    height: SizeConfig.screenHeight * .08,
                                    width: SizeConfig.screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: Container(
                                            color: Colors.white,
                                            height: 100,
                                            width: SizeConfig.screenWidth,
                                            child: Text(
                                              textAlign: TextAlign.start,
                                              " ${value.productStateModel.products?[1].name.toString()}",
                                              style: TextStyle(
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        .05,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * .02,
                                  ),
                                  Text(
                                    value.productStateModel.products?[2].price
                                                .toString() !=
                                            null
                                        ? "${value.productStateModel.products?[1].price.toString()}" +
                                            " TL"
                                        : "boş değer döndü",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.screenWidth * .04),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * .02,
                                  ),
                                  Container(
                                    height: SizeConfig.screenHeight * .03,
                                    width: double.infinity,
                                    // color: Colors.red,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: SizeConfig.screenWidth * .04,
                                        ),
                                        SizedBox(
                                          height: SizeConfig.screenHeight * .03,
                                          width: SizeConfig.screenWidth * .01,
                                        ),
                                        Container(
                                            height:
                                                SizeConfig.screenHeight * .06,
                                            width: SizeConfig.screenWidth * .8,
                                            // color: Colors.green,
                                            child: Text(
                                              " ${value.productStateModel.products?[1].timeStamp.toString() ?? "" + "boş değer döndü"}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      SizeConfig.screenWidth *
                                                          .04,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * .02,
                                  ),
                                  Container(
                                    color: Colors.red,
                                    height: SizeConfig.screenHeight * .35,
                                    width: SizeConfig.screenWidth,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      " ${value.productStateModel.products?[1].description.toString()}",
                                      style: TextStyle(
                                        fontSize: SizeConfig.screenWidth * .06,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.0,
                        left: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: SizeConfig.screenHeight * .05,
                            width: SizeConfig.screenWidth * .115,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.4),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(.4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            }),
      ),
    );
  }
}
