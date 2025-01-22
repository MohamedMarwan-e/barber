import 'package:flutter/material.dart';

import '../core/resources/color_manager.dart';


ThemeData appTheme(String usedFontFamily) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,

    scaffoldBackgroundColor: kWhite,
    cardColor: Colors.white,
    secondaryHeaderColor: const Color(0xFF262d31),
    dividerColor: graySwatch.shade200,
    fontFamily: usedFontFamily,

    colorScheme: ColorScheme.light(
      surface: graySwatch.shade50,
      secondary: secondaryColor,
      primary: primaryColor,
    ),
    primaryIconTheme: IconThemeData(
      color: graySwatch.shade600,
      size: 24,
    ),
    iconTheme: IconThemeData(
      color: graySwatch.shade600,
      size: 24,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      color: kWhite,
      toolbarHeight: 64,
      titleTextStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18 ,
        fontWeight: FontWeight.w600,
        fontFamily: usedFontFamily,
      ),
      iconTheme: IconThemeData(
        color: graySwatch.shade600,
        size: 24,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1,
      type:BottomNavigationBarType.fixed,
      backgroundColor: graySwatch.shade100,
      selectedLabelStyle: TextStyle(
        fontFamily: usedFontFamily,
        color: primaryColor,
        fontSize: 14 ,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: usedFontFamily,
        color: graySwatch.shade500,
        fontSize: 12 ,
        fontWeight: FontWeight.w300,
      ),
      unselectedIconTheme: IconThemeData(color: graySwatch.shade400),
      selectedIconTheme: const IconThemeData(color: primaryColor),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: primaryColor,
      unselectedItemColor: graySwatch.shade600,
    ),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: primaryColor,
      textColor: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
              (states) => primaryColor,
        ),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: graySwatch.shade200,
    ),
    textTheme: _buildTextTheme(usedFontFamily),
    datePickerTheme: DatePickerThemeData(
      weekdayStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 ,
        fontWeight: FontWeight.w500,
      ),
      dayStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 ,
        fontWeight: FontWeight.w500,
      ),
      yearStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 ,
        fontWeight: FontWeight.w500,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

ThemeData darkTheme(String usedFontFamily) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: usedFontFamily,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: secondaryColor,
    cardColor: graySwatch.shade800,
    dividerColor: graySwatch.shade600,
    colorScheme: ColorScheme.dark(
      surface: graySwatch.shade900,
      secondary: secondaryColor,
      primary: primaryColor,
    ),
    primaryIconTheme: IconThemeData(
      color: graySwatch.shade200,
      size: 24,
    ),
    iconTheme: IconThemeData(
      color: graySwatch.shade200,
      size: 24,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: kTransparent,
      centerTitle: true,
      elevation: 0,
      color: secondaryColor,
      toolbarHeight: 64,
      titleTextStyle: TextStyle(
        color: kWhite,
        fontSize: 18 ,
        fontWeight: FontWeight.w600,
        fontFamily: usedFontFamily,
      ),
      iconTheme: IconThemeData(
        color: graySwatch.shade300,
        size: 24,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: graySwatch.shade900,
      selectedLabelStyle: TextStyle(
        fontFamily: usedFontFamily,
        color: graySwatch.shade100,
        fontSize: 16 ,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: usedFontFamily,
        color: graySwatch.shade100,
        fontSize: 14 ,
        fontWeight: FontWeight.w400,
      ),
      unselectedIconTheme: IconThemeData(color: graySwatch.shade100),
      selectedIconTheme: IconThemeData(color: graySwatch.shade100),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: graySwatch.shade100,
      unselectedItemColor: graySwatch.shade300,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: primaryColor,
      textColor: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kWhite),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kWhite),
        backgroundColor: WidgetStateProperty.all(primaryColor),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kWhite),
        side: WidgetStateProperty.all(BorderSide(color: kWhite)),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor, // For old button widgets
      textTheme: ButtonTextTheme.primary,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        onPrimary: kWhite,
      ),
    ),

    dividerTheme: DividerThemeData(
      color: graySwatch.shade600,
    ),
    textTheme: _buildTextTheme(usedFontFamily,isDarkMode: true),
    datePickerTheme: DatePickerThemeData(
      weekdayStyle: TextStyle(
        color: graySwatch.shade200,
        fontSize: 20 ,
        fontWeight: FontWeight.w500,
      ),
      dayStyle: TextStyle(
        color: graySwatch.shade200,
        fontSize: 20 ,
        fontWeight: FontWeight.w500,
      ),
      yearStyle: TextStyle(
        color: graySwatch.shade200,
        fontSize: 20 ,
        fontWeight: FontWeight.w500,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

TextTheme _buildTextTheme(String fontFamily, {bool isDarkMode = false}) {
  final textColor = isDarkMode ? kWhite : kBlack;

  return TextTheme(
    // Headline (for section titles or important text)
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily,
      color: textColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily,
      color: textColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily,
      color: textColor,
    ),

    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily,
      color: textColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily,
      color: textColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
      color: textColor,
    ),

    // Display (for larger headings or display texts)
    displayLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
      color: textColor,
    ),
    displayMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      color: textColor,
    ),
    displaySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      color: textColor,
    ),

    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      color: textColor,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      color: textColor,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      color: textColor,
    ),
  );
}


