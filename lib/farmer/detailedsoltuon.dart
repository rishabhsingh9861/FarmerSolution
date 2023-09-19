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
                            height: 350,
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 400,
                            width: 400,
                            child: Image.network(
                              photourl,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 400,
                            width: 400,
                            child: Videoplayer(url: videourl.toString()),
                          ),
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
                            ' $solu',
                            style: textsty,
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
