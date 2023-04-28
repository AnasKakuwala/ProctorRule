import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditClassroom extends StatefulWidget {
  const EditClassroom({Key? key,required this.cId,required this.cCapacity,required this.cLocation}) : super(key: key);
  final String cId;
  final String cCapacity;
  final String cLocation;
  @override
  State<EditClassroom> createState() => _EditClassroomState();
}

class _EditClassroomState extends State<EditClassroom> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController C_IDController = TextEditingController();

  final TextEditingController classCapacityController = TextEditingController();

  final TextEditingController classLocationController = TextEditingController();

  final FocusNode focusNode=FocusNode();

  Future<void> updateDocument(String documentId, Map<String, dynamic> dataToUpdate) async {
    try {
      await FirebaseFirestore.instance.collection('Classrooms').doc(documentId).update(dataToUpdate);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error updating document: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    C_IDController.text=widget.cId;
    classCapacityController.text=widget.cCapacity;
    classLocationController.text=widget.cLocation;

    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.grey[700],
      title: const Text("Edit Classroom"),
    ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getMyField(read: true,hintText: 'Classroom ID',controller: C_IDController,focusNode: focusNode,textInputType: TextInputType.none),
            getMyField(read: false,hintText: 'Classroom Capacity',controller: classCapacityController,textInputType: TextInputType.number),
            getMyField(read: false,hintText: 'Classroom Location',controller: classLocationController),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                  onPressed: () {
                    String cid = C_IDController.text;
                    String ccap = classCapacityController.text;
                    String cloc = classLocationController.text;
                    Map<String,dynamic> dataToUpdate = {'CID' : cid,'classCapacity': ccap,'classLocation': cloc};
                    updateDocument(widget.cId, dataToUpdate);
                    Fluttertoast.showToast(
                      msg: "Data Updated Successfully!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Update Classroom'),
                ),
                ElevatedButton(
                  onPressed: (){
                    C_IDController.text="";
                    classCapacityController.text="";
                    classLocationController.text="";
                    focusNode.requestFocus();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget getMyField({required bool read,required String hintText,TextInputType textInputType=TextInputType.name,required TextEditingController controller,FocusNode? focusNode}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        readOnly: read,
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: 'Enter $hintText',
          labelText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
      ),
    );
  }
}
