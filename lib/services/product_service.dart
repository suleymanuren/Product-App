import 'dart:convert';
import '../models/product_models.dart';
import 'package:http/http.dart' as http;

class SearchApiService {
  AllProducts allProducts = AllProducts();

  Future getProducts() async {
    var url = 'https://assignment-api.piton.com.tr/api/v1/product/all';

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
    List<dynamic> body = json['products'];
    List<Products> searchProductsList =
        body.map((dynamic item) => Products.fromJson(item)).toList();
    //print("GELEN VERİ ADEDİ${searchProductsList.length}");
    allProducts.products = searchProductsList;

    return allProducts;
  }
}
