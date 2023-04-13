import 'package:flutter/material.dart';

class ClassroomTable extends StatefulWidget {
  const ClassroomTable({Key? key}) : super(key: key);

  @override
  State<ClassroomTable> createState() => _ClassroomTableState();
}

class _ClassroomTableState extends State<ClassroomTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Classroom"),),
      body: Center(child: Text("Classroom"),),
    );
  }
}
