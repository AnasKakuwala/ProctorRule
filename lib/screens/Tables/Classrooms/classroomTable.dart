import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proctor_rule/screens/Tables/Classrooms/add_classroom.dart';
import 'package:proctor_rule/screens/Tables/Classrooms/editClassroom.dart';

class ClassroomTable extends StatefulWidget {
  const ClassroomTable({Key? key}) : super(key: key);

  @override
  State<ClassroomTable> createState() => _ClassroomTableState();
}

class _ClassroomTableState extends State<ClassroomTable> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> deleteDocument(String docId) async {
    try {
      await firestore.collection('Classrooms').doc(docId).delete();
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
    await firestore.collection('Classrooms').doc(id).snapshots();
    void getShName(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      List<DocumentSnapshot> documents = snapshot.data!.docs;

    }
    void showToast(){
      // if (confirmed == true){
      deleteDocument(id);
      Fluttertoast.showToast(
        msg: '${id} Deleted',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Classrooms"),
        backgroundColor: Colors.grey[700],
        actions: [
          IconButton(
              onPressed: () =>
              {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const AddClassroom()))
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Classrooms').snapshots(),
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
                var classroomId = data['C_ID'];
                var classroomCapacity = data['classCapacity'];
                var classroomLocation = data['classLocation'];
                String docId = document.id;
                return Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 2,top: 2),
                  child: ListTile(
                      leading: const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.room_outlined)
                      ),
                      tileColor: Colors.black12,
                      title: Text(classroomId ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Classroom Capacity : "+classroomCapacity ?? ''),
                          Text("Classroom Location : "+classroomLocation ?? '',style: TextStyle(fontSize: 12),),
                        ],
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditClassroom(cId: classroomId, cCapacity: classroomCapacity, cLocation: classroomLocation)))
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
