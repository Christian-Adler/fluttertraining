import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedFile;

  Future<void> _takePicker() async {
    final imagePicker = ImagePicker();
    XFile? imgFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600, // reduce size of image - no high res images needed here
    );
    if (imgFile == null) return;
    setState(() {
      _storedFile = File(imgFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imgFile.path);
    final savedImg = await _storedFile?.copy('${appDir.path}/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedFile == null
              ? const Text(
            'No Image Taken',
            textAlign: TextAlign.center,
          )
              : Image.file(
            _storedFile!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            onPressed: _takePicker,
          ),
        ),
      ],
    );
  }
}
