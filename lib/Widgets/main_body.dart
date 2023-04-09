import 'package:flutter/material.dart';
import 'package:proctor_rule/screens/institute_selection.dart';
import '../screens/mse.dart';

class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {

  List<Widget> buttons = [];
  var checkClick = false;
  String textMsg = "";
  void change(){
    setState(() {
      checkClick = !checkClick;
      // print(buttons.length);
      if(buttons.length < 2){
        textMsg = "Select the exam";
        // print("Button add");
        if(checkClick){
          buttons.add(
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700],
              ),
              child: const Text("ESE"),
              onPressed: () {
                // Navigator.of(context).pushReplacement();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const InstituteSelection()));
              },
            ),
          );
          buttons.add(
            ElevatedButton(
              onPressed: () => {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const MSE())),
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const MSE()))
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
              ),
              child: const Text("MSE"),
            ),
          );
        }
      }
      else{
        // print("Button removed");
        textMsg = "";
        buttons.clear();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/classroom.jpg'),fit: BoxFit.fill)
          ),
        ),
        const SizedBox(height: 10,),
        ListTile(
          shape: const Border(
            top: BorderSide(color: Colors.blue),
            left: BorderSide(color: Colors.blue),
            bottom: BorderSide(color: Colors.blue),
            right: BorderSide(color: Colors.blue),
          ),
          leading: const Icon(Icons.schedule),
          title: const Text("Schedule exam"),
          onTap: () => {
            change(),
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Text(textMsg),
        const SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons
        ),
      ],
    );
  }
}

