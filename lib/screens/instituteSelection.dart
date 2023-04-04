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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Institute Selection"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
