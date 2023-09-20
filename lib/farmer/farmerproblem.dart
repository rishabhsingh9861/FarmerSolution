// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:farmer_solution/farmer/final_display.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../constant.dart';

class FarmerProblem extends StatefulWidget {
  const FarmerProblem({super.key, this.idss});
  final String? idss;

  @override
  State<FarmerProblem> createState() => _FarmerProblemState();
}

List<String> liststate = <String>[
  'Select State'.tr,
  'Andaman and Nicobar Islands'.tr,
  'Andhra Pradesh'.tr,
  'Arunachal Pradesh'.tr,
  'Assam'.tr,
  'Bihar'.tr,
  'Chandigarh'.tr,
  'Chhattisgarh'.tr,
  'Dadra and Nagar Haveli and Daman and Diu'.tr,
  'Delhi'.tr,
  'Goa'.tr,
  'Gujarat'.tr,
  'Haryana'.tr,
  'Himachal Pradesh'.tr,
  'Jammu and Kashmir'.tr,
  'Jharkhand'.tr,
  'Karnataka'.tr,
  'Kerala'.tr,
  'Ladakh'.tr,
  'Lakshadweep'.tr,
  'Madhya Pradesh'.tr,
  'Maharashtra'.tr,
  'Manipur'.tr,
  'Meghalaya'.tr,
  'Mizoram'.tr,
  'Nagaland'.tr,
  'Odisha'.tr,
  'Puducherry'.tr,
  'Punjab'.tr,
  'Rajasthan'.tr,
  'Sikkim'.tr,
  'Tamil Nadu'.tr,
  'Telangana'.tr,
  'Tripura'.tr,
  'Uttar Pradesh'.tr,
  'Uttarakhand'.tr,
  'West Bengal'.tr,
];

class _FarmerProblemState extends State<FarmerProblem> {
  final _formKey = GlobalKey<FormState>();
  final writeController = TextEditingController();
  final cropnameController = TextEditingController();
  String videoUrl = '';
  String imageUrl =
      'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg';

  String dropdownValueState = liststate.first;

  String stateData = '';

  Widget dropdownMenu<T>(
      List<T> list, T? dropdownValue, ValueChanged<T?> onChanged) {
    return DropdownButton<T>(
      value: dropdownValue,
      onChanged: onChanged,
      items: list.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'up'.tr,
                style: textst,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (file == null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Image not selected'),
                              );
                            });
                      } else {
                        String uniqueFilename =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference refrenceroot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            refrenceroot.child('Images');

                        Reference refrenceImageToUpload =
                            referenceDirImages.child(uniqueFilename);

                        try {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Please wait Uploading',
                                      style: TextStyle(
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              });
                          await refrenceImageToUpload.putFile(File(file.path));

                          imageUrl =
                              await refrenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('Image not uploaded'),
                                );
                              });
                        }

                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Image uploaded sucessfully'),
                              );
                            });
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/icons/photos-icon.png',
                              color: Colors.black,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'og'.tr,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.camera);

                      if (file == null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Image not selected'),
                              );
                            });
                      } else {
                        String uniqueFilename =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference refrenceroot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            refrenceroot.child('Images');

                        Reference refrenceImageToUpload =
                            referenceDirImages.child(uniqueFilename);

                        try {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Please wait Uploading',
                                      style: TextStyle(
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              });

                          await refrenceImageToUpload.putFile(File(file.path));

                          imageUrl =
                              await refrenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('Image not Uploaded'),
                                );
                              });
                        }
                        Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Image uploaded sucessfully'),
                              );
                            });
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/icons/camera-icon-54.png',
                              color: Colors.black,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'oc'.tr,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'uv'.tr,
                style: textst,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickVideo(
                          source: ImageSource.gallery);

                      if (file == null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('video not Selected'),
                              );
                            });
                      } else {
                        String uniqueFilename =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference refrenceroot = FirebaseStorage.instance.ref();
                        Reference referenceDirVideo =
                            refrenceroot.child('Videos');

                        Reference refrenceVideoToUpload =
                            referenceDirVideo.child(uniqueFilename);

                        try {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Please wait Uploading',
                                      style: TextStyle(
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              });
                          await refrenceVideoToUpload.putFile(File(file.path));

                          videoUrl =
                              await refrenceVideoToUpload.getDownloadURL();
                        } catch (error) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('video not uploaded'),
                                );
                              });
                        }
                        Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Video uploaded sucessfully'),
                              );
                            });
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/icons/photos-icon.png',
                              color: Colors.black,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'og'.tr,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickVideo(
                          source: ImageSource.camera);

                      if (file == null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Video not selected'),
                              );
                            });
                      } else {
                        String uniqueFilename =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference refrenceroot = FirebaseStorage.instance.ref();
                        Reference referenceDirVideo =
                            refrenceroot.child('Videos');

                        Reference refrenceVideoToUpload =
                            referenceDirVideo.child(uniqueFilename);

                        try {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Please wait Uploading',
                                      style: TextStyle(
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              });
                          await refrenceVideoToUpload.putFile(File(file.path));

                          videoUrl =
                              await refrenceVideoToUpload.getDownloadURL();
                        } catch (error) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('Video not uploaded'),
                                );
                              });
                        }
                        Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text('Image uploaded sucessfully'),
                              );
                            });
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/icons/camera-icon-54.png',
                              color: Colors.black,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'oc'.tr,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  dropdownMenu(liststate, dropdownValueState, (String? value) {
                setState(() {
                  dropdownValueState = value!;
                  stateData = dropdownValueState;
                });
              }),
            ),
            const SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text('cn'.tr),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.green)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(12))),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      controller: cropnameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text('wap'.tr),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.green)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.greenAccent),
                                borderRadius: BorderRadius.circular(12))),
                        controller: writeController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (stateData.isNotEmpty) {
                  if (imageUrl.isNotEmpty || videoUrl.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FinalDisplay(
                          email: widget.idss,
                          imageUrl: imageUrl,
                          videourl: videoUrl,
                          writefinal: writeController.text.trim(),
                          state: stateData,
                          crop: cropnameController.text.trim(),
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text('Please select Image/video'),
                        );
                      },
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content:
                            Text('Please select state and write crop name'),
                      );
                    },
                  );
                }
              },
              child: Center(
                child: Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.green),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'next'.tr,
                      style: textsty,
                    ),
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
