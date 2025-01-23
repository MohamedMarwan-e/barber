import 'package:barber/core/resources/color_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../app/app_cubit/theme_cubit.dart';
import '../dependency_injection.dart';
import 'my_images.dart';


class DropDownButton extends StatelessWidget {
  const DropDownButton({
    required this.title,
    required this.valueToShow,
    required this.imageSize,
    required this.image,
    this.showArrow = true,
    this.showDivider = false,
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.items,
    this.onChanged,
  });

  final String title;
  final String valueToShow;
  final dynamic value;
  final Color? color;
  final Color? backgroundColor;
  final bool showArrow;
  final List<DropdownMenuItem>? items;
  final void Function(dynamic)? onChanged;
  final bool showDivider;
  final double imageSize;
  final String image;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = di<ThemeCubit>().isDark;
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      children: [
        ColoredBox(
          color: backgroundColor ?? (isDarkTheme ? secondaryColor : Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 48,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyImage(
                          image,
                          height: imageSize,
                          width: imageSize
                      ),
                      SizedBox(width: 16),
                      Text(context.tr(title),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: isDarkTheme ? kWhite :primaryColor,
                        ),
                      ),
                      if (showArrow)...[
                        Spacer(),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: isDarkTheme ?kBabyBlue:primaryColor,
                            size: 18,
                          ),
                        ),
                      ]

                    ],
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 200,
                    direction: DropdownDirection.textDirection,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: backgroundColor ?? (isDarkTheme ? secondaryColor : kWhite),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 8),
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                        ),
                        BoxShadow(
                          offset: const Offset(0, 0),
                          color: Colors.black.withValues(alpha:0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    elevation: 0,
                    offset: Offset(-(width), 50),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  value: value,
                  items: items,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 0,
            color: isDarkTheme ? graySwatch.shade800 : graySwatch.shade200,
          ),
      ],
    );
  }
}
