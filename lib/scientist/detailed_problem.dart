// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
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
  String p = '';
  final _formKey = GlobalKey<FormState>();
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
    });
  }

  Future<void> deletesolvedProblem() async {
    FirebaseFirestore.instance
        .collection(widget.state.toString())
        .doc(widget.problemid)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.state.toString())
          .doc(widget.problemid.toString())
          .collection('DetailedProblem')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: appbar,
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final problem =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

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

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Name: $name',
                              style: textsty,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'State: $state',
                              style: textsty,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'District: $district',
                              style: textsty,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Taluka: $taluka',
                              style: textsty,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Village: $village',
                              style: textsty,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Pincode: $pincode',
                              style: textsty,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Crop: $crop',
                              style: textsty,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // SizedBox(
                            //   height: 400,
                            //   width: 400,
                            //   child: Image.network(
                            //     photourl,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            // SizedBox(
                            //   height: 400,
                            //   width: 400,
                            //   child: Videoplayer(url: videourl.toString()),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: _formKey,
                                child: SizedBox(
                                  height: 150,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        label: const Text(
                                            'Write a Solution {In the given Problem Language}'),
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
                            const Text('If Required add image'),
                            ElevatedButton(
                                onPressed: () async {
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

                                    solutionImage = await refrenceImageToUpload
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
                                  'Add Image With Gallery',
                                  style: textsty,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
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
                                  'Submit Solution',
                                  style: textsty,
                                ))
                          ],
                        ),
                      )),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
