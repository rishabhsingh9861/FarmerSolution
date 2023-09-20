import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/farmer/farmer_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FarmerLogin extends StatefulWidget {
  const FarmerLogin({super.key});

  @override
  State<FarmerLogin> createState() => _FarmerLoginState();
}

class _FarmerLoginState extends State<FarmerLogin> {
  String emailid = '';
  String useruid = '';
  List usersall = [];
  voidCallbackAction() {}
  Future signInWithGoogle() async {
    showDialog(
        context: context,
        builder: (_) {
          return const Center(child: CircularProgressIndicator());
        });

    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final GoogleSignInAccount? guser = await googleSignIn.signIn();
    if (guser != null) {
      emailid = guser.email;
      useruid = guser.id;
      
      final GoogleSignInAuthentication gauth = await guser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken,
      );
      return FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Navigator.of(context).popUntil((route) => route.isFirst);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => FarmerData(
                      email: emailid,
                    )));
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      });
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> alluser() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc().get();

    usersall.add(snapshot);
  }

  @override
  void initState() {
    alluser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () {
                  
                  signInWithGoogle();
               
                },
                child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          border: const Border(
                              bottom: BorderSide(),
                              top: BorderSide(),
                              left: BorderSide(),
                              right: BorderSide()),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/icons/google_icon.png'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'google'.tr,
                            style: textsty,
                          )
                        ],
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}
