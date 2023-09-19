// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/farmer/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class FarmerData extends StatefulWidget {
  const FarmerData({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<FarmerData> createState() => _FarmerDataState();
}

class _FarmerDataState extends State<FarmerData> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _talukaController = TextEditingController();
  final _villageController = TextEditingController();
  final _pincodeController = TextEditingController();

  Future addUserDetails(String name, String email, String state,
      String district, String taluka, String village, int pincode) async {
    await FirebaseFirestore.instance.collection('Users').doc(email).set({
      'Name': name,
      'Email': email,
      'State': state,
      'District': district,
      'Taluka': taluka,
      'Village': village,
      'Pincode': pincode,
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _talukaController.dispose();
    _districtController.dispose();
    _villageController.dispose();
    super.dispose();
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "name".tr,
                      labelStyle: textsty,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    // if (validPincode( ) == false) {
                    //   return 'Please Provide valid pincode';
                    // }
                    return null;
                  },
                  controller: _nameController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "state".tr,
                      labelStyle: textsty,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state';
                    }
                    return null;
                  },
                  controller: _stateController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "district".tr,
                      labelStyle: textsty,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter district';
                    }
                    return null;
                  },
                  controller: _districtController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "taluka".tr,
                      labelStyle: textsty,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter taluka';
                    }
                    return null;
                  },
                  controller: _talukaController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "village".tr,
                      labelStyle: textsty,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  village';
                    }
                    return null;
                  },
                  controller: _villageController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "pincode".tr,
                      labelStyle: textsty,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pincode';
                    }
                    // int? a = int.tryParse(value);
                    // if (validPincode(a!) == false) {
                    //   return 'Please enter correct pincode';
                    // }
                    return null;
                  },
                  controller: _pincodeController,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    
                    if (_formKey.currentState!.validate()) {
                          
                      addUserDetails(
                              _nameController.text.trim(),
                              widget.email,
                              _stateController.text.trim(),
                              _districtController.text.trim(),
                              _talukaController.text.trim(),
                              _villageController.text.trim(),
                              int.parse(_pincodeController.text.trim()))
                          .then((value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => HomepageFarmer(
                                        emails: widget.email,
                                      ))));
                    }
                  },
                  child: Text(
                    'submit'.tr,
                    style: textsty,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
