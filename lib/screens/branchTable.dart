import 'package:flutter/material.dart';

class BranchTable extends StatefulWidget {
  const BranchTable({Key? key}) : super(key: key);

  @override
  State<BranchTable> createState() => _BranchTableState();
}

class _BranchTableState extends State<BranchTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Branch")),
      body: Center(child: Text("Branch"),),
    );
  }
}
