import 'package:farmer_solution/login/lang.dart';
import 'package:farmer_solution/login/select_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
          const   Lang(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectLogin()));
                },
                child: Text(
                  'next'.tr,
                  style: textsty,
                ))
          ],
        ),
      ),
    );
  }
}
