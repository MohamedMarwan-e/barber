part of '../salon_service_view.dart';

class _TabBarViews extends StatelessWidget {
  const _TabBarViews();


  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      controller: di<SalonServiceCubit>().pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        WorkersWidget(),
        SalonServicesWidget(),
      ],
    );
  }
}