import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/utils/app_color.dart';
import 'package:task/core/utils/app_routes.dart';
import 'package:task/presentation/provider/main_provider.dart';
import 'package:task/presentation/provider/weight_provider.dart';
import 'package:task/splash_screen.dart';
import 'package:task/injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       Provider(create: (context)=>MainProvider()..init(),),
      ],

      builder: (context,_)=>
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColor.primaryColor
        ),
        onGenerateRoute: AppRoutes.onGenerateRoute
      ),
    );
  }
}