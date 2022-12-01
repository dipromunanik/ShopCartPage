import 'package:cart_page_enable/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/cart_provider.dart';
import '../db/db_helper.dart';
import '../model/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  String? deliveryamount;

  bool deliveryLoader = true;



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await dbHelper!.getCartList();
    });


    super.initState();
  }

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context,true);
        }, icon:const Icon(Icons.arrow_back)),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title:const Text("Cart"),
      ),
      body: Consumer<CartProvider>(builder: (_, valueeee, child) {
        return FutureBuilder(
            future: valueeee.getData(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset('images/dustbin.png'),
                        const SizedBox(height: 10),
                        const Text(
                          'Your Cart is Empty!',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Looks like you haven't made order yet",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        TextButton(
                            onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductPage()));
                            },
                            child:const Text(
                              'Continue to Shopping',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ))
                      ],
                    ),
                  );
                } else {
                  return ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 70,
                                    child: Row(
                                      children: [
//                                         GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return AlertDialog(
//                                                       title: Text(('Delete!')),
//                                                       content: Text(
//                                                         'Do you want to Delete?',
//                                                         style: TextStyle(),
//                                                       ),
//                                                       actions: <Widget>[
//                                                         ElevatedButton(
//                                                           style: ElevatedButton
//                                                               .styleFrom(
//                                                             primary: Colors.green,
//                                                           ),
//                                                           child: Text(
//                                                             'Yes',
//                                                             style: TextStyle(
//                                                               color:
//                                                               Colors.white,
//                                                             ),
//                                                           ),
//                                                           onPressed: () {
//                                                             dbHelper!.delete(
//                                                                 snapshot
//                                                                     .data![
//                                                                 index]
//                                                                     .productId!);
//                                                             cart.removerCounter();
//                                                             cart.removeTotalPrice(
//                                                                 double.parse(snapshot
//                                                                     .data![
//                                                                 index]
//                                                                     .productPrice
//                                                                     .toString()));
//                                                             Navigator.pop(
//                                                                 context, true);
//                                                             setState(() {
//                                                               dbHelper!
//                                                                   .getCartList();
//                                                             });
//
// //Will not exit the App
//                                                           },
//                                                         ),
//                                                         ElevatedButton(
//                                                           style: ElevatedButton
//                                                               .styleFrom(
//                                                               primary:
//                                                               Colors
//                                                                   .red),
//                                                           child: Text(
//                                                             'No',
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .white),
//                                                           ),
//                                                           onPressed: () {
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         )
//                                                       ],
//                                                     );
//                                                   },
//                                                 );
//                                               });
//                                             },
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(left: 17.0),
//                                               child: Image.asset(
//                                                 "assets/delete.png",
//                                                 height: 20,
//                                                 width: 20,
//                                               ),
//                                             )),
                                       const SizedBox(width: 10,),
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(7),
                                          ),
                                          child: Image.network(
                                            snapshot
                                                .data![index].image
                                                .toString(),
                                            fit: BoxFit.contain,

                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: Text(
                                              snapshot
                                                  .data![index].productName
                                                  .toString()!,

                                            ),

                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0),
                                          child: SizedBox(
                                            width: 90,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    int quantity = snapshot
                                                        .data![index].quantity!;
                                                    int price = snapshot
                                                        .data![index]
                                                        .initialPrice!;
                                                    quantity--;
// int?
//     newPrice =
//     price *
//         quantity;

                                                    if (quantity > 0) {
                                                      dbHelper!
                                                          .updateQuantity(
                                                          Cart(
//id: snapshot.data![index].id!,
                                                            productId: snapshot
                                                                .data![index]
                                                                .productId!
                                                                .toString(),
                                                            productName: snapshot
                                                                .data![index]
                                                                .productName!,
                                                            initialPrice: snapshot
                                                                .data![index]
                                                                .initialPrice!,
                                                            productPrice: snapshot
                                                                .data![index]
                                                                .initialPrice!,
                                                            quantity: quantity,
                                                            image: snapshot
                                                                .data![index].image
                                                                .toString(), unit: '', deliverTime: '', possibleMinit: null,
                                                          ))
                                                          .then((value) {
// snapshot.data![index].initialPrice =
//     0;
// quantity =
//     0;
                                                        cart.removeTotalPrice(
                                                            double.parse(snapshot
                                                                .data![index]
                                                                .initialPrice!
                                                                .toString()));
                                                      }).onError((error,
                                                          stackTrace) {
                                                        print(error.toString());
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5)),
                                                    child: Text(
                                                      '-',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                                  child: Text(

                                                    "${snapshot.data![index].quantity}",
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    int quantity = snapshot
                                                        .data![index].quantity!;
                                                    int price = snapshot
                                                        .data![index]
                                                        .initialPrice!;
                                                    quantity++;

                                                    dbHelper!
                                                        .updateQuantity(
                                                        Cart(
                                                          productId: snapshot
                                                              .data![index]
                                                              .productId!
                                                              .toString(),
                                                          productName: snapshot
                                                              .data![index]
                                                              .productName!,
                                                          initialPrice: snapshot
                                                              .data![index]
                                                              .initialPrice!,
                                                          productPrice: snapshot
                                                              .data![index]
                                                              .productPrice!,
                                                          quantity: quantity,
                                                          image: snapshot
                                                              .data![index].image
                                                              .toString(), unit: '', deliverTime: '', possibleMinit: null,
                                                        ))
                                                        .then((value) {
                                                      cart.addTotalPrice(
                                                          double.parse(snapshot
                                                              .data![index]
                                                              .initialPrice!
                                                              .toString()));
                                                    }).onError((error,
                                                        stackTrace) {
                                                      print(error.toString());
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5)),
                                                    child: Text(
                                                      '+',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),

                              ],
                            );
                          }),
                      Consumer<CartProvider>(builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: FutureBuilder<double>(
                              future: value.getTotalPrice(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData)
                                  return Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        children: [
                                          ReusableWidget(
                                            title: 'Sub Total',
                                            value: r'৳' +
                                                snapshot.data!
                                                    .toStringAsFixed(2),
                                          ),
                                          deliveryLoader
                                              ? Container()
                                              : ReusableWidget(
                                            title: 'Delivery Charge',
                                            value: r'৳' +
                                                "${int.parse(deliveryamount!)}",
                                          ),
                                          deliveryLoader
                                              ? Container()
                                              : ReusableWidget(
                                            title: 'Total',
                                            value: r'৳' +
                                                "${(snapshot.data! + int.parse(deliveryamount!))}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                return Container();
                              }),
                        );
                      }),
                      GestureDetector(
                        onTap: () {

                          // Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentPage(
                          //   orderProduct: productmodel,
                          //
                          //
                          // )));
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 38.0, right: 38, bottom: 40),
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 5.0, right: 5),
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }
              return Text('');
            });
      }),
    );
  }
}
class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title  :",
            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "${value.toString()} :",
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}