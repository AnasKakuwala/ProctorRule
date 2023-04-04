import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Widgets/app_drawer.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("ProctorRule"),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(5.0),
      //   child: ListView(
      //     children: [
      //       ListTile(
      //
      //         // shape: BoxBorder.lerp(Border(), Border.all(color: Colors.black), 2),
      //         shape: Border.all(color: Colors.black,style: BorderStyle.solid,),
      //         leading: Icon(Icons.schedule,color: Colors.red),
      //         title: Text("Schedule Exam"),
      //
      //         onTap: (){},
      //       ),
      //     ],
      //   ),
      // ),
      // body: Padding(
      //     padding: EdgeInsets.all(8),
      //     child: ListTile(
      //       shape: Border.lerp(Border(),Border.all(), 2),
      //       leading: Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           Container(
      //             height: double.infinity,
      //             width: 50,
      //             decoration: BoxDecoration(color: Colors.red),
      //             child:Icon(Icons.schedule)
      //           ),
      //         ],
      //       ),
      //       title: Text("Schedule Exam",style: TextStyle(fontSize: 20),),
      //       onTap: (){},
      //     ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListView(
          children: [
            InkWell(
              onTap: (){},
              child: Card(
                shape: BoxBorder.lerp(Border(), Border.all(color: Colors.red,), 2),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Container(child: Icon(Icons.schedule,size: 50,),color: Colors.red),
                      SizedBox(width: 20,),
                      Text('Schedule Exam',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}