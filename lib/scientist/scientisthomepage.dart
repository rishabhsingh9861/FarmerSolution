import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/login/language.dart';
import 'package:farmer_solution/scientist/listof_problem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  signUserOut();
                },
                child: const Text(
                  'Signout',
                  style: textsty,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ListOfProblem(
                                state: states,
                                emails: widget.expemail.toString(),
                              )));
                },
                child: const Text(
                  'Problem',
                  style: textsty,
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'History',
                  style: textsty,
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Help',
                  style: textsty,
                )),
          ],
        ),
      ),
    );
  }
}
