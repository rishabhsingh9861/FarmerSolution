import 'package:farmer_solution/farmer/home_page.dart';
import 'package:farmer_solution/login/language.dart';
import 'package:farmer_solution/scientist/scientisthomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  List<String> expertemail = ['gundaleyash23@gmail.com'];

  @override
  Widget build(BuildContext context) {
    String email = '';
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final User? user = snapshot.data;
          if (user != null) {
            email = user.email.toString();
          }

          for (int i = 0; i < expertemail.length; i++) {
            if (email == expertemail[i]) {
              return  ExpertHomePage(expemail: email,);
            }
          }
          return HomepageFarmer(
            emails: email,
          );
        } else {
          return const Language();
        }
      },
    ));
  }
}
