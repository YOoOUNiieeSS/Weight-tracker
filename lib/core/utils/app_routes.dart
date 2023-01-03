import 'package:flutter/material.dart';
import 'package:task/core/utils/app_strings.dart';
import 'package:task/presentation/screens/home_page.dart';
import 'package:task/sign_in_screen.dart';
import 'package:task/splash_screen.dart';

class AppRoutes{
  static const String homePage='home-page';
  static const String splashScreen='/';
  static const String signInScreen='sing-in-screen';

  static Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case homePage:
        return MaterialPageRoute(builder: (context)=> HomePage());//HomePageScreen());
      case splashScreen:
        return MaterialPageRoute(builder: (context)=>const SplashScreen());
      case signInScreen:
        return MaterialPageRoute(builder: (context)=>const SignInScreen());//SignInScreen());
      default:
        return MaterialPageRoute(builder: (context)=>const Scaffold(
          body: SafeArea(child: Center(child: Text(AppStrings.noRouteFound),)),
        ));
    }
  }
}