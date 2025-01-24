part of '../otp_view.dart';

class _PinCode extends StatelessWidget {
  const _PinCode(this.otpCubit);
  final OtpCubit otpCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width -24,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          controller: otpCubit.pinCodeController,
          autovalidateMode: AutovalidateMode.disabled,

          appContext: context,
          textStyle: const TextStyle(color: Colors.black),
          length: 4,
          obscureText: false,
          animationType: AnimationType.fade,
          cursorColor: kBabyBlue,
          pinTheme: PinTheme(
              borderWidth: 1,
              shape: PinCodeFieldShape.box,
              inactiveFillColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 60,
              fieldWidth: 60,
              activeFillColor: kWhite,
              activeColor: primaryColor,
              inactiveColor: Colors.grey[200],
              selectedFillColor: kWhite,
              selectedColor: primaryColor
          ),
          keyboardType: TextInputType.number,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'من فضلك أدخل رمز التحقق';
            }
            if (value.length != 4) {
              return 'رمز التحقق يجب أن يكون مكوناً من 4 أرقام';
            }
            return null;
          },
          onCompleted: (value) {},
          onChanged: (value) {
            debugPrint(value);
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            return true;
          },
        ),
      ),
    );
  }
}