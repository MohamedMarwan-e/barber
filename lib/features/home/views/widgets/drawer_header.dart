import 'package:barber/core/extensions/cache_user_model.dart';
import 'package:barber/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_cubit/theme_cubit.dart';
import '../../../../core/dependency_injection.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/services/hive.dart';
import '../../../../core/widgets/my_images.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = di<HiveLocalStorage>().getUserModel();

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.35,
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: DrawerHeader(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyImage(
                userModel?.avatar ??SvgAssets.user,
                height: 98,width: 98,
              ),
              SizedBox(height: 12),
              Text(userModel?.name ??'',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: di<ThemeCubit>().isDark ?
                    kWhite : primaryColor
                  )
              ),
              SizedBox(height: 8),
              Text(userModel?.email ??'',
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