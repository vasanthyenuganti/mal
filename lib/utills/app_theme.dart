// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart'; // Import the AppColors class

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryAccentLight,
      scaffoldBackgroundColor: AppColors.secondaryBackgroundLight,

      // AppBar customizations
      appBarTheme: const AppBarTheme(
        backgroundColor:
            AppColors.primaryAccentLight, // AppBar background color
        foregroundColor: AppColors.primaryBackgroundLight, // AppBar text color
        centerTitle: true,
        elevation: 0,
        
      ),

      // TabBar customizations
      tabBarTheme: const TabBarTheme(
        indicatorColor: AppColors.primaryBackgroundLight,
        labelColor:
            AppColors.primaryBackgroundLight, // Color for selected tab label
        unselectedLabelColor: AppColors
            .secondaryBackgroundLight, // Color for unselected tab label
      ),

      // Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.primaryTextLight),
        bodyMedium: TextStyle(color: AppColors.secondaryTextLight),
      ),
      // Input Decoration Theme for Text Fields
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFieldBackgroundLight,
        hintStyle: TextStyle(color: AppColors.secondaryTextLight),
        labelStyle: TextStyle(color: AppColors.primaryTextLight),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.primaryAccentLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryAccentLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColorLight, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColorLight, width: 2),
        ),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.buttonTextLight,
          backgroundColor: AppColors.buttonBackgroundLight, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primaryBackgroundLight, elevation: 0));

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryAccentDark,
      scaffoldBackgroundColor: AppColors.secondaryBackgroundDark,

      // AppBar customizations
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor:
            AppColors.primaryBackgroundDark, // AppBar background color
        foregroundColor: AppColors.primaryTextDark, // AppBar text color
        iconTheme:
            IconThemeData(color: AppColors.primaryTextDark), // Icon color
        actionsIconTheme: IconThemeData(
            color: AppColors.primaryTextDark), // Icon in actions color
      ),

      // TabBar customizations
      tabBarTheme: const TabBarTheme(
        labelColor:
            AppColors.primaryBackgroundLight, // Color for selected tab label
        unselectedLabelColor:
            AppColors.secondaryTextDark, // Color for unselected tab label
        indicatorColor: AppColors.primaryBackgroundLight,
      ),

      // Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.primaryTextDark),
        bodyMedium: TextStyle(color: AppColors.secondaryTextDark),
      ),

      // Input Decoration Theme for Text Fields
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFieldBackgroundDark,
        hintStyle: TextStyle(color: AppColors.secondaryTextDark),
        labelStyle: TextStyle(color: AppColors.primaryTextDark),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.primaryAccentDark, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryAccentDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColorDark, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColorDark, width: 2),
        ),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.buttonTextDark,
          backgroundColor: AppColors.buttonBackgroundDark, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primaryBackgroundDark, elevation: 0));
}
