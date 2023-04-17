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

  final TextEditingController F_NAMEController = TextEditingController();
  final TextEditingController F_EMAILController = TextEditingController();
  final TextEditingController F_CONTACTController = TextEditingController();
  final TextEditingController F_SUBJECTController = TextEditingController();
  final FocusNode focusNode=FocusNode();

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
                                  value: institute.id,
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
                      onPressed: (){},
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

