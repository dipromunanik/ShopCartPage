import 'package:cart_page_enable/controller/cart_provider.dart';
import 'package:cart_page_enable/controller/product_controller.dart';
import 'package:cart_page_enable/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ProductController()),
        ChangeNotifierProvider(create: (context)=>CartProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductPage(),
      ),
    );
  }
}
