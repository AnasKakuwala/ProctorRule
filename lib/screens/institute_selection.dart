import 'package:flutter/material.dart';
import 'package:proctor_rule/Widgets/app_drawer.dart';
import 'package:proctor_rule/screens/uploadTSScreen.dart';
// import 'package:proctor_rule/Widgets/main_body.dart';
import '../providers/Institute_model.dart';

class InstituteSelection extends StatefulWidget {
  const InstituteSelection({Key? key}) : super(key: key);

  @override
  State<InstituteSelection> createState() => _InstituteSelectionState();
}

class _InstituteSelectionState extends State<InstituteSelection> {

  List<InstituteModel> institutes=[
    InstituteModel("IITE - Indus Institute of Technology & Engineering",false),
    InstituteModel("IAS - Indus Architecture School",false),
    InstituteModel("IDS - Indus Design School",false),
    InstituteModel("IIICT - Indus Institute of Information & Communication Technology",false),
    InstituteModel("IIMS - Indus Institute of Management Studies",false),
    InstituteModel("IISHLS - Indus Institute of Sciences Humanities & Liberal Studies",false),
    InstituteModel("IISS - Indus Institute of Special Studies",false),
    InstituteModel("IIL - Indus Institute of Law",false),
    InstituteModel("IIPR - Indus Institute of Pharmacy and Research",false),
    InstituteModel("IIATE - Indus Institute of Aviation Technology and Engineering",false),
  ];

  List<InstituteModel> selectedInstitute = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed:() {
            Navigator.pop(context);
          },
        ),
        title: const Text("Institute Selection",style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
      ),
      drawer: AppDrawer(),  
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(itemCount: institutes.length,itemBuilder: (BuildContext context,int index){
                  //return item
                  return instituteItem(institutes[index].IName, institutes[index].isSelected, index);
                },
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
                child: SizedBox(width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                    onPressed: ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const UploadTS()))
                    },
                    child: const Text("Next",style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget instituteItem(String iName,bool isSelected,int index){
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[700],
          child: const Icon(Icons.school_outlined,color: Colors.white,),
        ),
      title: Text(iName,style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: isSelected ?
            const Icon(Icons.check_circle,color: Colors.grey,)
          : Icon(Icons.check_circle_outline,color: Colors.grey[700],),
      onTap: (){
          setState(() {
            institutes[index].isSelected = !institutes[index].isSelected;
            
            if(institutes[index].isSelected == true){
              selectedInstitute.add(InstituteModel(iName, true));
            }
            else if(institutes[index].isSelected==false){
              selectedInstitute.removeWhere((element) => element.IName == institutes[index].IName);
            }
              
          });
      },
    );
  }
}
