import 'package:flutter/material.dart';
import 'package:proctor_rule/providers/Institute_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/InstituteAdd_Model.dart';

class EditInstitute extends StatefulWidget {

  EditInstitute({super.key, required this.id});
  final String id;

  @override
  State<EditInstitute> createState() => _EditInstituteState();
}

class _EditInstituteState extends State<EditInstitute> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? sName;
  String? fName;

  // final Institute institute;
void setData() async {
  await firestore.collection('Institute').doc(widget.id).snapshots();

}

  final TextEditingController I_IDController = TextEditingController();

  final TextEditingController I_SH_NAMEController = TextEditingController();

  final TextEditingController I_FL_NAMEController = TextEditingController();

  final FocusNode focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {

    I_IDController.text='${widget.id}';
    I_SH_NAMEController.text='${sName}';
    I_FL_NAMEController.text='${fName}';

    return Scaffold(appBar: AppBar(
      title: Text("Add Institute"),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              getMyField(hintText: 'Institute ID',controller: I_IDController,focusNode: focusNode),
            getMyField(hintText: 'Institute Short Name',controller: I_SH_NAMEController),
            getMyField(hintText: 'Institute Full Name',controller: I_FL_NAMEController),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){},
                  child: Text('Update Institute'),
                ),
                ElevatedButton(onPressed: (){
                  I_IDController.text="";
                  I_SH_NAMEController.text="";
                  I_FL_NAMEController.text="";
                  focusNode.requestFocus();
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getMyField({required String hintText,TextInputType textInputType=TextInputType.name,required TextEditingController controller,FocusNode? focusNode}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: 'Enter $hintText',
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
      ),
    );
  }
}
