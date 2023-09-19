import 'package:farmer_solution/scientist/scientist_login.dart';
import 'package:flutter/material.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/farmer/login_farmer.dart';
import 'package:get/get.dart';

class SelectLogin extends StatefulWidget {
  const SelectLogin({
    super.key,
  });

  @override
  State<SelectLogin> createState() => _SelectLoginState();
}

class _SelectLoginState extends State<SelectLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FarmerLogin()),
                  );
                },
                child: Center(
                  child: Text(
                    'farmerlogin'.tr,
                    style: textsty,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ScientistLogin()));
                },
                child: Center(
                  child: Text(
                    'expertlogin'.tr,
                    style: textsty,
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
