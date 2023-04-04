import 'package:flutter/material.dart';
// import 'package:proctor_rule/screens/login.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Drawer"),
          ),
          const Divider(
          ),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text("Faculties"),
            onTap: () => {}
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text("Classrooms"),
            onTap: () => {}
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text("Schedule"),
            onTap: () => {}
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text("Institutes"),
            onTap: () => {}
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text("Subjects"),
            onTap: () => {}
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text("Branches"),
            onTap: () => {}
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text("Duties"),
            onTap: () => {}
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: Text("Logout"),
            onTap: () => {}
          )
        ],
      ),
    );
  }
}
