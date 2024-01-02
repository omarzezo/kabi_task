import 'package:flutter/material.dart';
import 'package:kabi_task/base/constants/app_constants.dart';



class KText extends StatelessWidget {
  final String title;
  final PSize size;
  final TextDecoration? decoration;
  final FontWeight fontWeight;
  final Color fontColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignText;
  const KText({Key? key, required this.title, required this.size,this.fontColor =AppColors.secondary,
    this.fontWeight = FontWeight.w600, this.overflow,this.maxLines,this.decoration=TextDecoration.none, this.alignText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = size == PSize.large ? 18.0 : size == PSize.medium ? 14.0 : size == PSize.small ? 12.0 :
    size==PSize.veryLarge ?20:size==PSize.moreLarge?28:10;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(title,textAlign: alignText ?? TextAlign.start,style: TextStyle(fontWeight: fontWeight,
            fontSize: fontSize,
            color: fontColor,
            height: 1.8,
            letterSpacing: -0.02,
            decoration: decoration,
            overflow: overflow),maxLines:maxLines,)),
      ],
    );
  }

}

enum PSize {
  moreLarge,
  veryLarge,
  large,
  medium,
  small,
  caption
}