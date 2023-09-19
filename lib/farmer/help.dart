import 'package:flutter/material.dart';

import '../constant.dart';

class HelpFarmer extends StatefulWidget {
  const HelpFarmer({super.key});

  @override
  State<HelpFarmer> createState() => _HelpFarmerState();
}

class _HelpFarmerState extends State<HelpFarmer> {
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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Number: 1234567890',
              style: textsty,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Email: abc@gmail.com',
              style: textsty,
            ),
          )
        ],
      ),
    );
  }
}
