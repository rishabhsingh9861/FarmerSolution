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

              final  districtsolve = '${problem['District']}';
               final cropsolve = '${problem['Crop']}';

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => SoluttionDetailed(email: widget.emailid, solnids: solutiongiven[index],)));
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
  }
}
