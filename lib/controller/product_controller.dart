
import 'package:cart_page_enable/model/product_model.dart';
import 'package:flutter/foundation.dart';

import '../services/api_service.dart';

class ProductController with ChangeNotifier{

  var productList = ProductModel();
  bool loader = false;

  ApiService apiService = ApiService();

  void getData() async{
    loader =true;

    var productData= await apiService.getProductDataCalling();

    if(productData !=null){

      productList = productData;
      loader = false;

    }
    notifyListeners();

  }


}