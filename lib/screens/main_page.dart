import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_models.dart';
import '../provider/product_provider.dart';
import '../services/product_service.dart';
import 'product_detail_page.dart';
import '../ui/responsive.dart';
Future<void> saveData(productID) async {
  // productID hafızaya yazdıran fonksiyon
  var sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('counter', productID);
  final String? counter = sharedPreferences.getString('counter');
  print(counter);
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String routeName = '/MainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AllProducts productStateModel = AllProducts();
  SearchApiService searchStateService = SearchApiService();
  AllProducts allProducts = AllProducts();
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    splashBeforeMain();
  }
  Future splashBeforeMain() async {
    
    Future.delayed(Duration(seconds: 3), () {
      
     Navigator.pushReplacementNamed(context, MainPage.routeName);

    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: FutureBuilder(
          future: context.read<ProductProvider>().searchProductStateRequest(),
          builder: (context, snapshot) {
            return Consumer<ProductProvider>(
                builder: (BuildContext context, value, Widget? child) {
              return ListView.builder(
                  itemCount: context
                          .read<ProductProvider>()
                          .productStateModel
                          .products
                          ?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: InkWell(
                        onTap: () {
                          //print('${value.productStateModel.products![index].id}');
                          final productID = value.productStateModel.products?[index].id.toString();
                          
                          saveData(productID);

                          Navigator.pushNamed(
                              context, ProductDetailPage.routeName, arguments: {
                            'id': value.productStateModel.products?[index].id
                                .toString()
                          });
                        },
                        child: Container(
                          height: SizeConfig.screenHeight * .38,
                          width: SizeConfig.screenWidth * .9,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 2),
                                  color: Colors.black.withOpacity(.4),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                  flex: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "static/${value.productStateModel.products?[index].id}.jpeg"),
                                          fit: BoxFit.cover),
                                      borderRadius: const BorderRadius.only(
                                          topRight: const Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0)),
                                    ),
                                  )),
                      
                              
                              Flexible(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    //   color: Colors.yellow,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Wrap(children: [Container(height: SizeConfig.screenHeight*.01,)],),
                                              Wrap(
                                                children: [
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            .65,
                                                    //color: Colors.red,
                                                    child: Text(
                                                      value
                                                              .productStateModel
                                                              .products?[index]
                                                              .name
                                                              .toString() ??
                                                          "boş değer döndü",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: SizeConfig
                                                                  .screenHeight *
                                                              .02,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            .05,
                                                    child: Icon(
                                                      Icons.access_time,
                                                      size: SizeConfig
                                                              .screenHeight *
                                                          .02,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            .5,
                                                    child: Text(
                                                      value
                                                              .productStateModel
                                                              .products?[index]
                                                              .timeStamp
                                                              .toString() ??
                                                          "boş değer döndü",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: SizeConfig
                                                                .screenHeight *
                                                            .013,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                children: [
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            .65,
                                                    //color: Colors.red,
                                                    child: Text(
                                                      "${value.productStateModel.products?[index].price.toString()}" +
                                                          " TL",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: SizeConfig
                                                                  .screenHeight *
                                                              .02,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              value
                                                          .productStateModel
                                                          .products?[index]
                                                          .description
                                                          .toString() !=
                                                      null
                                                  ? Wrap(
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              .6,
                                                          child: Text(
                                                            "${value.productStateModel.products?[index].description.toString()}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Wrap(
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              .6,
                                                          child: const Text(
                                                            "boş değer döndü",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              final id = value.productStateModel
                                                  .products?[index].id
                                                  .toString();

                                              Navigator.pushNamed(context,
                                                  ProductDetailPage.routeName,
                                                  arguments: {
                                                    'id': value
                                                        .productStateModel
                                                        .products?[index]
                                                        .id
                                                        .toString()
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30.0),
                                              child: Container(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        .05,
                                                width: SizeConfig.screenWidth *
                                                    .27,
                                                decoration: BoxDecoration(
                                                  color: Colors.red.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "DETAY",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: SizeConfig
                                                                .screenHeight *
                                                            .015,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            });
          }),
    );
  }
}
