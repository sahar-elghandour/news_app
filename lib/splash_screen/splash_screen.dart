
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/utils/assets_manager.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';
import '../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
    });
  }
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(themeProvider.appTheme==ThemeMode.light? AssetsManager.splashLight:AssetsManager.splashDark),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}