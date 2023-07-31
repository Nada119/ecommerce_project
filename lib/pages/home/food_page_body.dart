import 'package:ecommerce_project/controllers/popular_product_controller.dart';
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
              return Container(
                height: 320,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    _scrollController.position.moveTo(
                        _scrollController.position.pixels - details.delta.dx);
                  },
                  onHorizontalDragEnd: (_) {
                    _animateToClosestItem();
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      double itemOffset =
                          index * 330.0; // 320 (item width) + 10 (margin)
                      double scrollOffset = _scrollController.position.pixels;
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
                            child: _buildPageItem(index),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: 10),
            // Add the dots indicator here
            _buildDotsIndicator(),
            //List of food and images
            Container(
              height: 700,
              child: ListView.builder(
                  itemCount: 10,
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
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/food0.png")),
                            ),
                          ),

                          //text container
                          Expanded(
                            child: Container(
                              height: 100,
                              //width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10,
                                ),
                                child: AppColumn(
                                  text: "Chinese Side",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
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
              image: AssetImage("assets/images/food0.png"),
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
                    text: "Chinese Side",
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
        5,
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
