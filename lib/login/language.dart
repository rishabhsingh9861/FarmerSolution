import 'package:farmer_solution/login/lang.dart';
import 'package:farmer_solution/login/select_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constant.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final Uri _url = Uri.parse('https://msme.gov.in');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              const Lang(
                tex: 'Select Language / भाषा चुने',
              ),
              const SizedBox(
                height: 20,
              ),
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
                  )),
              const SizedBox(
                height: 200,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: InkWell(
                  onTap: () {
                    _launchUrl();
                  },
                  child: Image.asset(
                    'assets/icons/MSME_Logo.jpg',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 200,
                width: 250,
                child: InkWell(
                  onTap: () {
                    _launchUrl();
                  },
                  child: Image.asset(
                    'assets/icons/msme.jpg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
