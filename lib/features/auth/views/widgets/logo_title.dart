import 'package:flutter/material.dart';

import '../../../../app/app_cubit/theme_cubit.dart';
import '../../../../core/dependency_injection.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/my_images.dart';

class LogoViewTitle extends StatelessWidget {
  const LogoViewTitle(this.title,{super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    final isDark = di<ThemeCubit>().isDark;

    return Center(
      child: Column(
        children: [
          MyImage(
            SvgAssets.logo,
            height: 60 ,width: 180,
            color: isDark ? kWhite : null,
          ),
          SizedBox(height: 20),
          Text(title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 24
            ),
          ),
          SizedBox(height: 48),
        ],
      ),
    );
  }
}