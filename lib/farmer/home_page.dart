// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:farmer_solution/login/lang.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:farmer_solution/farmer/farmerproblem.dart';
import 'package:farmer_solution/farmer/farmersolution.dart';
import 'package:farmer_solution/farmer/help.dart';
import 'package:farmer_solution/login/language.dart';

import '../constant.dart';

class HomepageFarmer extends StatefulWidget {
  const HomepageFarmer({super.key, this.emails});
  final String? emails;

  @override
  State<HomepageFarmer> createState() => _HomepageFarmerState();
}

class _HomepageFarmerState extends State<HomepageFarmer> {
  void signUserOut() async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Language()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
        centerTitle: true,
        title: const Text(
          'कृषि समाधान',
          style: textsty,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  signUserOut();
                },
                child: Row(
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/icons/signout.png')),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      'Sign Out',
                      style: textsty,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FarmerProblem(idss: widget.emails)));
                },
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'myproblem'.tr,
                      style: textsty,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  FarmerSolution(
                      emailid: widget.emails,
                    )));
              },
              child: Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'mysolution'.tr,
                    style: textsty,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HelpFarmer()));
              },
              child: Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'help'.tr,
                    style: textsty,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            const Lang(
              tex: 'Change Language / भाषा बदलें',
            ),
          ],
        ),
      ),
    );
  }
}
