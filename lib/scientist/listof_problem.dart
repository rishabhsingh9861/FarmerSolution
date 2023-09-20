// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/scientist/detailed_problem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfProblem extends StatefulWidget {
  const ListOfProblem({super.key, this.state, this.emails});
  final String? state;
  final String? emails;

  @override
  State<ListOfProblem> createState() => _ListOfProblemState();
}

class _ListOfProblemState extends State<ListOfProblem> {
  String cropprob = '';
  String districtprob = '';

  List<String> problemids = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.state.toString())
          .orderBy('Time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: appbar,
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String probid = snapshot.data!.docs[index].id;
                problemids.add(probid);
                final problem =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                districtprob = '${problem['District']}';
                cropprob = '${problem['Crop']}';
                Timestamp timestamp = problem['Time'];
                DateTime dateTime = timestamp.toDate();
                String formattedTime =
                    '${dateTime.toLocal().toString().split('.').first}';

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailedProblem(
                                    problemid: problemids[index],
                                    state: widget.state,
                                    email: widget.emails.toString(),
                                  )));
                    },
                    child: Container(
                      height: 70,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    districtprob,
                                    style: textst,
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    cropprob,
                                    style: textst,
                                  ),
                                ),
                              ],
                            ),
                            Text('  Problem date: $formattedTime')
                          ],
                        ),
                      ),
                    ),
                  ),
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
