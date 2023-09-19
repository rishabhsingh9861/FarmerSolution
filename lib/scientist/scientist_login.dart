import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/scientist/scientisthomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScientistLogin extends StatefulWidget {
  const ScientistLogin({super.key});

  @override
  State<ScientistLogin> createState() => _ScientistLoginState();
}

class _ScientistLoginState extends State<ScientistLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String email = '';

  void homepageexpert() async {
    email = _emailController.text.trim().toString();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ExpertHomePage(expemail: email.toString())));
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (context) {
            return  AlertDialog(
              content: Text(e.toString()),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "login Email".tr,
                        labelStyle: textsty,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(12))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Registered Email';
                      }
                      return null;
                    },
                    controller: _emailController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "password".tr,
                        labelStyle: textsty,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(12))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       print(_emailController);
                //     },
                //     child: Text('Check')),
                // const SizedBox(
                //   height: 10,
                // ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        homepageexpert();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: textsty,
                    ))
              ],
            ),
          )),
    );
  }
}
