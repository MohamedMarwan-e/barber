import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color_manager.dart';


class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.controller,
    this.fillColorTextFiled,
    this.inputFormatters,
    this.filledColorTextFiled,
    this.textType,
    this.hintStyle,
    this.hintText,
    this.onChangedFunction,
    this.validatorFunction,
    this.onEditingCompleteFunction,
    this.focusNode,
    this.textInputAction,
    this.prefixIconWidget,
    this.suffixIconWidget,
    this.obscure,
    this.height,
    this.width,
    this.contentVerticalPadding,
    this.labelText,
    this.labelStyle,
    this.cursorColor,
    this.onFieldSubmitted,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.widthBorder,
    this.maxLines,
    this.maxLength,
    this.errorTextStyle,
    this.enabledBorderRadius,
    this.focusedBorderRadius,
    this.inputTextStyle,
    this.focusedErrorBorderRadius,
    this.errorBorderRadius,
    this.errorMaxLines,
    this.isRadius = false,
    this.hintTextSize,
    this.suffix,
    this.inputTextColor,
    this.inputTextSize,
    this.suffixText,
    this.suffixTextSize,
    this.borderFromBottom = false,
    this.contentHorizontalPadding,
    this.onSaved,
  });

  final TextEditingController? controller;
  final Color? fillColorTextFiled;
  final List<TextInputFormatter>? inputFormatters;
  final bool? filledColorTextFiled;
  final TextInputType? textType;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final String? hintText;
  final ValueChanged<String>? onChangedFunction;
  final FormFieldValidator<String>? validatorFunction;
  final VoidCallback? onEditingCompleteFunction;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  final bool? obscure;
  final bool isRadius;
  final double? height;
  final double? width;
  final double? contentVerticalPadding;
  final double? contentHorizontalPadding;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? errorTextStyle;
  final  Color? cursorColor;
  final ValueChanged<String>? onFieldSubmitted;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final double? enabledBorderRadius;
  final double? errorBorderRadius;
  final double? focusedBorderRadius;
  final double? focusedErrorBorderRadius;
  final double? hintTextSize;
  final double? widthBorder;
  final int? maxLines;
  final int? maxLength;
  final int? errorMaxLines;
  final Widget? suffix;
  final Color? inputTextColor;
  final double? inputTextSize;
  final String? suffixText;
  final double? suffixTextSize;
  final bool borderFromBottom;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme ;
    return Container(
      height: height,
      width: width ?? MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: isRadius ?
        BorderRadius.circular(enabledBorderRadius ?? 8) :
        BorderRadius.zero
      ),
      child: TextFormField(
        onTapOutside: (event)=> FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        enableSuggestions: true,
        style: inputTextStyle ?? theme.displaySmall?.copyWith(
          fontSize: inputTextSize ?? 16,
          color: inputTextColor ?? graySwatch.shade900,
        ),
        cursorColor: cursorColor ?? primaryColor,
        keyboardType: textType ?? TextInputType.text,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        maxLength: maxLength,
        decoration:  InputDecoration(

          // floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText ?? '',
          floatingLabelStyle: labelStyle ??
              theme.bodySmall?.copyWith(
                  color: graySwatch.shade600,
                  fontSize: 14
              ),
          errorMaxLines: errorMaxLines ?? 1,
          errorStyle: errorTextStyle ??
              theme.headlineMedium!.copyWith(
                  color: kRed150,
                  fontSize: 10
              ),
          labelText: labelText,
          labelStyle: labelStyle ?? theme.bodySmall?.copyWith(
              color: graySwatch.shade600,
              fontSize: 14
          ),
          hintStyle: hintStyle ??
              theme.displaySmall?.copyWith(
                  color: graySwatch.shade600,
                  fontSize: hintTextSize ?? 14
              ),
          fillColor: fillColorTextFiled ?? kWhite,
          filled: filledColorTextFiled  ?? true,
          prefixIcon: prefixIconWidget,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40, maxWidth: 40, maxHeight: 50,
          ),
          suffixIcon: suffixIconWidget,
          suffix:suffix ,
          suffixText: suffixText,
          suffixStyle: theme.headlineMedium?.copyWith(
              color: graySwatch.shade500,
              fontSize: suffixTextSize ?? 14
          ),

          enabledBorder: borderFromBottom ?
          UnderlineInputBorder(
              borderSide: BorderSide(
                  color: enabledBorderColor ?? graySwatch.shade300,
                  width: widthBorder ?? 2
              ),
          ):
          OutlineInputBorder(
            borderSide: BorderSide(
                color: enabledBorderColor ?? graySwatch.shade300,
                width: widthBorder ?? 1.6
            ),
            borderRadius: BorderRadius.circular(enabledBorderRadius ?? 8),
          ),

          focusedBorder: borderFromBottom ?
          UnderlineInputBorder(
            borderSide: BorderSide(
                color: enabledBorderColor ?? graySwatch.shade300,
                width: widthBorder ?? 2
            ),
          ):
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(focusedBorderRadius ?? 8),
              borderSide: BorderSide(
                  color: focusedBorderColor ?? primaryColor.withValues(alpha: 0.7),
                  width: widthBorder ?? 1.6
              )
          ),

          errorBorder: borderFromBottom ?
          UnderlineInputBorder(
            borderSide: BorderSide(
                color:enabledBorderColor ?? kRed150,
                width: widthBorder ?? 2
            ),
          ):
          OutlineInputBorder(
              borderSide: const BorderSide(color: kRed150, width: 2),
              borderRadius: BorderRadius.circular(errorBorderRadius ?? 8)
          ),

          focusedErrorBorder: borderFromBottom ?
          UnderlineInputBorder(
            borderSide: BorderSide(
                color: enabledBorderColor ?? kRed150,
                width: widthBorder ?? 2
            ),
          ) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(focusedErrorBorderRadius??8),
              borderSide: const BorderSide(color: kRed150, width: 2)
          ),

          contentPadding: EdgeInsets.symmetric(
              horizontal: contentHorizontalPadding ?? 10,
              vertical: contentVerticalPadding ?? 12
          ),
        ),
        onChanged: onChangedFunction,
        onSaved: onSaved,
        focusNode: focusNode,
        maxLines: maxLines ?? 1,
        onEditingComplete: onEditingCompleteFunction,
        validator: validatorFunction,
        textInputAction: textInputAction,
        obscureText: obscure ?? false,
      ),
    );
  }
}
