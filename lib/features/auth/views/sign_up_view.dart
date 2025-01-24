import 'package:barber/features/auth/views/widgets/logo_title.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_cubit/theme_cubit.dart';
import '../../../core/dependency_injection.dart';
import '../../../core/extensions/validators.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/widgets/my_elevated_button.dart';
import '../../../core/widgets/my_text_field.dart';
import '../cubits/sign_up/sign_up_cubit.dart';


part 'widgets/user_info_form.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final cubit = di<SignUpCubit>();
  final isDark = di<ThemeCubit>().isDark;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cubit.nameController.dispose();
    cubit.emailController.dispose();
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
            right: 24,
            left: 24,
          ),
          child: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: SizedBox(
                        height:  MediaQuery.sizeOf(context).height * 0.1)
                ),
                SliverToBoxAdapter(
                    child: LogoViewTitle('إنشاء حساب')
                ),
                _UserInfoForm(cubit),
                SliverToBoxAdapter(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: 'بإنشاء حسابك أنت توافق على ',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: isDark ? kWhite :kBlack19
                      ),
                      children: [
                        TextSpan(
                          text: 'شروط وأحكام',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isDark ? kWhite :kBlack19,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: ' حلاق',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: isDark ? kWhite :kBlack19
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 24),
                  sliver: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 48,
                        child: MyElevatedButton(
                          isShadow: true,
                          onPressed: (){
                            if (formKey.currentState!.validate()) {
                              cubit.validateForm(context: context);
                            }
                           },
                          text: 'إنشاء حساب',
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}