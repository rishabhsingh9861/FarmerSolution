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
                      height: 60,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
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
    ;
  }
}
