part of '../otp_view.dart';

class _ResendOtp extends StatelessWidget {
  const _ResendOtp(this.otpCubit);
  final OtpCubit otpCubit;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
      bloc: otpCubit,
      builder: (context, state) {
        return Row(
          children: [
            Text(' لم يصلك كود التحقق؟ ',
                style: Theme.of(context).textTheme.labelSmall
            ),
            otpCubit.isResendEnabled ?
            InkWell(
                onTap: ()=> otpCubit.resendOTP(),
                child: Text('إعاده الإرسال',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    )
                )
            ):
            Text('${otpCubit.timerCount}',
                style: Theme.of(context).textTheme.labelSmall
            ),
          ],
        );
      },
    );
  }
}