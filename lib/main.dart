import 'package:eater_app_flutter/pallete.dart';
import 'package:eater_app_flutter/screens/home_screen.dart';
import 'package:eater_app_flutter/services/cart_service.dart';
import 'package:eater_app_flutter/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  // Register services
  GetIt.I.registerSingleton(CartService());
  GetIt.I.registerSingleton(ProductService());

  // Run the application
  runApp(const EaterApp());
}

class EaterApp extends StatelessWidget {
  const EaterApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eater',
      theme: ThemeData(
        primarySwatch: Pallete.eaterPrimary,
      ),
      home: const HomeScreen(),
    );
  }
}
