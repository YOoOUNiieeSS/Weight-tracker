import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/utils/app_strings.dart';
import 'package:task/injection_container.dart' as di;

class MainProvider extends ChangeNotifier{
  SharedPreferences sharedPreferences;
  FirebaseAuth firebaseAuth;
  MainProvider._internal({required this.sharedPreferences,required this.firebaseAuth});
  static final MainProvider instance = MainProvider._internal(sharedPreferences: di.sl(),firebaseAuth: di.sl());
  factory MainProvider() => instance;

  static MainProvider get(context)=>Provider.of(context,listen: false);
  bool isLogged=false;
  User? user;
  init(){
    isLogged=sharedPreferences.getBool(AppStrings.isLogged)??false;
    notifyListeners();
  }

  Future<void> signIn()async{
    final userCred = await firebaseAuth.signInAnonymously();
    user=userCred.user;
    isLogged=true;
    sharedPreferences.setBool(AppStrings.isLogged, isLogged);
    notifyListeners();
  }
  Future<void> signOut()async{
    await firebaseAuth.signOut();
    isLogged=false;
    sharedPreferences.setBool(AppStrings.isLogged, isLogged);
    notifyListeners();
  }

}