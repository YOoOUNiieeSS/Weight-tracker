import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/utils/app_color.dart';
import 'package:task/core/utils/app_routes.dart';
import 'package:task/core/utils/app_strings.dart';
import 'package:task/presentation/provider/main_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome".toUpperCase(),style: const TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Text('Get started by logging into Your Account.',style: TextStyle(color: AppColor.greyColor,fontSize: 18),),
              const SizedBox(height: 40,),
              Consumer<MainProvider>(
                builder: (context,mainProvider,_)=>
                    ElevatedButton(
                    onPressed: ()async{
                      await mainProvider.signIn();
                      if(mainProvider.user!=null){
                        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: Text("Sign in".toUpperCase(),style: const TextStyle(fontSize: 18),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
