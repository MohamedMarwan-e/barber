import 'package:barber/app/app_cubit/theme_cubit.dart';
import 'package:barber/core/navigation/app_router.dart';
import 'package:barber/core/resources/color_manager.dart';
import 'package:barber/core/widgets/my_elevated_button.dart';
import 'package:barber/features/auth/cubits/otp/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/dependency_injection.dart';
import 'widgets/logo_title.dart';

part 'widgets/pin_code.dart';
part 'widgets/resend_otp.dart';

class OtpView extends StatefulWidget {
  const OtpView({required this.phone,super.key});
  final String phone;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final otpCubit = di<OtpCubit>();
  final isDark = di<ThemeCubit>().isDark;
  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    otpCubit.startTimer();
  }

  @override
  void dispose() {
    otpCubit.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height * 0.1,
            right: 12,
            left: 12,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LogoViewTitle('كود التحقق'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text('أكتب كود التحقق المرسل الى',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Color(0xFF191919),
                        )
                    ),
                    Text('+966${widget.phone}',
                        textDirection: TextDirection.ltr,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: kBlack
                        )
                    ),
                    InkWell(
                      onTap: ()=> context.pushReplacementNamed(loginView),
                      child: Text('تعديل',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _PinCode(otpCubit),
                _ResendOtp(otpCubit),
                Spacer(),
                MyElevatedButton(
                  isShadow: true,
                  onPressed: (){
                    if (formKey.currentState?.validate() ?? false) {
                      debugPrint("Valid PIN");
                      otpCubit.otp(phone: widget.phone,context: context);
                    }
                  },
                  text: 'تحقق الان',
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}