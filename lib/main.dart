import 'package:eater_app_flutter/interfaces/i_cart_service.dart';
import 'package:eater_app_flutter/interfaces/i_product_service.dart';
import 'package:eater_app_flutter/pallete.dart';
import 'package:eater_app_flutter/screens/home_screen.dart';
import 'package:eater_app_flutter/services/cart_service.dart';
import 'package:eater_app_flutter/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  // Register services
  GetIt.I.registerSingleton<ICartService>(CartService());
  GetIt.I.registerSingleton<IProductService>(ProductService());

  // Run the application
  runApp(const EaterApp());
}

class EaterApp extends StatelessWidget {
  const EaterApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eater',
      theme: ThemeData(
        primarySwatch: Pallete.eaterPrimary,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Pallete.eaterPrimary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
