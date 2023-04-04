import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Widgets/app_drawer.dart';
import '../Widgets/main_body.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("ProctorRule"),
        backgroundColor: Colors.grey[700],
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(2.0),
      //   child: ListView(
      //     children: [
      //       InkWell(
      //         onTap: (){},
      //         child: Card(
      //           shape: BoxBorder.lerp(Border(), Border.all(color: Colors.red,), 2),
      //           child: Container(
      //             height: 50,
      //             child: Row(
      //               children: [
      //                 Container(child: Icon(Icons.schedule,size: 50,),color: Colors.red),
      //                 SizedBox(width: 20,),
      //                 Text('Schedule Exam',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: MainBody(),
    );
  }
}