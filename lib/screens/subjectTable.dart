import 'package:flutter/material.dart';

class SubjectTable extends StatefulWidget {
  const SubjectTable({Key? key}) : super(key: key);

  @override
  State<SubjectTable> createState() => _SubjectTableState();
}

class _SubjectTableState extends State<SubjectTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Subject"),
    ),
      body: Center(child: Text("Subject"),),
    );
  }
}
