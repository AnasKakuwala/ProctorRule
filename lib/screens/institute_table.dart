import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proctor_rule/screens/addInstitute.dart';
import 'package:proctor_rule/screens/editInstitute.dart';

// QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('your_collection').where('field_name', isEqualTo: 'field_value').get();

class InstituteTable extends StatefulWidget {
  const InstituteTable({Key? key}) : super(key: key);

  @override
  State<InstituteTable> createState() => _InstituteTableState();
}

class _InstituteTableState extends State<InstituteTable> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _showConfirmationDialog() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to perform this action?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      Future<void> deleteDocument(String docId) async {
        try {
          await firestore.collection('Institute').doc(docId).delete();
          Fluttertoast.showToast(
            msg: 'Record Deleted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } catch (e) {
          Fluttertoast.showToast(
            msg: 'Error occurred',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Institutes"),
        actions: [
          IconButton(
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddInstitute()))
              },
              icon: Icon(Icons.add))
        ],
      ),

      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Institute').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
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
                var institueShortName = data['I_SH_NAME'] as String?;
                var instituteFullName = data['I_FL_NAME'] as String?;
                String docId = document.id;
                return Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 2,top: 2),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 20,
                        child: Icon(Icons.school)
                    ),
                    tileColor: Colors.black12,
                    title: Text(institueShortName ?? ''),
                    subtitle: Text(instituteFullName ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditInstitute(institute: )))
                          },
                          icon: Icon(Icons.edit,color: Colors.grey,),
                        ),
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.delete,color: Colors.red,),
                        ),

                      ],
                    )
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
