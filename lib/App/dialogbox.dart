import 'dart:io';

import 'package:photo_filter_app/shapes/circle.dart';
import 'package:photo_filter_app/shapes/heart.dart';
import 'package:photo_filter_app/shapes/round_rect.dart';
import 'package:photo_filter_app/shapes/square.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  final String imagePath;
  const ImageDialog({super.key, required this.imagePath});

  @override
  // ignore: no_logic_in_create_state
  State<ImageDialog> createState() => _ImageDialogState(imagePath: imagePath);
}

class _ImageDialogState extends State<ImageDialog> {
  String currentFilter = '0';

  final String imagePath;

  String givenFilter = '';

  _ImageDialogState({required this.imagePath});

  Widget applyFilter(String imagePath) {
    switch (currentFilter) {
      case '0':
        return Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          height: 200,
          width: 200,
        );
      case '1':
        return ClipPath(
          clipper: HeartClip(),
          child: CustomPaint(
            painter: Heart(),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
        );

      case '2':
        return ClipPath(
          clipper: SquareClip(),
          child: CustomPaint(
            painter: Square(),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
        );
      case '3':
        return ClipPath(
          clipper: CircleClip(),
          child: CustomPaint(
            painter: Circle(),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
        );
      case '4':
        return ClipPath(
          clipper: RoundRectangleClip(),
          child: CustomPaint(
            painter: RoundRectangle(),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
        );

      default:
        return Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                'Uploaded Image',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'DM_Sans',
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: applyFilter(
                imagePath,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentFilter = '0';
                      givenFilter = '0';
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      'Original',
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentFilter = '1';
                      givenFilter = '1';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/filter1.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentFilter = '2';
                      givenFilter = '2';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/filter2.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentFilter = '3';
                      givenFilter = '3';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/filter3.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentFilter = '4';
                      givenFilter = '4';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/filter4.png'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, currentFilter);
              },
              child: Container(
                height: 40,
                width: 250,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 14, 101, 79),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'Use this image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
