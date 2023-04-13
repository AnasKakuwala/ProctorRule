import 'package:flutter/material.dart';

class ScheduleTable extends StatefulWidget {
  const ScheduleTable({Key? key}) : super(key: key);

  @override
  State<ScheduleTable> createState() => _ScheduleTableState();
}

class _ScheduleTableState extends State<ScheduleTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schedule"),),
      body: Center(child: Text("Schedule"),),
    );
  }
}
