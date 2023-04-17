import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewFaculty extends StatefulWidget {
  const ViewFaculty({super.key,required this.id,required this.I_shortname, required this.Fname, required this.EmailID, required this.ContactNo, required this.Subcode});

  final String id;
  final String Fname;
  final String I_shortname;
  final String EmailID;
  final String ContactNo;
  final String Subcode;

  @override
  State<ViewFaculty> createState() => _ViewFacultyState();
}

class _ViewFacultyState extends State<ViewFaculty> {
  @override
  Widget build(BuildContext context) {
  final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Facluty'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25,),
              SizedBox(height: deviceHeight * 0.30,
                child: const FittedBox(
                  child: CircleAvatar(
                    backgroundColor: Colors.black12,
                    backgroundImage: AssetImage('assets/images/professor.png'),
                    radius: 120,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.65,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Institute').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data == null) {
                      return const Text('No data available');
                    }
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView(
                      children: documents.map((DocumentSnapshot document) {
                        var data = document.data() as Map<String, dynamic>;
                        var instituteShortName = data['I_SH_NAME'];
                        var instituteFullName = data['I_FL_NAME'];
                        String docId = document.id;
                        return Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5,bottom: 2,top: 2),
                          child: ListTile(
                            leading: const CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.school)
                            ),
                            tileColor: Colors.black12,
                            title: Text(instituteShortName ?? ''),
                            subtitle: Text(instituteFullName ?? ''),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
