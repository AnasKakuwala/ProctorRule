import 'package:flutter/material.dart';

class FacultyTable extends StatefulWidget {
  const FacultyTable({Key? key}) : super(key: key);

  @override
  State<FacultyTable> createState() => _FacultyTableState();
}

class _FacultyTableState extends State<FacultyTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Faculty"),),
      body: Center(child: Text("Faculty"),),
    );
  }
}
