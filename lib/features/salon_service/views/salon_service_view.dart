import 'package:barber/core/resources/color_manager.dart';
import 'package:barber/core/widgets/my_elevated_button.dart';
import 'package:barber/core/widgets/my_images.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/app_cubit/theme_cubit.dart';
import '../../../core/dependency_injection.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/widgets/my_grid_view.dart';
import '../cubits/salon_service_cubit.dart';

part 'widgets/body.dart';
part 'widgets/tab_bar.dart';
part 'widgets/tab_bar_views.dart';
part 'widgets/services.dart';
part 'widgets/workers.dart';

class SalonServiceView extends StatefulWidget {
  const SalonServiceView({super.key, required this.id});
  final String id;

  @override
  State<SalonServiceView> createState() => _SalonServiceViewState();
}

class _SalonServiceViewState extends State<SalonServiceView>{

  @override
  void initState() {
    super.initState();
    di<SalonServiceCubit>().pageController = PageController(initialPage: 0);
    di<SalonServiceCubit>().fetchSalonsDetails(widget.id);

  }

  @override
  void dispose() {
    di<SalonServiceCubit>().pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: AlignmentDirectional.topCenter,
            image: AssetImage(ImageAssets.salonBackground),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  backgroundColor: kTransparent,
                  surfaceTintColor: kTransparent,
                  floating: true,
                  snap: true,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyElevatedButton(
                    onPressed: ()=>context.pop(),
                    borderRadius: BorderRadius.circular(18),
                    height: 40,width: 40,
                    backgroundColor: kWhite,
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: kHint,
                    ),
                  ),
                )
              ),
              SliverToBoxAdapter(child: SizedBox(height: 160)),
              SliverToBoxAdapter(
                child: _Body(widget.id),
              )
            ],
          ),
        ),
      ),
    );
  }
}