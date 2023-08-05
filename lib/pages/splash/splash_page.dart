import 'dart:async';

import 'package:ecommerce_project/controllers/cart_controller.dart';
import 'package:ecommerce_project/controllers/popular_product_controller.dart';
import 'package:ecommerce_project/controllers/recommended_product_controller.dart';
import 'package:ecommerce_project/routes/route_helper.dart';
import 'package:ecommerce_project/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//statefull because it will do animations (and load resources)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // this class is needed for animation
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>()
        .getPopularProductList(); //to test controllers only
    await Get.find<RecommendedProductController>()
        .getRecommendedProductList(); //data won't be loaded until I call it in the main very important
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = new AnimationController(
        vsync: this, duration: Duration(seconds: 2))
      ..forward(); //we need these 2 dots to make it work and appeared and displayed and without parameters
    //controller = controller.forward(); put it will need properties
    animation = new CurvedAnimation(
        parent: controller, curve: Curves.linear); // we can remove new

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Image.asset(
                "assets/images/logo part 1.png",
                width: Dimensions.splashImg,
              ),
            ),
            Image.asset(
              "assets/images/logo part 2.png",
              width: Dimensions.splashImg,
            ),
          ],
        ),
      ),
    );
  }
}
