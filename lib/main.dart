import 'package:ecommerce_project/controllers/popular_product_controller.dart';
import 'package:ecommerce_project/pages/food/popular_food_detail.dart';
import 'package:ecommerce_project/pages/food/recomended_food_detail.dart';
import 'package:ecommerce_project/pages/home/food_page_body.dart';
import 'package:ecommerce_project/pages/home/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_project/helper/dependencies.dart' as dep;

void main() async {
  //to make sure it is loaded and wait until they are loaded
  WidgetsFlutterBinding.ensureInitialized();

  //load dependencies before running your app
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>()
        .getPopularProductList(); //to test controllers only
    print("Here");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainFoodPage(),
    );
  }
}