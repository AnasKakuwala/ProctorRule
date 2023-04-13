import 'package:flutter/material.dart';

class InstituteTable extends StatefulWidget {
  const InstituteTable({Key? key}) : super(key: key);

  @override
  State<InstituteTable> createState() => _InstituteTableState();
}

class _InstituteTableState extends State<InstituteTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Institute"),),
      body: Center(child: Text("Institute"),),
    );
  }
}
