import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class MyElevatedButton extends StatelessWidget {

  const MyElevatedButton({
    super.key,
    this.onPressed,
    this.child,
    this.borderRadius,
    this.width,
    this.height = 48.0,
    this.gradient,
    this.styleStyle,
    this.backgroundColor,
    this.surfaceTintColor,
    this.shadowColor,
    this.foregroundColor,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.elevation,
    this.margin,
    this.text,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.circleShape=false,
    this.disableOnPressed=false,
    this.isGradient=false,
    this.isShadow=false,
  });

  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final Color? shadowColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double height;
  final double? borderWidth;
  final double? elevation;
  final Gradient? gradient;
  final Function()? onPressed;
  final Widget? child;
  final ButtonStyle? styleStyle;
  final bool isGradient;
  final String? text;
  final Color? textColor;
  final double? textSize;
  final bool? circleShape;
  final bool? disableOnPressed;
  final bool isShadow;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(16);
    return Container(
      width: width ?? MediaQuery.sizeOf(context).width,
      height: height,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: isShadow ?
        [
          BoxShadow(
              color: Color(0xFF58264A).withValues(alpha: 0.1),
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0
          ),
        ]:[],
      ),
      child: ElevatedButton(
        onPressed: disableOnPressed! ? null: onPressed ??(){},
        style: styleStyle?? ElevatedButton.styleFrom(
            backgroundColor: backgroundColor?? primaryColor,
            surfaceTintColor: surfaceTintColor?? kTransparent,
            shadowColor: shadowColor?? kTransparent,
            foregroundColor: foregroundColor ?? primaryColor,
            elevation: elevation?? 0,
            alignment: AlignmentDirectional.center,
            padding: padding ?? EdgeInsets.zero,
          shape: circleShape! ?
          const CircleBorder():
          RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: BorderSide(
                  color: borderColor ??  kTransparent,
                  width: borderWidth ?? 1
              )
          ),

        ),
        child: child ??
            Text(text??'',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: textSize ?? 17,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: textColor ?? kWhite
            )
        ),
      ),
    );
  }
}