import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proctor_rule/screens/add_faculties.dart';
import 'package:proctor_rule/screens/view_faculty.dart';

// import 'edit_faculty.dart';

class FacultyTable extends StatefulWidget {
  const FacultyTable({Key? key}) : super(key: key);

  @override
  State<FacultyTable> createState() => _FacultyTableState();
}

class _FacultyTableState extends State<FacultyTable> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text("Faculties"),
        actions: [
          IconButton(
              onPressed: () =>
              {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const AddFaculties()))
              },
              icon: const Icon(Icons.add))
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Faculties')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
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
          //document.map(() {})
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView(
            children: documents.map((DocumentSnapshot document) {
              var data = document.data() as Map<String, dynamic>;
              var facultyName = data['Fname'];
              var instituteShortName = data['I_SH_NAME'];
              var emailId = data['FEmailID'];
              var contactNo = data['FContactNo'];
              var subjectCode = data['subject_code'];
              String docId = document.id;
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(facultyName),
                subtitle: Text(instituteShortName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFaculty(id: docId,I_shortname: instituteShortName, Fname: facultyName, EmailID: emailId, ContactNo: contactNo, Subcode: subjectCode,)))
                      },
                      icon: const Icon(Icons.arrow_right, color: Colors.grey,),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}