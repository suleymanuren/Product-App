import 'package:flutter/cupertino.dart';

import '../models/product_models.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  AllProducts productStateModel = AllProducts();
  SearchApiService searchStateService = SearchApiService();
  searchProductStateRequest() async =>
      searchStateService.getProducts().then((value) => {
            productStateModel.products = value.products,
            notifyListeners(),
          });
}
