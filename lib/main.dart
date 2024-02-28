import 'package:db_client/db_client.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/screens/categorys_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'models/cart.dart';
import 'repositories/cart_repository.dart';
import 'repositories/category_repository.dart';
import 'repositories/product_repository.dart';
import 'screens/cart_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/checkout_screen.dart';

final dbClient = DbClient();
final categoryRepository = CategoryRepository(dbClient: dbClient);
final productRepository = ProductRepository(dbClient: dbClient);
const cartRepository = CartRepository();

const userId = 'user_1234';
var cart = const Cart(
  userId: userId,
  cartItems: [],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey =
      'pk_test_51OoiDHB9kchhI5XggSN3bcxfm5WE9cPRTFnPV2g93tSRI0y3HzOxhIHtYik5qlcOLbBvgMyhC0UX0Dr4Vss1YhVF00ssLi8Ufi';
  await Stripe.instance.applySettings();
  // categoryRepository.createCategories();
  // productRepository.createProducts();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CategoriesScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/categories') {
          return MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          );
        }
        if (settings.name == '/cart') {
          return MaterialPageRoute(
            builder: (context) => const CartScreen(),
          );
        }
        if (settings.name == '/checkout') {
          return MaterialPageRoute(
            builder: (context) => const CheckoutScreen(),
          );
        }
        if (settings.name == '/catalog') {
          return MaterialPageRoute(
            builder: (context) => CatalogScreen(
              category: settings.arguments as String,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          );
        }
      },
    );
  }
}
