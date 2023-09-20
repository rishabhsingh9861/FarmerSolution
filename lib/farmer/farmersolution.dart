import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:farmer_solution/farmer/detailedsoltuon.dart';
import 'package:flutter/material.dart';

class FarmerSolution extends StatefulWidget {
  const FarmerSolution({super.key, this.emailid});
  final String? emailid;

  @override
  State<FarmerSolution> createState() => _FarmerSolutionState();
}

class _FarmerSolutionState extends State<FarmerSolution> {
  List<String> solutiongiven = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.emailid)
          .collection('Solution')
          .orderBy('date', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: appbar,
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String solutionids = snapshot.data!.docs[index].id;
                solutiongiven.add(solutionids);

                final problem =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                final districtsolve = '${problem['District']}';
                final cropsolve = '${problem['Crop']}';
                Timestamp timestamp = problem['date'];
                DateTime dateTime = timestamp.toDate();
                String formattedTime =
                    dateTime.toLocal().toString().split('.').first;

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SoluttionDetailed(
                                    email: widget.emailid,
                                    solnids: solutiongiven[index],
                                  )));
                    },
                    child: Container(
                      height: 80,
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
                            Text('  $formattedTime')
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
