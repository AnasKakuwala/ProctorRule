import 'package:flutter/material.dart';

class ClassroomGrid extends StatefulWidget {
  @override
  _ClassroomGridState createState() => _ClassroomGridState();
}

class _ClassroomGridState extends State<ClassroomGrid> {
  List<bool> _isSelectedList = List.filled(9, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Select Classrooms",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectedList[index] = !_isSelectedList[index];
                });
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: _isSelectedList[index] ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                  _isSelectedList[index]
                      ? Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  )
                      : SizedBox(),

                ],

              ),
            );
          },
        ),

      ),

    );

  }
}