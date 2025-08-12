import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme=ThemeData(
    primaryColor:  AppColors.whiteColor,
      indicatorColor: AppColors.blackColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          iconTheme: IconThemeData(
            color: AppColors.blackColor,),
          centerTitle: true
      ),
      textTheme: TextTheme(
        labelLarge: AppStyles.bold16Black,
          labelSmall:AppStyles.med12Grey,
          labelMedium: AppStyles.med14Black,
          headlineMedium: AppStyles.med24Black,
          headlineLarge: AppStyles.med20Black,
          headlineSmall: AppStyles.med14White

      )
  );
  static final ThemeData darkTheme=ThemeData(
      primaryColor:  AppColors.blackColor,
      indicatorColor: AppColors.whiteColor,
      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blackColor,
          iconTheme: IconThemeData(
            color: AppColors.whiteColor,),
          centerTitle: true
      ),
      textTheme: TextTheme(
          labelLarge: AppStyles.bold16White,
          labelSmall:AppStyles.med12Grey,
          labelMedium: AppStyles.med14White,
          headlineMedium: AppStyles.med24White,
          headlineLarge: AppStyles.med20White,
        headlineSmall: AppStyles.med14Black

      )
  );
}