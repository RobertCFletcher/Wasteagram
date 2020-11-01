import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'new_post_screen.dart';

class CameraScreen extends StatefulWidget{
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  File image;
  String imageURL;

  void getImage() async{
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference = 
      FirebaseStorage.instance.ref().child(DateTime.now().toString());
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    imageURL = await storageReference.getDownloadURL();
    Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => NewPost(imageURL: imageURL),
    ));
  }

  @override
  Widget build(BuildContext context) {
      return Center(
        child: RaisedButton(
          child: Text('Select Photo'),
          onPressed: () {
            getImage();
          },
        ),
      );
  }
}