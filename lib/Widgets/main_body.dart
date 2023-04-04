import 'package:flutter/material.dart';

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
      print(buttons.length);
      if(buttons.length < 2){
        textMsg = "Select the exam";
        print("Button add");
        if(checkClick){
          buttons.add(
            ElevatedButton(child: Text("ESE"),onPressed: () => {},),
          );
          buttons.add(
            ElevatedButton(child: Text("MSE"),onPressed: () => {},),
          );
        }
      }
      else{
        print("Button removed");
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
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/classroom.jpg'),fit: BoxFit.fill)
          ),
        ),
        SizedBox(height: 10,),
        ListTile(
          shape: Border(
            top: BorderSide(color: Colors.blue),
            left: BorderSide(color: Colors.blue),
            bottom: BorderSide(color: Colors.blue),
            right: BorderSide(color: Colors.blue),
          ),
          leading: Icon(Icons.schedule),
          title: Text("Schedule exam"),
          onTap: () => {
            change(),
          },
        ),
        SizedBox(
          height: 20,
        ),
        Text(textMsg),
        SizedBox(
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

