import 'package:flutter/material.dart';
import '../providers/InstitueModel.dart';

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

        title: Text("Institute Selection"),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(itemCount: institutes.length,itemBuilder: (BuildContext context,int index){
                    //return item
                    return InstituteItem(institutes[index].IName, institutes[index].isSelected, index);
                  },
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
                  child: SizedBox(width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.grey[700]),
                      onPressed: (){},
                      child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget InstituteItem(String IName,bool isSelected,int index){
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[700],
          child: Icon(Icons.school_outlined,color: Colors.white,),
        ),
      title: Text(IName,style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: isSelected ?
            Icon(Icons.check_circle,color: Colors.grey,)
          : Icon(Icons.check_circle_outline,color: Colors.grey[700],),
      onTap: (){
          setState(() {
            institutes[index].isSelected = !institutes[index].isSelected;
            
            if(institutes[index].isSelected == true){
              selectedInstitute.add(InstituteModel(IName, true));
            }
            else if(institutes[index].isSelected==false){
              selectedInstitute.removeWhere((element) => element.IName == institutes[index].IName);
            }
              
          });
      },
    );
  }
}
