//passed icon and a color
import 'package:ecommerce_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  Color slightlyDarkerColor = Color(0xFFA0A0A0);

  // Fix the typo for the constructor
  IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor = const Color(0xFFcc7c5), // Correct the default color value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
          color: slightlyDarkerColor,
        ),
      ],
    );
  }
}
