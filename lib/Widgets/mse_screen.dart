import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../providers/Institute_model.dart';
import '../screens/classroom_selection.dart';

class MseWid extends StatefulWidget {
  const MseWid({Key? key}) : super(key: key);

  @override
  State<MseWid> createState() => _MseWidState();
}

class _MseWidState extends State<MseWid> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      uploadTask = null;
    });
  }

  String? setValue;
  List<String> institute=[
    "IITE - Indus Institute of Technology & Engineering",
    "IAS - Indus Architecture School",
    "IDS - Indus Design School",
    "IIICT - Indus Institute of Information & Communication Technology",
    "IIMS - Indus Institute of Management Studies",
    "IISHLS - Indus Institute of Sciences Humanities & Liberal Studies",
    "IISS - Indus Institute of Special Studies",
    "IIL - Indus Institute of Law",
    "IIPR - Indus Institute of Pharmacy and Research",
    "IIATE - Indus Institute of Aviation Technology and Engineering",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text("Select Institute",
            style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.only(left: 16.0,right: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down_circle_rounded,size: 30,),
                  isExpanded: true,
                  hint: Text("Select Institute",style: TextStyle(fontSize: 20.0),),
                  value: setValue,
                  onChanged:(newValue){
                    setState(() {
                      setValue = newValue;
                    });
                  },
                  items: institute.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        selectFile(),
                      },
                      child: Text("Select Time Table",style: TextStyle(color: Colors.white),),
                      // style: ButtonStyle(
                      //     minimumSize: MaterialStateProperty.all(Size(20.0, 50.0))
                      // ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          minimumSize: Size(20, 50)
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        uploadFile(),
                      },
                      child: Text("Upload Time Table",style: TextStyle(color: Colors.white),),
                      // style: ButtonStyle(
                      //   minimumSize: MaterialStateProperty.all(Size(20.0, 50.0))
                      // ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          minimumSize: Size(20, 50)
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        selectFile(),
                      },
                      child: Text("Select Student List",style: TextStyle(color: Colors.white),),
                      // style: ButtonStyle(
                      //     minimumSize: MaterialStateProperty.all(Size(20.0, 50.0))
                      // ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                          minimumSize: Size(20, 50)
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      onPressed: () => {
                        uploadFile(),
                      },
                      child: Text("Upload Student List",style: TextStyle(color: Colors.white),),
                      // style: ButtonStyle(
                      //   minimumSize: MaterialStateProperty.all(Size(20.0, 50.0))
                      // ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          minimumSize: Size(20, 50)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // if(pickedFile != null)
          //   Row(
          //       children: [
          //         Center(
          //           child: Container(
          //             margin: EdgeInsets.all(10),
          //             height: 120,
          //             width: 120,
          //             color: Colors.grey,
          //             child: Image(
          //               image: FileImage(File(pickedFile!.path!)),
          //               // File(pickedFile!.path!),
          //               width: double.infinity,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       ],
          //   ),
          SizedBox(height: 150,),
          buildProgress(),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsScreen()))
                },
                child: Text("Select Classrooms ",style: TextStyle(color: Colors.white,fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream : uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }else{
          return const SizedBox(height: 50,);
        }
      });
}

