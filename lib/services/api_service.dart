import 'package:http/http.dart';

import '../model/product_model.dart';


class ApiService{

  String url = 'https://universalfood.retinasoft.xyz/api/frontend/popular/product/list/1';


  Future<ProductModel?> getProductDataCalling() async{

    Response response =await get(Uri.parse(url));

    if(response.statusCode==200){

      return productModelFromJson(response.body);
    }
    else{
      throw Exception(response.reasonPhrase);

    }

  }

}