part of '../salon_service_view.dart';

class SalonServicesWidget extends StatelessWidget {
  const SalonServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = di<ThemeCubit>().isDark;
    final cubit = di<SalonServiceCubit>();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: cubit.salonDetailsModel?.providers.length ??0,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return Container(
            height: 70,
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kFieldBorder),
            ),
            child: Row(
              children: [
                MyImage(
                  cubit.salonDetailsModel?.providers[index].avatar ??'',
                  width: 100,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 172,
                      child: Row(
                        children: [
                          Text(cubit.salonDetailsModel?.providers[index].name ??'',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                color: isDark? kWhite :Color(0xFF263238),
                                fontSize: 12
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
                              cubit.salonDetailsModel?.providers[index].rateAvg ??'',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontSize: 10
                              )
                          ),
                        ],
                      ),
                    ),
                    Text(cubit.salonDetailsModel?.providers[index].nationality ??'',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: isDark? kWhite :Color(0xFF263238),
                            fontSize: 12
                        )
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
