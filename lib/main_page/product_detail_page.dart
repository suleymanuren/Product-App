import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';

import '../models/product_models.dart';
import '../provider/product_provider.dart';
import '../ui/responsive.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ProductDetail extends StatefulWidget {
  static String routeName = "/ProductDetail";

  ProductDetail({Key? key}) : super(key: key);



  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //TÜRKÇE

              return Consumer<ProductProvider>(
                builder: (
                  context,
                  value,
                  child,
                ) {
                  return Stack(
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
                                    "static/${value.productStateModel.products?[2].id}.jpeg"),
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
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, -2),
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
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    height: SizeConfig.screenHeight * .043,
                                    width: SizeConfig.screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: Container(
                                            child: Text(
                                              "${value.productStateModel.products?[2].name.toString() ?? "boş değer döndü"}",
                                              //arg['shortTitle'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .screenWidth *
                                                      .07 //,overflow: TextOverflow.ellipsis
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    value.productStateModel.products?[2].price
                                                .toString() !=
                                            null
                                        ? "${value.productStateModel.products?[2].price.toString()}" +
                                            " TL"
                                        : "boş değer döndü",

                                    //"${arg['price']} tl den başlayan fiyatlarla",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.screenWidth * .04),
                                  ),
                                  SizedBox(
                                    height: 10.0,
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
                                          width: 5.0,
                                        ),
                                        Container(
                                            height:
                                                SizeConfig.screenHeight * .03,
                                            width: SizeConfig.screenWidth * .8,
                                            // color: Colors.green,
                                            child: Text(
                                              " ${value.productStateModel.products?[2].timeStamp.toString() ?? "" + "boş değer döndü"}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
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
                                    height: 10.0,
                                  ),
                                  Container(
                                    color: Colors.red,
                                    height: 300,
                                    width: SizeConfig.screenWidth,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      " ${value.productStateModel.products?[2].description.toString()}",
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
                                  offset: Offset(0, 2),
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(.4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
