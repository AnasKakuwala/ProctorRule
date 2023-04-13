import 'package:flutter/material.dart';

class DutiesTable extends StatefulWidget {
  const DutiesTable({Key? key}) : super(key: key);

  @override
  State<DutiesTable> createState() => _DutiesTableState();
}

class _DutiesTableState extends State<DutiesTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Duties"),
    ),
      body: Center(child: Text("Duties"),),
    );
  }
}
