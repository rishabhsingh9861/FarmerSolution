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
  'Select',
  'Delhi',
  'Rajasthan',
  'Bihar',
  'Maharashtra'
];
List<String> listcrop = <String>[
  'Select',
  'Wheat',
  'Bajra',
  'Sugarcanae',
  'Banana'
];

class _FarmerProblemState extends State<FarmerProblem> {
  final _formKey = GlobalKey<FormState>();
  final writeController = TextEditingController();
  String videoUrl = '';
  String imageUrl =
      'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg';

  String dropdownValueState = liststate.first;
  String dropdownValueCrop = listcrop.first;
  String stateData = '';
  String cropData = '';
  List<String> temp = List<String>.filled(2, "", growable: false);

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
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(55),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      key: _formKey,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            'assets/icons/photos-icon.png',
                            color: Colors.black,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        InkWell(
                            onTap: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? file = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (file == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Image Not Selected',
                                      style: textsty,
                                    ),
                                  ),
                                );
                              }

                              String uniqueFilename = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              Reference refrenceroot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  refrenceroot.child('Images');

                              Reference refrenceImageToUpload =
                                  referenceDirImages.child(uniqueFilename);

                              try {
                                await refrenceImageToUpload
                                    .putFile(File(file!.path));

                                imageUrl = await refrenceImageToUpload
                                    .getDownloadURL();
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      error.toString(),
                                      style: textsty,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text('photo from gallery'))
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            'assets/icons/camera-icon-54.png',
                            color: Colors.black,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        InkWell(
                            onTap: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? file = await imagePicker.pickImage(
                                  source: ImageSource.camera);

                              if (file == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Image Not Selected',
                                      style: textsty,
                                    ),
                                  ),
                                );
                              }

                              String uniqueFilename = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              Reference refrenceroot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  refrenceroot.child('Images');

                              Reference refrenceImageToUpload =
                                  referenceDirImages.child(uniqueFilename);

                              try {
                                await refrenceImageToUpload
                                    .putFile(File(file!.path));

                                imageUrl = await refrenceImageToUpload
                                    .getDownloadURL();
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      error.toString(),
                                      style: textsty,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text('camera open'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(55),
                ),
                child: Center(
                  child: Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(55),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  'assets/icons/videogallery.png',
                                  color: Colors.black,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickVideo(
                                      source: ImageSource.gallery);

                                  if (file == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Image Not Selected',
                                          style: textsty,
                                        ),
                                      ),
                                    );
                                  }

                                  String uniqueFilename = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();

                                  Reference refrenceroot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirVideo =
                                      refrenceroot.child('Videos');
                                

                                  Reference refrenceVideoToUpload =
                                      referenceDirVideo.child(uniqueFilename);

                                  try {
                                    await refrenceVideoToUpload
                                        .putFile(File(file!.path));

                                    videoUrl = await refrenceVideoToUpload
                                        .getDownloadURL();
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          error.toString(),
                                          style: textsty,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Video from gallery',
                                  style: textsty,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  'assets/icons/camera-icon-54.png',
                                  color: Colors.black,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              InkWell(
                                  onTap: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? file = await imagePicker.pickVideo(
                                        source: ImageSource.camera);

                                    if (file == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Image Not Selected',
                                            style: textsty,
                                          ),
                                        ),
                                      );
                                    }

                                    String uniqueFilename = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();

                                    Reference refrenceroot =
                                        FirebaseStorage.instance.ref();
                                    Reference referenceDirVideo =
                                        refrenceroot.child('Videos');
                                    // Reference referenceDirImages =
                                    //     refrenceroot.child('Images');

                                    Reference refrenceVideoToUpload =
                                        referenceDirVideo.child(uniqueFilename);

                                    try {
                                      await refrenceVideoToUpload
                                          .putFile(File(file!.path));

                                      videoUrl = await refrenceVideoToUpload
                                          .getDownloadURL();
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            error.toString(),
                                            style: textsty,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('take vodeo'))
                            ],
                          ),
                        ],
                      )),
                )),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: dropdownMenu(liststate, dropdownValueState,
                      (String? value) {
                    setState(() {
                      dropdownValueState = value!;
                      temp[0] = dropdownValueState.toString();
                    });
                  }),
                ),
                const SizedBox(
                  width: 15,
                ),
                dropdownMenu(listcrop, dropdownValueCrop, (String? value) {
                  setState(() {
                    dropdownValueCrop = value!;
                    temp[1] = dropdownValueCrop.toString();
                  });
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
               
                child: SizedBox(
                  height: 150,
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: const Text('Write a problem'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(12))),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 1,
                    controller: writeController,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (temp[0].isNotEmpty && temp[1].isNotEmpty) {
                  stateData = temp[0];
                  cropData = temp[1];

                  if (imageUrl.isNotEmpty || videoUrl.isNotEmpty)  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FinalDisplay(
                          email: widget.idss,
                          imageUrl: imageUrl,
                          videourl: videoUrl,
                          writefinal: writeController.text.trim(),
                          state: stateData,
                          crop: cropData,
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
                        content: Text('Please select both state and crop'),
                      );
                    },
                  );
                }
              },
              child: Text(
                'next'.tr,
                style: textsty,
              ),
            )
          ],
        ),
      ),
    );
  }
}
