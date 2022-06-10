import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:product_app/models/product_detail_model.dart';
import 'package:product_app/provider/product_detail_provider.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';

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
    

    ProductDetailModel productDetailModel = ProductDetailModel();
    SizeConfig().init(context);
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: FutureBuilder(
                future: context
                    .read<ProductDetailProvider>()
                    .denemeStateRequest(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<ProductDetailProvider>(
                    builder: (context, value, child) {
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
                                        "static/${value.denemeStateModel.product?.id.toString()}.jpeg"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        height: SizeConfig.screenHeight * .06,
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
                                                  " ${value.denemeStateModel.product?.name.toString()}",
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
                                        value.denemeStateModel.product?.price
                                                    .toString() !=
                                                null
                                            ? "${value.denemeStateModel.product?.price.toString()}" +
                                                " TL"
                                            : "boş değer döndü",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                SizeConfig.screenWidth * .04),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.screenHeight * .02,
                                      ),
                                      Container(
                                        height: SizeConfig.screenHeight * .03,
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size:
                                                  SizeConfig.screenWidth * .04,
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Container(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        .06,
                                                width:
                                                    SizeConfig.screenWidth * .8,
                                                child: Text(
                                                  " ${value.denemeStateModel.product?.timeStamp.toString() ?? "" + "boş değer döndü"}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          .04,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        color: Colors.red,
                                        height: SizeConfig.screenHeight * .35,
                                        width: SizeConfig.screenWidth,
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          " ${value.denemeStateModel.product?.description.toString()}",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.screenWidth * .06,
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
                          Positioned(
                            top: SizeConfig.screenHeight * .28,
                            right: SizeConfig.screenWidth * .05,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: SizeConfig.screenHeight * .055,
                                width: SizeConfig.screenWidth * .13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        color: Colors.blue.withOpacity(.7),
                                      ),
                                    ]),
                                child: Center(
                                  child: Icon(
                                    Icons.favorite,
                                    size: SizeConfig.screenHeight * .027,
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
                })));
  }
}
