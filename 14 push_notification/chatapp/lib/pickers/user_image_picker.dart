import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  const UserImagePicker({Key? key, required this.imagePickFn}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) return;
    setState(() {
      _pickedImageFile = File(pickedImage.path); // requires import
    });
    if (_pickedImageFile != null) widget.imagePickFn(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: _pickedImageFile == null ? null : FileImage(_pickedImageFile!)),
        TextButton.icon(onPressed: _pickImage, icon: const Icon(Icons.image), label: const Text('Add image')),
      ],
    );
  }
}
