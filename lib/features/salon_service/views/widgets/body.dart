part of '../salon_service_view.dart';

class _Body extends StatelessWidget {
  const _Body(this.id);
  final String id;
  @override
  Widget build(BuildContext context) {
    final isDark = di<ThemeCubit>().isDark;
    final cubit = di<SalonServiceCubit>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ?kBlack19 :kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if(state is SalonDetailsError){
            return Center(
              child: Text(state.error,
              style: Theme.of(context).textTheme.bodyLarge
              ),
            );
          }
          else if(state is SalonDetailsLoading){
            return  SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: Center(
                  child: SpinKitSpinningLines(
                      color: isDark ? kWhite: primaryColor, size: 30)
              ),
            );
          }
          return Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Text(cubit.salonDetailsModel?.name ??'',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 20
                      )
                  ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.star_fill,
                    size: 16,
                    color: const Color(0xFFF4C01E),
                  ),
                  const SizedBox(width: 4),
                  Text(
                      cubit.salonDetailsModel?.rateAvg ??'',
                    style: Theme.of(context).textTheme.labelMedium
                  ),
                ],
              ),
              SizedBox(height: 18),
              SizedBox(
               width: MediaQuery.sizeOf(context).width,
                child: Text(cubit.salonDetailsModel?.desc ??'',
                    maxLines: 3,
                    textAlign: TextAlign.start,

                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDark ? kWhite :Color(0xFF263238)
                    )
                ),
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  MyImage(SvgAssets.barber,width: 24,height: 24),
                  SizedBox(width: 8),
                  Text(' عدد العمال:' ' ${cubit.salonDetailsModel?.countProviders ??''} حلاقين مختصين',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? kWhite :Color(0xFF263238)
                      )
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  MyImage(SvgAssets.clock,width: 24,height: 24),
                  SizedBox(width: 12,),
                  Text('ساعات العمل: ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? kWhite :Color(0xFF263238)
                      )),
                    Text(cubit.salonDetailsModel?.hourWork ??'',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: (cubit.salonDetailsModel?.isOpen ?? false) ?
                        successGreen : kRed,
                        decorationColor: (cubit.salonDetailsModel?.isOpen ?? false) ?
                        successGreen : kRed,
                      ),
                  ),
                  Text(' ${cubit.salonDetailsModel?.timeOpen ??''} ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark ? kWhite :Color(0xFF263238)
                    ),
                  ),
                ],
              ),
              SizedBox(height: 38),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDark ? kGery27 :Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('هل حاز الصالون إعجابك؟',
                        style: Theme.of(context).textTheme.bodySmall
                    ),
                    MyElevatedButton(
                      onPressed: (){
                        Share.share('https://example.com/salonService?id=$id');
                      },
                      width: 170,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyImage(SvgAssets.share),
                          SizedBox(width: 12,),
                          Text('شاركه مع اصدقاءك',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: kWhite
                            ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              _TabBar(),
              _TabBarViews(),
            ],
          );
          },
      ),
    );
  }
}