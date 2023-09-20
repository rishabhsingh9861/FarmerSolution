import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/scientist/solveddetailed.dart';
import 'package:flutter/material.dart';

class ProblemSolved extends StatefulWidget {
  const ProblemSolved({super.key, this.emails});
  final String? emails;

  @override
  State<ProblemSolved> createState() => _ProblemSolvedState();
}

class _ProblemSolvedState extends State<ProblemSolved> {
  List solveProblemids = [];
  String districtsolve = '';
  String cropsolve = '';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ExpertUsers')
          .doc(widget.emails)
          .collection('SolvedProblem')
          .orderBy('Solved Time', descending: true)
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
                solveProblemids.add(probid);

                final problem =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                districtsolve = '${problem['District']}';
                cropsolve = '${problem['Crop']}';
                Timestamp timestamp = problem['date'];
                DateTime dateTime = timestamp.toDate();
                String formattedTime =
                    dateTime.toLocal().toString().split('.').first;
                Timestamp solntime = problem['Solved Time'];
                DateTime solndateTime = solntime.toDate();
                String formattedsoln =
                    solndateTime.toLocal().toString().split('.').first;

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailedSolvedProblem(
                                    solvedids: solveProblemids[index],
                                    email: widget.emails.toString(),
                                  )));
                    },
                    child: Container(
                      height: 92,
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
                                    districtsolve,
                                    style: textst,
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    cropsolve,
                                    style: textst,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(' Problem: $formattedTime'),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(' Solved: $formattedsoln')
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
