part of '../home_view.dart';

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget();

  @override
  Widget build(BuildContext context) {
    final localizationCubit = di<LocalizationCubit>();

    final themeCubit = di<ThemeCubit>();
    final isDarkTheme = themeCubit.isDark;
    final currentThemeMode = themeCubit.state;


    return Drawer(
      child: Column(
        children: [
          const DrawerHeaderWidget(),
          SizedBox(height: 12),
          DropDownButton(
            title: 'lang',
            image: isDarkTheme ? SvgAssets.darkLanguage: SvgAssets.language,
            imageSize: 24,
            valueToShow: localizationCubit.getCurrentLanguage().name,
            value: localizationCubit.getCurrentLanguage(),
            items: Languages.values.map((lang) {
              return DropdownMenuItem<Languages>(
                value: lang,
                child: Text(lang.name),
              );
            }).toList(),
            onChanged: (selectedLanguage) {
              if (selectedLanguage is Languages) {
                localizationCubit.changeLocale(context, selectedLanguage);
              }
            },
          ),
          SizedBox(height: 16),
          DropDownButton(
            title: 'Theme',
            image: isDarkTheme ? SvgAssets.darkMode: SvgAssets.mode,
            imageSize: 24.0,
            valueToShow: getThemeName(currentThemeMode),
            value: currentThemeMode,
            items: ThemeMode.values.map((themeMode) {
              return DropdownMenuItem<ThemeMode>(
                value: themeMode,
                child: Text(getThemeName(themeMode)),
              );
            }).toList(),
            onChanged: (selectedThemeMode) {
              if (selectedThemeMode is ThemeMode) {
                themeCubit.setTheme(selectedThemeMode);
              }
            },
          ),
          Spacer(),
          TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyImage(SvgAssets.logOut),
                  SizedBox(width: 12),
                  Text("تسجيل الخروج",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                         color: kRed
                      )
                  ),
                ],
              )
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}