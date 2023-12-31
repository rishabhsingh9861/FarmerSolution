import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';

class HelpFarmer extends StatefulWidget {
  const HelpFarmer({super.key});

  @override
  State<HelpFarmer> createState() => _HelpFarmerState();
}

class _HelpFarmerState extends State<HelpFarmer> {
  final Uri _url = Uri.parse('https://msme.gov.in');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Number: 1234567890',
              style: textsty,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Email: abc@gmail.com',
              style: textsty,
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          Center(
            child: SizedBox(
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
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: SizedBox(
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
          ),
        ],
      ),
    );
  }
}
