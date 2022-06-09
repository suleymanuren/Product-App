import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../models/product_detail_model.dart';

class SearchDetailApiService {
  ProductDetailModel productDetail = ProductDetailModel();

  Future getProductDetail() async {
    var url = 'https://assignment-api.piton.com.tr/api/v1/product/get/2';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'access-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1bGV5bWFudXJlbjA3QGdtYWlsLmNvbSIsImlhdCI6MTY1NDY1NTIzNSwiZXhwIjoxNjgwNTc1MjM1fQ.L3t4E-x-IWlT1wjRx3WNzp-ecX-MsntIl-tRiD9zZmg',
        'Content-Type': 'application/json-patch+json',
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);

    List<dynamic> productList = json['product'];
    List<Product> product =
        productList.map((dynamic item) => Product.fromJson(item)).toList();

    return productDetail;
  }
}
