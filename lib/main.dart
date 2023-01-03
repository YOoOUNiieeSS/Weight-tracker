import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/weight_app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

