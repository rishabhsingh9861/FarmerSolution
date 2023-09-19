import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/login/language.dart';
import 'package:farmer_solution/scientist/listof_problem.dart';
import 'package:farmer_solution/scientist/problemsolved.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertHomePage extends StatefulWidget {
  const ExpertHomePage({super.key, this.expemail});
  final String? expemail;

  @override
  State<ExpertHomePage> createState() => _ExpertHomePageState();
}

class _ExpertHomePageState extends State<ExpertHomePage> {
  String states = '';
  String emailid = '';
  void signUserOut() async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Language()));
    });
  }

  void getdata() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('ExpertUsers')
        .doc(widget.expemail)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

      states = userData['State'];
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
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
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ListOfProblem(
                                state: states,
                                emails: widget.expemail.toString(),
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
                      'problem'.tr,
                      style: textsty,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProblemSolved(
                                emails: widget.expemail,
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
                      'solution'.tr,
                      style: textsty,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  ;
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
                      'help'.tr,
                      style: textsty,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
