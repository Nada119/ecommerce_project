import 'package:ecommerce_project/pages/home/food_page_body.dart';
import 'package:ecommerce_project/widgets/big_text.dart';
import 'package:ecommerce_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_project/utils/colors.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        //showing the header
        Container(
          child: Container(
            margin: EdgeInsets.only(top: 45, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Bangladesh", color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(
                          text: "Narsingdi",
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //showing the body
        FoodPageBody(),
      ]),
    );
  }
}
