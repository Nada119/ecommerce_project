import 'package:ecommerce_project/controllers/popular_product_controller.dart';
import 'package:ecommerce_project/controllers/recommended_product_controller.dart';
import 'package:ecommerce_project/models/products_model.dart';
import 'package:ecommerce_project/routes/route_helper.dart';
import 'package:ecommerce_project/utils/app_constants.dart';
import 'package:ecommerce_project/utils/colors.dart';
import 'package:ecommerce_project/utils/dimensions.dart';
import 'package:ecommerce_project/widgets/app_column.dart';
import 'package:ecommerce_project/widgets/big_text.dart';
import 'package:ecommerce_project/widgets/icon_and_text_widget.dart';
import 'package:ecommerce_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody>
    with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.9, end: 1.1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //we will wrap with get builder to use it with data and get it updated
            //slider section
            GetBuilder<PopularProductController>(builder: (popularProducts) {
              return popularProducts.isLoaded
                  ? Container(
                      height: 320,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          _scrollController.position.moveTo(
                              _scrollController.position.pixels -
                                  details.delta.dx);
                        },
                        onHorizontalDragEnd: (_) {
                          _animateToClosestItem();
                        },
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          itemCount: popularProducts
                              .popularProductList.length, //instance length
                          itemBuilder: (context, index) {
                            double itemOffset =
                                index * 330.0; // 320 (item width) + 10 (margin)
                            double scrollOffset =
                                _scrollController.position.pixels;
                            double difference = itemOffset - scrollOffset;

                            double scale = 1.0;
                            if (index == currentIndex) {
                              scale = _animation.value;
                            } else if (index == currentIndex + 1 ||
                                index == currentIndex - 1) {
                              scale = (_animation.value - 0.9).abs() + 0.9;
                            }

                            return AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: _buildPageItem(
                                      index,
                                      popularProducts
                                          .popularProductList[index]),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : CircularProgressIndicator(
                      color: AppColors.mainColor,
                    );
            }),
            SizedBox(height: 10),
            // Add the dots indicator here
            GetBuilder<PopularProductController>(builder: (popularProducts) {
              return _buildDotsIndicator();
            }),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20, bottom: Dimensions.height20),
                  child: BigText(text: "Recommended"),
                ),
                SizedBox(
                    width:
                        10), // Add some spacing to separate the text from the ListView
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    bottom: Dimensions.height20,
                    right: 1010,
                  ),
                  child: SmallText(
                    text: "Food Pairing",
                    color: Color(0xFFA0A0A0),
                  ),
                ),
              ],
            ),

            //List of food and images
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.recommendeFood);
              },
              child: GetBuilder<RecommendedProductController>(
                  builder: (recommendedProduct) {
                return recommendedProduct.isLoaded
                    ? Container(
                        height: 700,
                        child: ListView.builder(
                            itemCount: recommendedProduct
                                .recommendedProductList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20,
                                    bottom: Dimensions.height10),
                                child: Row(
                                  children: [
                                    //image section
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(AppConstants
                                                  .BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              recommendedProduct
                                                  .recommendedProductList[index]
                                                  .img!),
                                        ),
                                      ),
                                    ),

                                    //text container
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        //width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  Dimensions.radius20),
                                              bottomRight: Radius.circular(
                                                  Dimensions.radius20)),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: Dimensions.width10,
                                            right: Dimensions.width10,
                                          ),
                                          child: AppColumn(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : CircularProgressIndicator(
                        color: AppColors.mainColor,
                      );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            //basic routing Get.toNamed()
            Get.toNamed(RouteHelper.getPopularFood(index));
          },
          child: Container(
            width: 320, //no need for height because it takes parent height
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: 10, right: 10), //without it they will be لازقين قى بعض
            decoration: BoxDecoration(
              color: index.isEven
                  ? Color(0xFF69c5df)
                  : Color(0xFF9294cc), //primary color until picture is loaded
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.cover, //make it full the container
                image: NetworkImage(AppConstants.BASE_URL +
                    AppConstants.UPLOAD_URL +
                    popularProduct.img!),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            //background
            width: 250, //no need for height because it takes parent height
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 30), //without it they will be لازقين قى بعض
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              //shadow
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 5.0,
                  offset:
                      Offset(0, 5), //x axis doesn't change, y axis 5 px down
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                ),
              ],
            ),
            //content
            child: Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: popularProduct.name!,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      //rating bar
                      Wrap(
                        children: List.generate(
                            5,
                            (index) => Icon(
                                  Icons.star,
                                  color: AppColors.mainColor,
                                  size: 15,
                                )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(text: "4.5"),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(text: "1287"),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(text: "comments"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1,
                          ),
                          IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "1.7km",
                            iconColor: AppColors.mainColor,
                          ),
                          IconAndTextWidget(
                            icon: Icons.access_alarm_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void startAnimation() {
    _animationController.forward(from: 0);
  }

  void _animateToClosestItem() {
    int targetIndex = (_scrollController.offset / 330.0).round();
    double targetItem = targetIndex * 330.0;
    _scrollController.animateTo(targetItem,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);

    if (currentIndex != targetIndex) {
      setState(() {
        currentIndex = targetIndex;
      });
    }
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        Get.find<PopularProductController>()
            .popularProductList
            .length, // Use popularProductList.length to get the correct length
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    index == currentIndex ? AppColors.mainColor : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
