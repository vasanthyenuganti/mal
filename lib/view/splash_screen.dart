// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mal/utills/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Hero(
        tag: "app_icon",
        child: Center(
          child: SvgPicture.asset(
            'assets/app_icon.svg',
            color: MediaQuery.of(context).platformBrightness.index == 1
                ? AppColors.buttonBackgroundLight
                : AppColors.primaryBackgroundLight,
            height: 240,
            width: 240,
          ),
        ),
      )),
    );
  }
}
