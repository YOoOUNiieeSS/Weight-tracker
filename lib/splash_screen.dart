import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task/core/utils/app_color.dart';
import 'package:task/core/utils/app_routes.dart';
import 'package:task/core/utils/app_strings.dart';
import 'package:task/presentation/provider/main_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){

      if(Provider.of<MainProvider>(context,listen: false).isLogged){
        Navigator.of(context).pushReplacementNamed(AppRoutes.homePage);
      }else{
        Navigator.of(context).pushReplacementNamed(AppRoutes.signInScreen);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(AppStrings.splashScreenImage,fit: BoxFit.fill,)),
                  )),
              const SizedBox(height: 25,),
              const Expanded(
                flex: 2,
                  child: Text(
                'Weight Tracker App',
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: AppColor.greyColor),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
