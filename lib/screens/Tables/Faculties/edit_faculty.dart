import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditFaculty extends StatefulWidget {
  const EditFaculty({super.key, required this.id, required this.Fname, required this.email, required this.contact, required this.institute, required this.subjectcode});
  final String id;
  final String Fname;
  final String email;
  final String contact;
  final String institute;
  final String subjectcode;
  @override
  State<EditFaculty> createState() => _EditFacultyState();
}

class _EditFacultyState extends State<EditFaculty> {




  final TextEditingController F_IDController = TextEditingController();
  final TextEditingController F_NAMEController = TextEditingController();
  final TextEditingController F_EMAILController = TextEditingController();
  final TextEditingController F_CONTACTController = TextEditingController();
  final TextEditingController F_SUBJECTController = TextEditingController();
  final FocusNode focusNode=FocusNode();

  Future<void> updateDocument(String documentId, Map<String, dynamic> dataToUpdate) async {
    try {
      await FirebaseFirestore.instance.collection('Faculties').doc(documentId).update(dataToUpdate);
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

    String? _selectVal= widget.institute;

    late String Fname;
    late String email;
    late String contact;
    late String subjectcode;
    late String institute;


    F_IDController.text = widget.id;
    F_NAMEController.text = widget.Fname;
    F_EMAILController.text = widget.email;
    F_CONTACTController.text = widget.contact;
    F_SUBJECTController.text = widget.subjectcode;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Add Faculty"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMyField( hintText: "faculty Id" , controller: F_IDController, read: true),
            getMyField( hintText: "Faculty Name" , controller: F_NAMEController, read: false),
            getMyField( hintText: "Email-Id", controller: F_EMAILController,textInputType: TextInputType.emailAddress, read: false),
            getMyField( hintText: "Contact Number", controller: F_CONTACTController,textInputType: TextInputType.number, read: false),
            getMyField( hintText: "Subject Code", controller: F_SUBJECTController, read: false),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Institute').snapshots(),
                  builder: (context, snapshot) {
                    List<DropdownMenuItem> instituteItems= [];
                    if(!snapshot.hasData){
                      const  CircularProgressIndicator();
                    }
                    else{
                      final institutes=snapshot.data?.docs.reversed.toList();
                      instituteItems.add(
                          DropdownMenuItem(
                            child: Text('Select Institute'),
                            value: "0",
                          )
                      );
                      for(var institute in institutes!){
                        instituteItems.add(
                          DropdownMenuItem(
                            value: institute['I_SH_NAME'],
                            child: Text(institute['I_SH_NAME'],
                            ),
                          ),
                        );
                      }
                    }
                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          // labelText: "Institute",
                          // hintText: "Institute",
                          prefixIcon: Icon(Icons.school_outlined,color: Colors.grey[700],)
                      ),
                      dropdownColor: Colors.grey[200],
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.grey,
                      ),
                      value: widget.institute,
                      items: instituteItems,
                      // onChanged: (val){
                      //   setState(() {
                      //     _selectVal=val as String;
                      //   });
                      // }

                      onChanged: (instituteValue){
                        setState(() {
                          if(_selectVal != "0"){
                            _selectVal=widget.institute;
                          }
                          else{
                            _selectVal = instituteValue;
                          }
                        });
                        print(instituteValue);
                      },
                      isExpanded: false,
                    );
                  }
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    // F_NAMEController
                    // F_EMAILController
                    // F_CONTACTController
                    // F_SUBJECTController
                    if(F_NAMEController.text != "" && F_EMAILController.text != "" && F_CONTACTController.text != "" && F_SUBJECTController.text != "" && _selectVal != ""){
                      Fname = F_NAMEController.text.toString();
                      email = F_EMAILController.text.toString();
                      contact = F_CONTACTController.text.toString();
                      subjectcode = F_SUBJECTController.text.toString();
                      institute = _selectVal!;
                      print('${Fname} ${email} ${contact} ${subjectcode} ${institute}');
                      Map<String,dynamic> dataToUpdate = {'Fname' : Fname,'FEmailID' : email, 'FContactNo' : contact, 'subject_code' : subjectcode,'I_SH_NAME' : institute};
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
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> const InstituteTable()));
                    Navigator.of(context).pop();

                  },
                  child: Text("Update Faculty"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                ),
                ElevatedButton(
                  onPressed: (){
                    focusNode.requestFocus();
                    F_NAMEController.text = "";
                    F_EMAILController.text="";
                    F_CONTACTController.text="";
                    F_SUBJECTController.text="";
                    focusNode.requestFocus();
                  },
                  child: Text("Reset"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getMyField({required bool read, required String hintText,TextInputType textInputType=TextInputType.name,required TextEditingController controller,FocusNode? focusNode}){
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
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
      ),
    );
  }
}
