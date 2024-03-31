import 'package:photo_filter_app/App/dialogbox.dart';
import 'package:photo_filter_app/shapes/circle.dart';
import 'package:photo_filter_app/shapes/heart.dart';
import 'package:photo_filter_app/shapes/round_rect.dart';
import 'package:photo_filter_app/shapes/square.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;
  XFile? selectedImage;
  String imagePathCrop = '';

  bool showImage = false;

  String? currentFilterUse;

  Future<void> getImage() async {
    try {
      // Pick an image
      final XFile? imagePicked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (imagePicked != null) {
        // Crop the image
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: imagePicked.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 1800,
          maxHeight: 1800,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: Colors.black,
              cropFrameStrokeWidth: 3,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              cropFrameColor: Colors.white,
              dimmedLayerColor: Colors.grey[800],
              activeControlsWidgetColor: const Color.fromARGB(255, 14, 101, 79),
              showCropGrid: false,
            ),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
          ],
        );

        if (croppedFile != null) {
          // Update the state to show the popup with the cropped image
          setState(() {
            imagePathCrop = croppedFile.path;
            selectedImage = XFile(croppedFile.path);
            imageFile = File(croppedFile.path);
            _showImageDialog(croppedFile.path);
            // Show the dialog with the image
          });
        }
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  void _showImageDialog(String imagePath) async {
    final selectedFilter = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ImageDialog(
          imagePath: imagePath,
        );
      },
    );

    setState(() {
      currentFilterUse = selectedFilter;
      showImage = true;
    });
  }

  Widget applyFilterUse(String imagePathuse) {
    switch (currentFilterUse) {
      case '0':
        return Image.file(
          File(imagePathuse),
          fit: BoxFit.cover,
          height: 300,
          width: 300,
        );
      case '1':
        return ClipPath(
          clipper: HeartClip(),
          child: CustomPaint(
            painter: Heart(),
            child: Image.file(
              File(imagePathuse),
              fit: BoxFit.cover,
              height: 300,
              width: 300,
            ),
          ),
        );

      case '2':
        return ClipPath(
          clipper: SquareClip(),
          child: CustomPaint(
            painter: Square(),
            child: Image.file(
              File(imagePathuse),
              fit: BoxFit.cover,
              height: 300,
              width: 300,
            ),
          ),
        );
      case '3':
        return ClipPath(
          clipper: CircleClip(),
          child: CustomPaint(
            painter: Circle(),
            child: Image.file(
              File(imagePathuse),
              fit: BoxFit.cover,
              height: 300,
              width: 300,
            ),
          ),
        );
      case '4':
        return ClipPath(
          clipper: RoundRectangleClip(),
          child: CustomPaint(
            painter: RoundRectangle(),
            child: Image.file(
              File(imagePathuse),
              fit: BoxFit.cover,
              height: 300,
              width: 300,
            ),
          ),
        );

      default:
        return Image.file(
          File(imagePathuse),
          fit: BoxFit.cover,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Images / Icon',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontFamily: 'DM_Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upload Image',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      height: 40,
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 14, 101, 79),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          'Choose from Device',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: showImage == false ? null : applyFilterUse(imagePathCrop),
          )
        ],
      ),
    );
  }
}
