import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/app_cubit/localization_cubit.dart';
import '../../../core/dependency_injection.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr('lang')),
            ElevatedButton(
                onPressed: (){
                  di<LocalizationCubit>().changeLocale(context, 'en');

                  },
                child: Text('change lang')
            )
          ],
        ),
      ),
    );
  }
}
