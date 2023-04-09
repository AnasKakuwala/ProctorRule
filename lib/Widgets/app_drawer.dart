import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:proctor_rule/screens/login.dart';
// import '../screens/login.dart';

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
            title: const Text("ProctorRule"),
          ),
          const Divider(
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const  Text("Faculties"),
            onTap: () => {}
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Classrooms"),
            onTap: () => {}
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Schedule"),
            onTap: () => {}
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Institutes"),
            onTap: () => {}
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Subjects"),
            onTap: () => {}
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Branches"),
            onTap: () => {}
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Duties"),
            onTap: () => {}
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text("Logout"),
            onTap: () => {
                _auth.signOut()
            }
          )
        ],
      ),
    );
  }
}
