// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/farmer/final_display.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailedProblem extends StatefulWidget {
  const DetailedProblem({super.key, this.state, this.problemid, this.email});
  final String? state;
  final String? problemid;
  final String? email;

  @override
  State<DetailedProblem> createState() => _DetailedProblemState();
}

class _DetailedProblemState extends State<DetailedProblem> {
  String crop = '';
  String district = '';
  String name = '';
  String problemsendemail = '';
  String photourl = '';
  String pincode = '';
  String problem = '';
  String state = '';
  String taluka = '';
  String videourl = '';
  String village = '';
  String solutionImage = '';
  Timestamp time = Timestamp.now();

  final solutionController = TextEditingController();

  Future expertSolvedProblem(
      String photourls,
      String problems,
      String videourls,
      String states,
      String crops,
      String names,
      String districts,
      String talukas,
      String villages,
      String solutionimages,
      String solutions,
      Timestamp date,
      Timestamp times,
      int pincodes) async {
    await FirebaseFirestore.instance
        .collection('ExpertUsers')
        .doc(widget.email)
        .collection('SolvedProblem')
        .doc()
        .set({
      'Photo Url': photourls,
      'Problem': problems,
      'Video Url': videourls,
      'State': states,
      'Crop': crops,
      'Name': names,
      'District': districts,
      'Taluka': talukas,
      'Village': villages,
      'Pincode': pincodes,
      'Solution Image': solutionimages,
      'Solution': solutions,
      'date': date,
      'Solved Time': times,
    });
  }

  Future userSolution(
      String photourls,
      String problems,
      String videourls,
      String states,
      String crops,
      String names,
      String districts,
      String talukas,
      String villages,
      String solutionimages,
      String solutions,
      Timestamp date,
      Timestamp times,
      int pincodes) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(problemsendemail)
        .collection('Solution')
        .doc()
        .set({
      'Photo Url': photourls,
      'Problem': problems,
      'Video Url': videourls,
      'State': states,
      'Crop': crops,
      'Name': names,
      'District': districts,
      'Taluka': talukas,
      'Village': villages,
      'Pincode': pincodes,
      'Solution Image': solutionimages,
      'Solution': solutions,
      'date': date,
      'Solved Time': times,
    });
  }

  Future<void> deletesolvedProblem() async {
    FirebaseFirestore.instance
        .collection(widget.state.toString())
        .doc(widget.problemid)
        .delete();
  }

  Widget defaultimage(String? imgurl) {
    if (imgurl == null) {
      return Image.asset(
        'assets/icons/default-icon.png',
        color: Colors.black,
      );
    } else {
      return Image.network(
        imgurl,
      );
    }
  }

  Widget defaultvideosoln(String vidurl) {
    if (vidurl.isEmpty) {
      return SizedBox(
        height: 150,
        width: 150,
        child: Image.asset(
          'assets/icons/default-video.png',
          color: Colors.black,
        ),
      );
    } else {
      return Videoplayer(url: vidurl.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection(widget.state.toString())
            .doc(widget.problemid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('Document does not exist.'),
            );
          } else {
            final problem = snapshot.data!.data() as Map<String, dynamic>;
            name = '${problem['Name']}';
            crop = '${problem['Crop']}';
            district = '${problem['District']}';
            state = '${problem['State']}';
            taluka = '${problem['Taluka']}';
            village = '${problem['Village']}';
            pincode = '${problem['Pincode']}';
            photourl = '${problem['Photo Url']}';
            videourl = '${problem['Video Url']}';
            problemsendemail = '${problem['Email']}';
            Timestamp timestamp = problem['Time'];
            DateTime dateTime = timestamp.toDate();
            String formattedTime =
                dateTime.toLocal().toString().split('.').first;

            return Scaffold(
                appBar: appbar,
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 400,
                            width: 460,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'Name: $name',
                                    style: textsty,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'State: $state',
                                    style: textsty,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'District: $district',
                                    style: textsty,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'Taluka: $taluka',
                                    style: textsty,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'Village: $village',
                                    style: textsty,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'Pincode: $pincode',
                                    style: textsty,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'Crop: $crop',
                                    style: textsty,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'Time: $formattedTime',
                                    style: textsty,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 400,
                            width: 400,
                            child: defaultimage(photourl),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: 450,
                              width: 400,
                              child: defaultvideosoln(videourl)),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            '#Solution',
                            style: TextStyle(color: Colors.grey, fontSize: 25),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              child: SizedBox(
                                height: 150,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      label: const Text(
                                          'Solution {#Prefer problem language}'),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.green)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.greenAccent),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 1,
                                  controller: solutionController,
                                ),
                              ),
                            ),
                          ),
                          const Text('#If required add image'),
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
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Please wait Uploading',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                              CircularProgressIndicator(),
                                            ],
                                          );
                                        });
                                    await refrenceImageToUpload
                                        .putFile(File(file.path));

                                    solutionImage = await refrenceImageToUpload
                                        .getDownloadURL();
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
                                          content: Text(
                                              'Image uploaded sucessfully'),
                                        );
                                      });
                                }
                              },
                              child: Container(
                                  height: 35,
                                  width: 235,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3, color: Colors.green),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    ' Add Image From Gallery',
                                    style: textst,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  time = Timestamp.now();
                                  expertSolvedProblem(
                                      photourl,
                                      problem.toString(),
                                      videourl,
                                      state,
                                      crop,
                                      name,
                                      district,
                                      taluka,
                                      village,
                                      solutionImage,
                                      solutionController.text.trim(),
                                      timestamp,
                                      time,
                                      int.parse(pincode.toString()));

                                  userSolution(
                                      photourl,
                                      problem.toString(),
                                      videourl,
                                      state,
                                      crop,
                                      name,
                                      district,
                                      taluka,
                                      village,
                                      solutionImage,
                                      solutionController.text.toString(),
                                      timestamp,
                                      time,
                                      int.parse(pincode.toString()));

                                  deletesolvedProblem().then((value) =>
                                      showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const AlertDialog(
                                                  content: Text(
                                                      'Solution Sent Sucessfully'),
                                                );
                                              })
                                          .then((value) =>
                                              {Navigator.pop(context)}));
                                },
                                child: const Text(
                                  'Submit',
                                  style: textsty,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          }
        });
  }
}
