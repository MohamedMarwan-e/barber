part of '../salon_service_view.dart';

class _TabBar extends StatelessWidget {
  const _TabBar();


  @override
  Widget build(BuildContext context) {
    final isDark = di<ThemeCubit>().isDark;
    final cubit = di<SalonServiceCubit>();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          IntrinsicHeight(
            child: OverflowBox(
              maxWidth:MediaQuery.sizeOf(context).width,
              child: Container(
                color: isDark ? kGery27 :Color(0xFFF9F9F9),
                height: 8,
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TabBar(
              physics: const BouncingScrollPhysics(),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                    color: isDark ? kBabyBlue : accent,
                    width: 3
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              labelColor: isDark ? kBabyBlue : accent,
              unselectedLabelColor: isDark ? kWhite : kBlack,
              indicatorColor: kHint,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
              dividerColor: kTransparent,
              labelStyle: Theme.of(context).textTheme.bodyLarge,
              tabs: const [
                Tab(text: "الخدمات"),
                Tab(text: "عمال الصالون"),
              ],
              onTap: (index){
                cubit.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut
                );
              },
            ),
          ),
          IntrinsicHeight(
            child: OverflowBox(
              maxWidth:MediaQuery.sizeOf(context).width,
              child: Container(
                color: isDark ? kGery27 :Color(0xFFF9F9F9),
                height: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}