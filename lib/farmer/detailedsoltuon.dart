import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/farmer/final_display.dart';
import 'package:flutter/material.dart';

class SoluttionDetailed extends StatefulWidget {
  const SoluttionDetailed({super.key, this.email, this.solnids});
  final String? email;
  final String? solnids;

  @override
  State<SoluttionDetailed> createState() => _SoluttionDetailedState();
}

class _SoluttionDetailedState extends State<SoluttionDetailed> {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.email)
            .collection('Solution')
            .doc(widget.solnids)
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
            return Center(
              child: Text('Document does not exist.'),
            );
          } else {
            final problemData = snapshot.data!.data() as Map<String, dynamic>;
            final name = problemData['Name'] as String;
            final crop = problemData['Crop'] as String;
            final district = problemData['District'] as String;
            final state = problemData['State'] as String;
            final taluka = problemData['Taluka'] as String;
            final village = problemData['Village'] as String;
            final pincode = problemData['Pincode'] as int;
            final photourl = problemData['Photo Url'] as String;
            final videourl = problemData['Video Url'] as String;
            final solu = problemData['Solution'] as String;
            final solnimg = problemData['Solution Image'] as String;
            Timestamp timestamp = problemData['date'];
            DateTime dateTime = timestamp.toDate();
            String formattedTime =
                dateTime.toLocal().toString().split('.').first;
            Timestamp solntime = problemData['Solved Time'];
            DateTime solndateTime = solntime.toDate();
            String formattedsoln =
                solndateTime.toLocal().toString().split('.').first;

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
                                    'Date: $formattedTime',
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
                              child: defaultimage(photourl)),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Date: $formattedsoln',
                            style: textsty,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            ' $solu',
                            style: textsty,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 400,
                            width: 400,
                            child: defaultimage(solnimg),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          }
        });
  }
}
