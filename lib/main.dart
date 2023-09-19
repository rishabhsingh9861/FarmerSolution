import 'package:farmer_solution/autheticate/aunthenticate.dart';
import 'package:farmer_solution/login/languages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async{
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalLanguage(),
     
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.lightGreen,
        
      ),
      home: const AuthPage(),
    );
  }
}

  