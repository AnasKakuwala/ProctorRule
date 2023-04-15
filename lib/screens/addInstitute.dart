import 'package:flutter/material.dart';

class AddInstitute extends StatefulWidget {
  const AddInstitute({Key? key}) : super(key: key);

  @override
  State<AddInstitute> createState() => _AddInstituteState();
}

class _AddInstituteState extends State<AddInstitute> {
  final TextEditingController I_IDController = TextEditingController();
  final TextEditingController I_SH_NAMEController = TextEditingController();
  final TextEditingController I_FL_NAMEController = TextEditingController();
  final FocusNode focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
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
                  child: Text('Add Institute'),
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
