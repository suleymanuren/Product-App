import 'package:flutter/cupertino.dart';
import 'package:product_app/models/product_detail_model.dart';

import '../services/product_detail_service.dart';

class ProductDetailProvider extends ChangeNotifier {
  ProductDetailModel productDetailStateModel = ProductDetailModel();
  SearchDetailApiService searchSDetailtateService = SearchDetailApiService();

  searchProductDetailStateRequest() async =>
      searchSDetailtateService.getProductDetail().then((value) => {
            productDetailStateModel.product = value.product,
            notifyListeners(),
          });
}
