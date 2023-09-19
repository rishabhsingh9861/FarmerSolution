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
    );
  }
}