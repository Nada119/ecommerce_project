//import 'dart:ffi'; //doesn't work for web

import 'package:ecommerce_project/utils/colors.dart';
import 'package:ecommerce_project/utils/dimensions.dart';
import 'package:ecommerce_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpendableTextWidget extends StatefulWidget {
  final String text;
  const ExpendableTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpendableTextWidget> createState() => _ExpendableTextWidgetState();
}

class _ExpendableTextWidgetState extends State<ExpendableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHieght =
      Dimensions.screenHeight / 5.63; // text exceed 200 it will be hide
  //it isn't best solution but it works
  @override
  void initState() {
    super.initState();
    //here will check length of this text
    if (widget.text.length > textHieght) {
      //split text
      firstHalf = widget.text.substring(0, textHieght.toInt());
      secondHalf =
          widget.text.substring(textHieght.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      //we do this because we have to intalize it some how
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              color: AppColors.paraColor,
              height: 1.8, //Color(0xFFA0A0A0)
            )
          :
          // to show text and bottom
          Column(
              children: [
                SmallText(
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                  color: AppColors.paraColor,
                  //Color(0xFFA0A0A0)
                  size: Dimensions.font16,
                  height: 1.8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? "Show more" : "Show less",
                        color: AppColors.mainColor,
                        size: Dimensions.font16,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
