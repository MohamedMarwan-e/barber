part of '../sign_up_view.dart';
class _UserInfoForm extends StatelessWidget {
  const _UserInfoForm(this.cubit);
  final SignUpCubit cubit;

  @override
  Widget build(BuildContext context) {
    final isDark = di<ThemeCubit>().isDark;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الاسم كامل',
              style: Theme.of(context).textTheme.labelLarge
          ),
          SizedBox(height: 8),
          MyTextField(
            controller: cubit.nameController,
            textType: TextInputType.text,
            hintText: 'ادخل اسمك كامل',
            fillColorTextFiled: isDark ? kGery27 : kWhite,
            enabledBorderColor: isDark ? kGery27 : kFieldBorder,
            inputTextColor: isDark ? kWhite : kBlack,
            hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 12,color: isDark ? kWhite :kHint
            ),
            validatorFunction: validateFullName,

          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(' الأيميل ',
                  style: Theme.of(context).textTheme.labelLarge
              ),
              Text('(اختياري)',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: kHint,fontSize: 12
                  )
              ),
            ],
          ),
          SizedBox(height: 8),
          MyTextField(
            controller: cubit.emailController,
            textType: TextInputType.emailAddress,
            hintText: 'اكتب ايميلك (اختياري)',
            fillColorTextFiled: isDark ? kGery27 : kWhite,
            enabledBorderColor: isDark ? kGery27 : kFieldBorder,
            inputTextColor: isDark ? kWhite : kBlack,
            hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 12,color: isDark ? kWhite :kHint
            ),
            validatorFunction: validateEmail,
          ),
          SizedBox(height: 16),
          Text('اختيار الجنس',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(horizontal: -4),
                      value: 'male',
                      groupValue: cubit.gender,
                      onChanged: cubit.changeGender,
                      title: Text(
                        'ذكر',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: isDark ?kgGrey3E:kHint
                        ),
                      ),
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return isDark ? kWhite : accent;
                        }
                        return accent;
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(horizontal: -4),
                      value: 'female',
                      groupValue: cubit.gender,
                      onChanged: cubit.changeGender,
                      title: Text(
                        'أنثى',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: isDark ?kgGrey3E:kHint
                        ),
                      ),
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return isDark ? kWhite : accent;
                        }
                        return accent;
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 8),
          Text('المدينة',
              style: Theme.of(context).textTheme.labelLarge
          ),
          SizedBox(height: 8),
          BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'اختر مدينتك',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 12, color: isDark ? kWhite :kHint
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  items: cubit.cities.map((city) => DropdownMenuItem<Map<String, dynamic>>(
                    value: city,
                    child: Text(
                      city['name'],
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 12,
                      ),
                    ),
                  )).toList(),
                  value: cubit.selectedCity,
                  onChanged: cubit.selectCity,
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  buttonStyleData: ButtonStyleData(
                    padding: EdgeInsetsDirectional.only(end: 12),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? kGery27 : Colors.grey.shade300,
                      ),
                      color: isDark ? kGery27 : kWhite ,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    direction: DropdownDirection.textDirection,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isDark ? kGery27 : kWhite,

                    ),
                  ),
                ),
              );
            }),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}