import 'package:ecommerce_project/controllers/cart_controller.dart';
import 'package:ecommerce_project/controllers/popular_product_controller.dart';
import 'package:ecommerce_project/controllers/recommended_product_controller.dart';
import 'package:ecommerce_project/pages/cart/cart_page.dart';
import 'package:ecommerce_project/pages/food/popular_food_detail.dart';
import 'package:ecommerce_project/pages/food/recomended_food_detail.dart';
import 'package:ecommerce_project/pages/home/food_page_body.dart';
import 'package:ecommerce_project/pages/home/main_food_page.dart';
import 'package:ecommerce_project/pages/splash/splash_page.dart';
import 'package:ecommerce_project/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_project/helper/dependencies.dart' as dep;

void main() async {
  //to make sure it is loaded and wait until they are loaded
  WidgetsFlutterBinding.ensureInitialized();

  //load dependencies before running your app
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//when I moved get find to splash every thing get deleted after being loaded because of that I will wrap my app with Get Builder
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // not correct way to load
    // first we will load splash screen and from there we will load resources
    /*
    Get.find<PopularProductController>()
        .getPopularProductList(); //to test controllers only
    Get.find<RecommendedProductController>()
        .getRecommendedProductList(); //data won't be loaded until I call it in the main very important
    print("Here");
    */
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        //we do it _ because we aren't going to use any istances
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            //home: SplashScreen(),
            //right way to be called, to make our app consistent
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
