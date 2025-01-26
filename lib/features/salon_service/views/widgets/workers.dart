part of '../salon_service_view.dart';

class WorkersWidget extends StatelessWidget {
  const WorkersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = di<ThemeCubit>().isDark;
    final cubit = di<SalonServiceCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: MyGridView(
        width: MediaQuery.sizeOf(context).width,
        listLength: cubit.salonDetailsModel?.typeService.length ??0,
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        haveFittedBox: false,
        childBuilder: (int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyImage(
                ImageAssets.salon,
                height: 120,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 8),
              Text(cubit.salonDetailsModel?.typeService[index].name ??'',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: isDark ? kWhite : Color(0xFF263238)
                  ))
            ],
          );
        },

      ),
    );
  }
}
