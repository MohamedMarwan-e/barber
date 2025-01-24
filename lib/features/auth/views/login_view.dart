import 'package:barber/app/app_cubit/theme_cubit.dart';
import 'package:barber/core/resources/assets_manager.dart';
import 'package:barber/core/resources/color_manager.dart';
import 'package:barber/core/widgets/my_elevated_button.dart';
import 'package:barber/core/widgets/my_images.dart';
import 'package:barber/core/widgets/my_text_field.dart';
import 'package:barber/features/auth/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/dependency_injection.dart';
import '../../../core/extensions/validators.dart';
import 'widgets/logo_title.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final cubit = di<LoginCubit>();
  final isDark = di<ThemeCubit>().isDark;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cubit.phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height * 0.1,
            right: 24,
            left: 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LogoViewTitle('تسجيل الدخول'),
                Text('رقم الجوال',
                  style: Theme.of(context).textTheme.labelLarge
                ),
                SizedBox(height: 16),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: MyTextField(
                    controller: cubit.phoneController,
                    textType: TextInputType.phone,
                    hintText: '50xxxxxxx',
                    fillColorTextFiled: isDark ? kGery27 : kWhite,
                    enabledBorderColor: isDark ? kGery27 : kFieldBorder,
                     inputTextColor: isDark ? kWhite : kBlack,
                    hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 12,color: isDark ? kWhite :kHint
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    prefixIconWidget: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyImage(SvgAssets.saudi,width: 24,height: 18),
                          SizedBox(width: 12),
                          Text('+966',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 12
                              )
                          ),
                          SizedBox(width: 6),
                          VerticalDivider()
                        ],
                      ),
                    ),
                    validatorFunction: validateSaudiPhoneNumber,

                  ),
                ),
                SizedBox(height: 36),
                MyElevatedButton(
                  isShadow: true,
                  onPressed: (){
                    if (formKey.currentState!.validate()) {
                      cubit.login(context: context);
                    }
                  },
                  text: 'تسجيل الدخول',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}