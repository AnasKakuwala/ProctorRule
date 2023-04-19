import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proctor_rule/screens/Tables/Institute/institute_table.dart';

class AddInstitute extends StatefulWidget {
  const AddInstitute({Key? key}) : super(key: key);

  @override
  State<AddInstitute> createState() => _AddInstituteState();
}

class _AddInstituteState extends State<AddInstitute> {
  final TextEditingController I_SH_NAMEController = TextEditingController();
  final TextEditingController I_FL_NAMEController = TextEditingController();
  final FocusNode focusNode=FocusNode();

  late String sName;
  late String fName;
  void print_a(List<int> a){
    print(a);
  }
  Future<int> getNumberOfDocuments() async {
    String mid = "";
    String mid1 = "";
    int? temp;
    List<int> list = [];
    List<int> list2 = [];
    List<int> mis = [];
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection('Institute');
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
      return last + 1;
    }
  }

  String idGenerator(int n,String sname){
    String temp;
    if(n > 9){
      temp = '${n}_$sname';
    }
    else{
      temp = '0${n}_$sname';
    }
    print(temp);
    return temp;
  }

  Future<void> addDocument(String id,String sName, String fName) async {
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection('Institute');
    final DocumentReference documentRef = collectionRef.doc(id);

    await documentRef.set({
      'I_SH_NAME': sName,
      'I_FL_NAME': fName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.grey[700],
      title: const Text("Add Institute"),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMyField(hintText: 'Institute Short Name',controller: I_SH_NAMEController),
            getMyField(hintText: 'Institute Full Name',controller: I_FL_NAMEController),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                  onPressed: (){
                    if(I_SH_NAMEController.text != "" && I_FL_NAMEController.text != ""){
                      sName = I_SH_NAMEController.text.toString();
                      fName = I_FL_NAMEController.text.toString();
                      int n;
                      String tid;
                      getNumberOfDocuments().then((int numDocuments) {
                        n = numDocuments;
                        tid = idGenerator(n, sName);
                        addDocument(tid, sName, fName);
                      }).catchError((error) {
                        print('Error getting number of documents: $error');
                      });
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> const InstituteTable()));
                    Navigator.of(context).pop();
                  },
                  child: Text('Add Institute'),
                ),
                ElevatedButton(onPressed: (){
                  I_SH_NAMEController.text="";
                  I_FL_NAMEController.text="";
                  focusNode.requestFocus();
                },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
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
