import 'package:flutter/material.dart';
import 'package:proctor_rule/Widgets/classroom_grid.dart';

class ClassroomsScreen extends StatefulWidget {
  const ClassroomsScreen({Key? key}) : super(key: key);

  @override
  State<ClassroomsScreen> createState() => _ClassroomsScreenState();
}

class _ClassroomsScreenState extends State<ClassroomsScreen> {
  @override
  Widget build(BuildContext context) {
    return ClassroomGrid();
  }
}
