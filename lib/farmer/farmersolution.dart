import 'package:farmer_solution/constant.dart';
import 'package:flutter/material.dart'; 

class FarmerSolution extends StatefulWidget {
  const FarmerSolution({super.key});

  @override
  State<FarmerSolution> createState() => _FarmerSolutionState();
}

class _FarmerSolutionState extends State<FarmerSolution> {
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