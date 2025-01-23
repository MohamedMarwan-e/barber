import 'package:barber/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_cubit/theme_cubit.dart';
import '../../../../core/dependency_injection.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/widgets/my_images.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.33,
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: DrawerHeader(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyImage(
                SvgAssets.user,
                height: 100,width: 100,
              ),
              SizedBox(height: 16),
              Text('فهد المولد',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: di<ThemeCubit>().isDark ?
                    kWhite : primaryColor
                  )
              ),
              SizedBox(height: 8),
              Text('Mostafa435@gmail.com',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: di<ThemeCubit>().isDark ?
                      kWhite : kHint, fontSize: 10
                  )
              ),
            ],
          )
      ),
    );
  }
}