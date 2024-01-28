// ignore_for_file: prefer_const_constructors
import 'dart:io';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import "package:flutter/material.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedFile;
  String scannedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'TEXTRACT',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 20, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pickedFile != null
                ? Image.file(File(_pickedFile!.path))
                : Text(
                    'Aucune image sélectionnée',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Colors.white),
                  ),
            Text(
                scannedText,
                style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Colors.white),
              ),
           
            _pickedFile != null
                ? TextButton(
                onPressed: () {
                  getText(_pickedFile);
                  setState(() {
                    
                  });
                },
                child: Text('Scan',
                style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white),)
                )
                :Text(
                    '',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Colors.white),
                  ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            color: Colors.white,
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            color: Colors.white,
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedFile = await _imagePicker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void getText(XFile? image) async {
    final inputImage = InputImage.fromFilePath(image!.path);
    final TextRecognizer textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText text = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = '';
    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
      }
    }
    setState(() {});
  }
   
    
}
