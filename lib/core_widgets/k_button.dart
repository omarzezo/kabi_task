import 'package:flutter/material.dart';
import 'package:kabi_task/base/constants/app_constants.dart';
import 'dart:core';
import 'k_text.dart';

class KButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final PSize size;
  final PStyle style;
  final List<String>? dropDown;
  final Color textColor;
  final bool isFitWidth;
  final Color? fillColor;
  final double? radious;
  final EdgeInsets? padding;

  const KButton({Key? key, required this.onPressed,this.padding,this.radious,this.size = PSize.medium,this.isFitWidth=false,this.title, this.style = PStyle.secondary, this.dropDown, this.textColor = AppColors.secondary,this.fillColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = style == PStyle.primary ? AppColors.secondary : style == PStyle.secondary ? AppColors.secondary : AppColors.white;
    return   Bouncing(
      onPress:() {
        onPressed;
      },child: ElevatedButton(onPressed: onPressed,onHover:(m){},
          style: ElevatedButton.styleFrom(primary: fillColor ?? buttonColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radious??8),
              side:style == PStyle.tertiary ? const BorderSide(width: 1.0, color: AppColors.secondary) : BorderSide.none),
              elevation: 0,
              padding: padding??const EdgeInsets.only(left:10,right:10,bottom:14,top:6),
              minimumSize:isFitWidth?const Size.fromHeight(40): const Size(80, 40)
          ), child:Center(child: KText(title: title!, size: size,fontColor: style == PStyle.tertiary ? textColor : AppColors.white))),
    );
  }

}


class RoundedButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Color backgroundColor;
  final String? title;
  final PSize size;
  final PStyle style;
  final IconData? icon;
  final Color textColor;
  final Color? fillColor;

  const RoundedButton({Key? key, required this.onPressed,this.backgroundColor=AppColors.secondary,
    this.size = PSize.medium, this.title, this.style = PStyle.secondary, this.icon, this.textColor = AppColors.secondary,this.fillColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color buttonColor = style == PStyle.primary ? Constants.yellow : style == PStyle.secondary ? kPrimaryColor : Constants.white;
    return   TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: backgroundColor)
            ),
          ),
          backgroundColor:MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 14,right: 14)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,size: 20,color: textColor,),
            const SizedBox(width: 2,),
            KText(title: title!, size: size,fontColor: textColor,)
          ],
        )
    );
  }
}


enum PStyle {
  primary,
  secondary,
  tertiary,
  link
}




class Bouncing extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPress;

  Bouncing({@required this.child, Key? key, this.onPress})
      : assert(child != null),
        super(key: key);

  @override
  _BouncingState createState() => _BouncingState();
}

class _BouncingState extends State<Bouncing>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (widget.onPress != null) {
          _controller!.forward();
        }
      },
      onPointerUp: (PointerUpEvent event) {
        if (widget.onPress != null) {
          _controller!.reverse();
          widget.onPress!();
        }
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}