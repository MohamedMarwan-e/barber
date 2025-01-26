part of '../home_view.dart';
class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final cubit = di<HomeCubit>();
    final isDark = di<ThemeCubit>().isDark;

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is HomeInitial || state is PaginationLoading && cubit.salonsList.isEmpty) {
          return Center(child: SpinKitSpinningLines(color:isDark?kWhite: primaryColor, size: 30));
        } else if (state is PaginationError && cubit.salonsList.isEmpty) {
          return Center(
            child: Text(
              state.error,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification && scrollNotification.metrics.pixels ==
                    scrollNotification.metrics.maxScrollExtent && !cubit.isFetching) {
              cubit.fetchSalons();
            }
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ListView.builder(
              itemCount: cubit.salonsList.length + (state is PaginationLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == cubit.salonsList.length) {
                  return Center(child: SpinKitSpinningLines(color:isDark?kWhite: primaryColor, size: 30));
                }

                final salon = cubit.salonsList[index];
                return Container(
                  height: 110,
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kFieldBorder),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: ()=> context.pushNamed(salonServiceView,
                      queryParameters: {'id': salon.id.toString()}
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyImage(
                          ImageAssets.salon,
                          width: 100,height: 100,
                          radius: 16,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              salon.name,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              salon.desc,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 10,
                                  color:isDark ?kWhite: const Color(0xFF263238)
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width - 180,
                              child: Row(
                                children: [
                                  Text(
                                    'يشمل خدمات ' '( ',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontSize: 10,
                                        color:isDark ?kWhite: const Color(0xFF263238)
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width - 264,
                                    height: 20,
                                    child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: salon.services.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context,index){
                                        return Center(
                                          child: Text(
                                              salon.services[index].name,
                                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                  fontSize: 10,
                                                  color: isDark ?kWhite: const Color(0xFF263238)
                                              )),
                                        );
                                        }, separatorBuilder: (BuildContext context, int index) {
                                          return Center(
                                            child: Text(' - ',
                                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                fontSize: 10,
                                                    color: isDark ?kWhite:const Color(0xFF263238)
                                            )),
                                          );
                                    },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.star_fill,
                                  size: 16,
                                  color: Color(0xFFF4C01E),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  salon.rateAvg,
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontSize: 8,
                                      color:isDark ?kWhite: kHint
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Text('(${salon.countRate.toInt()})',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontSize: 8
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Icon(Icons.location_on_outlined,
                                  size: 16,
                                  color:isDark ? kBabyBlue: primaryColor,
                                ),
                                Text(
                                  '${salon.distance}' ' كم ',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      fontSize: 8,
                                      color: isDark ? kBabyBlue: primaryColor
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
