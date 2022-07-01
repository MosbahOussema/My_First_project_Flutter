import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String firstButtonText = 'Prendre une photo';
  double textSize = 20;
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                child: SizedBox.expand(
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: _takePhoto,
                    child: Text(firstButtonText,
                        style:
                            TextStyle(fontSize: textSize, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _takePhoto() async {
    ImagePicker imagePicker = ImagePicker();
    pickedImage =
        (await imagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          firstButtonText = 'Sauvegarde en cours...';
        });
        GallerySaver.saveImage(value.path).then((value) {
          setState(() {
            firstButtonText = 'Image enregistrée!';
          });
        });
      }
    }));
  }
}
