import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? image;
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    var selected = await _picker.pickImage(source: source,
        imageQuality: 100);
    if (selected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No image selected")));
    }
    setState(() {
      image = File(selected!.path);
    });
    print(selected!.path);
  }

  Reference storage = FirebaseStorage.instance.ref();
  Future<void> saveImage() async {
    if(image == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select image"))
      );
      return;
    }
    String filename = DateTime.now()
        .millisecondsSinceEpoch.toString()
        +  "image.jpg";
    final photo = await storage.child("products").child(filename)
      .putFile(image!);
    final url = await photo.ref.getDownloadURL();
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Screen"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            _pickImage(ImageSource.camera);
          }, child: Icon(Icons.camera)),
          ElevatedButton(onPressed: () {
            _pickImage(ImageSource.gallery);
          }, child: Icon(Icons.photo)),
          image == null ? Text("Select Image") :
              Image.file(image!, height: 300,),

          ElevatedButton(onPressed: (){
            saveImage();
          }, child: Text("Save"))

        ],
      ),
    );
  }
}
