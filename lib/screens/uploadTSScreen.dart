// import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadTS extends StatefulWidget {
  const UploadTS({Key? key}) : super(key: key);

  @override
  State<UploadTS> createState() => _UploadTSState();
}

class _UploadTSState extends State<UploadTS> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
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
            if(pickedFile != null)
              Row(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      color: Colors.grey,
                      child: Image(
                        image: FileImage(File(pickedFile!.path!)),
// File(pickedFile!.path!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

            SizedBox(height: 150,),
            buildProgress(),
            SizedBox(height: 150,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                  onPressed: ()=>{
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> const UploadTS()))
                  },
                  child: const Text("Select Classroom",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ),
            ),
          ],
        ),
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

