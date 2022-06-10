import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:product_app/models/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ProductDetailsApiService {
  Future<ProductDetailModel> getProductDetailModel() async {
        var sharedPreferences = await SharedPreferences.getInstance(); // product id çekmek için
    final String? counter = sharedPreferences.getString('counter'); // product id çekmek için
    var url = 'https://assignment-api.piton.com.tr/api/v1/product/get/$counter';
print("kaydedilen product id $counter");


    ProductDetailModel productDetailTest = ProductDetailModel();

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'access-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1bGV5bWFudXJlbjA3QGdtYWlsLmNvbSIsImlhdCI6MTY1NDY1NTIzNSwiZXhwIjoxNjgwNTc1MjM1fQ.L3t4E-x-IWlT1wjRx3WNzp-ecX-MsntIl-tRiD9zZmg',
        'Content-Type': 'application/json-patch+json',
      },
    );
    if (response.statusCode == 200) {

      Map<String, dynamic> json =jsonDecode(response.body);
      productDetailTest.product = Product.fromJson(json['product']);


      return productDetailTest;
    }
    throw Exception();
  }
}

