import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proctor_rule/screens/login.dart';
import 'package:proctor_rule/screens/scheduleTable.dart';
import 'package:proctor_rule/screens/subjectTable.dart';
// import 'package:proctor_rule/screens/login.dart';
// import '../screens/login.dart';
import '../screens/facultyTable.dart';
import '../screens/classroomTable.dart';
import '../screens/branchTable.dart';
import '../screens/dutiesTable.dart';
import '../screens/institute_table.dart';
import '../screens/scheduleTable.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            leading: BackButton(
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
            backgroundColor: Colors.grey[700],
            title: const Text("ProctorRule",style: TextStyle(color: Colors.white),),
          ),
          const Divider(
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const  Text("Faculties"),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FacultyTable()))
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Classrooms"),
            onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassroomTable()))
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Schedule"),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ScheduleTable()))
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Institutes"),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> InstituteTable()))
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Subjects"),
            onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  SubjectTable()))
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Branches"),
            onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> BranchTable()))
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Duties"),
            onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DutiesTable()))
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text("Logout"),
            onTap: () => {
                _auth.signOut(),
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()))
            }
          )
        ],
      ),
    );
  }
}
