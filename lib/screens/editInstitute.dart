import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditInstitute extends StatefulWidget {

  const EditInstitute({super.key, required this.id, required this.sName, required this.fName});

  final String id;
  final String fName;
  final String sName;

  @override
  State<EditInstitute> createState() => _EditInstituteState();
}

class _EditInstituteState extends State<EditInstitute> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController I_IDController = TextEditingController();

  final TextEditingController I_SH_NAMEController = TextEditingController();

  final TextEditingController I_FL_NAMEController = TextEditingController();

  final FocusNode focusNode=FocusNode();

  Future<void> updateDocument(String documentId, Map<String, dynamic> dataToUpdate) async {
    try {
      await FirebaseFirestore.instance.collection('Institute').doc(documentId).update(dataToUpdate);
      // Fluttertoast.showToast(
      //   msg: "Document updated successfully!",
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.CENTER,
      //   backgroundColor: Colors.amber,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
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

    I_IDController.text=widget.id;
    I_SH_NAMEController.text=widget.sName;
    I_FL_NAMEController.text=widget.fName;

    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.grey[700],
      title: const Text("Add Institute"),
    ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getMyField(read: true,hintText: 'Institute ID',controller: I_IDController,focusNode: focusNode,textInputType: TextInputType.none),
            getMyField(read: false,hintText: 'Institute Short Name',controller: I_SH_NAMEController),
            getMyField(read: false,hintText: 'Institute Full Name',controller: I_FL_NAMEController),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                  onPressed: () {
                    String sh = I_SH_NAMEController.text;
                    String fl = I_FL_NAMEController.text;
                    Map<String,dynamic> dataToUpdate = {'I_SH_NAME' : sh,'I_FL_NAME': fl};
                    updateDocument(widget.id, dataToUpdate);
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
                  child: const Text('Update Institute'),
                ),
                ElevatedButton(
                  onPressed: (){
                  I_IDController.text="";
                  I_SH_NAMEController.text="";
                  I_FL_NAMEController.text="";
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
