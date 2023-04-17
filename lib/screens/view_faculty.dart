import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> deleteDocument(String docId) async {
    try {
      await firestore.collection('Faculties').doc(docId).delete();
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
    // if (confirmed == true) {
    //   deleteDocument(id);
    //   Fluttertoast.showToast(
    //     msg: 'Record Deleted',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //     fontSize: 16.0,
    //   );
    // }
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
// final FirebaseFirestore firestore = FirebaseFirestore.instance;
// DocumentReference docRef = firestore.collection('Faculties').doc(widget.id);
// final DocumentSnapshot docSnapshot = docRef.get() as DocumentSnapshot<Object?>;
//     var data = docSnapshot.data() as Map<String, dynamic>;
  final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
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
                child: ListView(
                  children: [
                    ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Divider(),
                                  Text('Name:'),
                                  Divider(),
                                  Text('Institute name'),
                                  Divider(),
                                  Text('Contact No'),
                                  Divider(),
                                  Text('Email ID'),
                                  Divider(),
                                  Text('subject code'),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Text(widget.Fname),
                                  Divider(),
                                  Text(widget.I_shortname),
                                  Divider(),
                                  Text(widget.ContactNo),
                                  Divider(),
                                  Text(widget.EmailID),
                                  Divider(),
                                  Text(widget.Subcode),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: () => {}, child: Text('Update'),style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),),
                              const SizedBox(width: 90,),
                              ElevatedButton(onPressed: () => { _showConfirmationDialog(widget.id)}, child: Text('Delete'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
