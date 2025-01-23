import 'package:barber/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

import '../../../app/app_cubit/localization_cubit.dart';
import '../../../app/app_cubit/theme_cubit.dart';
import '../../../core/dependency_injection.dart';
import '../../../core/extensions/lang.dart';
import '../../../core/extensions/theme_mode.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/widgets/drop_down_button.dart';
import '../../../core/widgets/my_images.dart';
import 'widgets/drawer_header.dart';

part 'widgets/body.dart';
part 'widgets/drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: di<HomeCubit>().globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('صالونات الحلاقة',
            style: Theme.of(context).textTheme.headlineSmall
        ),
        actions: [
          IconButton(
              onPressed: ()=> di<HomeCubit>().globalKey.currentState!.openEndDrawer(),
              icon: Icon(Icons.menu)
          )
        ],
      ),
      endDrawer: const _DrawerWidget(),
      body: _Body(),
    );
  }
}
