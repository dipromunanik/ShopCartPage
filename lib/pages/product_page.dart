import 'package:cart_page_enable/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controller/cart_provider.dart';
import '../controller/product_controller.dart';
import '../db/db_helper.dart';
import '../model/cart_model.dart';
import 'package:badges/badges.dart';

List<Cart>? availableCart;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List<int> _counter = [];

  DBHelper dbHelper = DBHelper();

  increment(int index) {
    setState(() {
      _counter[index]++;
    });
  }

  decrement(int index) {
    setState(() {
      if (_counter[index] > 0) {
        _counter[index]--;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final productItem = Provider.of<ProductController>(context, listen: false);
    productItem.getData();
  }

  @override
  Widget build(BuildContext context) {

    final productView = Provider.of<ProductController>(context);
    final cart = Provider.of<CartProvider>(context, listen: false);
    dbHelper.getCartList();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:const Text('Product Page'),
        actions: [
          FutureBuilder(
              future: cart.getCounter(),
              builder: (context, snapnshot) {
                return IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CartPage()));
                  },
                  icon: Badge(
                    badgeColor: Colors.red,
                    badgeContent: Text(
                      snapnshot.data.toString(),
                      style:const TextStyle(color: Colors.black),
                    ),
                    position: BadgePosition.topStart(),
                    child: Container(child: Icon(Icons.shopping_cart)),
                  ),
                );
              }),
        ],
      ),
      body: productView.loader ? Center(child: Container()):
          GridView.builder(
            itemCount: productView.productList.data!.popularProduct!.length,
            itemBuilder: (context,index){
              var item = productView.productList.data!.popularProduct![index];
              _counter.add(0);
            return Card(
              elevation: 2,
              child: Container(
                width: 184,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6,right: 6),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Image.network(
                            '${'https://universalfood.retinasoft.xyz/'}${item.productImage}',
                            width: 250,
                            height: 100,
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text('${item.productName}',
                                    style: const TextStyle(
                                        color:
                                        Color(0xff48484E),
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.bold),
                                    textAlign: TextAlign.start),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Text(
                                        '${item.branchProduct!.wholesalePrice} -',
                                        style: const TextStyle(
                                            fontSize: 15)),
                                    const Text(' 100gm',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const SizedBox(height: 2),
                                Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            'images/taka.png',
                                            height: 15,
                                            width: 15,
                                            color: Colors.grey),
                                        Text(
                                            '${item.branchProduct!.wholesalePrice}',
                                            style: const TextStyle(
                                                color:
                                                Colors.grey,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight
                                                    .bold)),
                                      ],
                                    ),
                                    const Divider(
                                      endIndent: 113,
                                      thickness: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                        initialRating: 5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 22,
                                        itemPadding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) {
                                          return const Icon(
                                            Icons.star,
                                            color: Color(0xff79AE09),
                                            size: 5,
                                          );
                                        },
                                        onRatingUpdate: (rating) {}),
                                    const SizedBox(width: 2),
                                    const Text(
                                      '(126)',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 23),
                              ],
                            ),
                          ),
                          cart.getCartProductQuantity(item.branchProduct!.id!)>0
                              ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 1.0, right: 1),
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius:
                                  BorderRadius.circular(
                                      10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                        left: 8.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          decrement(index);
                                          dbHelper
                                              .insert(Cart(
//id: index,
                                            productId: item.branchProduct!.id.toString(),
                                            productName: item.productName,
                                            initialPrice: int.parse(item.branchProduct!.salePrice.toString()),
                                            productPrice: int.parse(item.branchProduct!.salePrice.toString()),
                                            quantity: cart.getCartProductQuantity(item.branchProduct!.id!) - 1,
                                            image: "https://universalfood.retinasoft.xyz/${item.productImage}",
                                            unit: "",
                                            deliverTime: '1',
                                            possibleMinit: 1,
                                          ))
                                              .then((value) {
                                            setState(() {});
                                          });
                                          setState(() {});
                                        },
                                        child:
                                        Container(
                                          padding:const
                                          EdgeInsets.all(
                                              5.0),
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                5),
                                            color: Colors.white,
                                          ),
                                          child:const Icon(
                                            Icons.remove,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  const  SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${cart.getCartProductQuantity(item.branchProduct!.id!)}",
                                      style:const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  const  SizedBox(
                                      width: 8,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          right: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          increment(index);

                                          if (cart.getCartProductQuantity(
                                              item.branchProduct!.id!) > 0) {
                                            dbHelper
                                                .insert(Cart(
//id: index
                                              productId: item.branchProduct!.id.toString(),
                                              productName: item.productName,
                                              initialPrice:int.parse(item.branchProduct!.salePrice.toString()),
                                              productPrice: int.parse(item.branchProduct!.salePrice.toString()),
                                              quantity: cart.getCartProductQuantity(item.branchProduct!.id!) + 1,
                                              image: "https://universalfood.retinasoft.xyz/${item.productImage}",
                                              unit: "",
                                              deliverTime: '1',
                                              possibleMinit: 1,
                                            ))
                                                .then(
                                                    (valueeee) {
                                                  // setState(() {
                                                  cart.addTotalPrice(
                                                      double.parse(int.parse(item.branchProduct!.salePrice!)
                                                          .toStringAsFixed(
                                                          0)));
                                                  cart.addCounter();

                                                  setState(() {});
                                                }).onError((error,
                                                stackTrace) {
                                              print("error" +
                                                  error
                                                      .toString());
                                            });
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding:const
                                          EdgeInsets.all(
                                              5.0),
                                          decoration:
                                          BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                7),
                                          ),
                                          child:const Icon(
                                            Icons.add,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                              : Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  increment(index);

                                  if (_counter[index] > 0) {
                                    dbHelper
                                        .insert(Cart(
//id: index,
                                      productId: item.branchProduct!.id.toString(),
                                      productName: item.productName,
                                      initialPrice:int.parse(item.branchProduct!.salePrice!.toString()),
                                      productPrice: int.parse(item.branchProduct!.salePrice!.toString()),
                                      quantity: cart.getCartProductQuantity(
                                          item.branchProduct!.id!) + 1,
                                      image: "https://universalfood.retinasoft.xyz/${item.productImage}",
                                      unit: "",
                                      deliverTime: '1',
                                      possibleMinit: 1,
                                    ))
                                        .then((valueeee) {
                                      // setState(() {
                                      cart.addTotalPrice(item.branchProduct!.discountPrc!
                                          .toDouble());
                                      cart.addCounter();

                                      setState(() {});
                                    }).onError((error,
                                        stackTrace) {
                                      print("error" +
                                          error.toString());
                                    });
                                  }
                                  setState(() {});
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0),
                                  ),
                                  child:const Text(
                                    "Add to cart",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,childAspectRatio: 3/5),
          )
    );
  }
}
