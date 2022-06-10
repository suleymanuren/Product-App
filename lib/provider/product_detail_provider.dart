import 'package:flutter/cupertino.dart';
import 'package:product_app/models/product_detail_model.dart';
import 'package:product_app/services/product_detail_service.dart';



class ProductDetailProvider extends ChangeNotifier {
  ProductDetailModel denemeStateModel = ProductDetailModel();
  ProductDetailsApiService denemeStateService = ProductDetailsApiService();
  //bool loading=false;
  denemeStateRequest() async {
    //  loading=true;
    await denemeStateService.getProductDetailModel().then((value) => {
      denemeStateModel.product = value.product,

      notifyListeners(),
    });
    //loading =false;
    // notifyListeners();
  }
}
