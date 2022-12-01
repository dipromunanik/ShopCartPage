
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../model/cart_model.dart';
import '../pages/product_page.dart';

class CartProvider with ChangeNotifier{

  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  getCartProductQuantity(int id) {
    int? res = 0;
    availableCart!.forEach((element) {
      print(element.productId?.compareTo("$id"));
      if (element.productId?.compareTo("$id") == 0) {
        res = element.quantity;
      }
    });
    return res!;
  }

  Future<List<Cart>> getData() async {
    _cart = db.getCartList();

    return _cart;
  }


  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    notifyListeners();
  }

  Future<double> getTotalPrice() async {

    // _getPrefItems();
    double items = 0;
    await db.getCartList().then((value) {
      value.forEach((element) {
        items += (element.productPrice! * element.quantity!);
      });
    });


    _totalPrice = items;

    print("D___$totalPrice");
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    notifyListeners();
  }

  void removerCounter() {
    _counter--;
    notifyListeners();
    getCounter();
  }


  Future<int> getCounter() async {
    //_getPrefItems();
    int items = 0;
    await db.getCartList().then((value) {
      /*value.forEach((element) {
        items+= element.quantity!;
      });*/


      _counter = value.length;
    });

    // notifyListeners();
    return _counter;
  }

}