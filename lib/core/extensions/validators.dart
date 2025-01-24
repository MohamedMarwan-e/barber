extension SaudiPhoneNumberValidation on String {
  bool isValidSaudiPhoneNumber({bool includeCountryCode = false}) {
    if (includeCountryCode) {
      // Validate full format with country code (+9665XXXXXXX)
      final saudiPhoneRegex = RegExp(r'^\+9665[0-9]{8}$');
      return saudiPhoneRegex.hasMatch(this);
    } else {
      // Validate user input without country code (5XXXXXXX)
      final saudiPhoneRegex = RegExp(r'^5[0-9]{8}$');
      return saudiPhoneRegex.hasMatch(this);
    }
  }
}

String? validateSaudiPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'الرجاء إدخال رقم الهاتف';
  }

  if (!value.isValidSaudiPhoneNumber()) {
    return 'يجب أن يبدأ رقم الهاتف بالرقم 5 ويتكون من 9 أرقام';
  }

  return null;
}


String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }


  final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!emailRegex.hasMatch(value)) {
    return 'يرجى إدخال بريد إلكتروني صحيح';
  }

  return null;
}


String? validateFullName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'يرجى إدخال الاسم الكامل';
  }

  final parts = value.trim().split(' ');
  if (parts.length < 2 || parts.any((part) => part.length < 2)) {
    return 'يرجى إدخال اسم كامل صالح (اسم أول واسم عائلة)';
  }

  final nameRegExp = RegExp(r'^[a-zA-Z\u0621-\u064A\s]+$'); // Supports Arabic and English letters
  if (!nameRegExp.hasMatch(value)) {
    return 'يرجى إدخال اسم يحتوي فقط على أحرف ومسافات';
  }

  return null;
}
