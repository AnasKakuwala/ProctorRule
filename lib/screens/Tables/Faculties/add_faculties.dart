import 'dart:core';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFaculties extends StatefulWidget {
  const AddFaculties({Key? key}) : super(key: key);

  @override
  State<AddFaculties> createState() => _AddFacultiesState();
}

class _AddFacultiesState extends State<AddFaculties> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _AddFacultiesState(){
    // _selectVal=_instituteList[0];
  }
  // final _instituteList=["IIICT","IDS","IAS","IITE"];
  String? _selectVal="0";

  late String Fname;
  late String email;
  late String contact;
  late String subjectcode;
  late String institute;

  final TextEditingController F_NAMEController = TextEditingController();
  final TextEditingController F_EMAILController = TextEditingController();
  final TextEditingController F_CONTACTController = TextEditingController();
  final TextEditingController F_SUBJECTController = TextEditingController();
  final FocusNode focusNode=FocusNode();


  Future<int> getNumberOfDocuments() async {
    String mid = "";
    String mid1 = "";
    int? temp;
    List<int> list = [];
    List<int> list2 = [];
    List<int> mis = [];
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection('Faculties');
    final QuerySnapshot querySnapshot = await collectionRef.get();
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      final String documentId = documentSnapshot.id;
      mid = documentSnapshot.id.toString();
      mid1 = mid.substring(0,2);
      temp = int.parse(mid1);
      list.add(temp);
    }
    for(int i = 1;i <= querySnapshot.docs.length; i++){
      list2.add(i);
    }
    for (int i = 1; i < list.length; i++) {
      if (!list.contains(list2[i])) {
        print(list2[i]);
        mis.add(list2[i]);
      }
    }
    if(mis.isNotEmpty){
      int t = mis[0];
      list.clear();
      list2.clear();
      mis.clear();
      return t;
    }
    else{
      int last = list.last;
      print(last);
      return last + 1;
    }
  }

  String idGenerator(int n,String sname){
    String temp;
    String mainname = sname.replaceAll(" ", "_");
    if(n > 9){
      temp = '${n}_$mainname';
    }
    else{
      temp = '0${n}_$mainname';
    }
    print(temp);
    return temp;
  }


  Future<void> addDocument(String id,String Fname, String email, String contactno,String subjeccode,String Iname) async {
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection('Faculties');
    final DocumentReference documentRef = collectionRef.doc(id);

    await documentRef.set({
      'Fname': Fname,
      'I_SH_NAME': Iname,
      'FEmailID' : email,
      'FContactNo' : contactno,
      'subject_code' : subjeccode
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Add Faculty"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              getMyField(hintText: "Faculty Name" , controller: F_NAMEController),
              getMyField(hintText: "Email-Id", controller: F_EMAILController,textInputType: TextInputType.emailAddress),
              getMyField(hintText: "Contact Number", controller: F_CONTACTController,textInputType: TextInputType.number),
              getMyField(hintText: "Subject Code", controller: F_SUBJECTController),

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
                        value: _selectVal,
                        items: instituteItems,
                        // onChanged: (val){
                        //   setState(() {
                        //     _selectVal=val as String;
                        //   });
                        // }
                      onChanged: (instituteValue){
                        setState(() {
                          _selectVal=instituteValue;
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
                        if(F_NAMEController.text != "" && F_EMAILController.text != "" && F_CONTACTController.text != "" && F_SUBJECTController.text != "" && _selectVal != "0"){
                          Fname = F_NAMEController.text.toString();
                          email = F_EMAILController.text.toString();
                          contact = F_CONTACTController.text.toString();
                          subjectcode = F_SUBJECTController.text.toString();
                          institute = _selectVal!;
                          int n;
                          String tid;
                          getNumberOfDocuments().then((int numDocuments) {
                            n = numDocuments;
                            tid = idGenerator(n, Fname);
                            addDocument(tid, Fname, email, contact, subjectcode, institute);
                          }).catchError((error) {
                            print('Error getting number of documents: $error');
                          });
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> const InstituteTable()));
                        Navigator.of(context).pop();

                      },
                      child: Text("Add Faculty"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      focusNode.requestFocus();
                      F_NAMEController.text = "";
                      F_EMAILController.text="";
                      F_CONTACTController.text="";
                      F_SUBJECTController.text="";

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

