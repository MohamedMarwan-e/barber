import 'package:barber/core/navigation/app_router.dart';
import 'package:barber/features/auth/cubits/sign_up/sign_up_cubit.dart';
import 'package:barber/features/home/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    di<HomeCubit>().fetchSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: di<HomeCubit>().globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(context.tr('salons'),
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
