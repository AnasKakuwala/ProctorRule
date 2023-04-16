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

  Future<void> deleteDocument(String docId) async {
    try {
      await firestore.collection('Institute').doc(docId).delete();
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

  Future<void> _showConfirmationDialog(String id) async {
    await firestore.collection('Institute').doc(id).snapshots();
    void getShName(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      List<DocumentSnapshot> documents = snapshot.data!.docs;

    }
    void showToast(){
        // if (confirmed == true){
          deleteDocument(id);
          Fluttertoast.showToast(
            msg: 'Record Deleted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        // }
      }
    final bool? confirmed = await showDialog<bool>(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to delete ${id} ?'),
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
                showToast();
              },

            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      deleteDocument(id);
      Fluttertoast.showToast(
        msg: 'Record Deleted',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    // void showToast(){
    //   if (confirmed == true){
    //     deleteDocument(id);
    //     Fluttertoast.showToast(
    //       msg: 'Record Deleted',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       fontSize: 16.0,
    //     );
    //   }
    // }

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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditInstitute(id: docId, sName: instituteShortName, fName: instituteFullName)))
                          },
                          icon: Icon(Icons.edit,color: Colors.grey,),
                        ),
                        IconButton(
                          onPressed: () => {
                            _showConfirmationDialog(docId),
                          },
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
