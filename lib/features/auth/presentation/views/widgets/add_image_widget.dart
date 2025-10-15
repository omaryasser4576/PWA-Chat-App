import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pwa/core/utils/colors_theme.dart';

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({
    super.key,
    required this.selectedImage,
  });

  final Function(File?) selectedImage;

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    widget.selectedImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color(0XFFDECFF4),
                width: 2,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _image == null
                    ? const AssetImage("assets/images/test.png")
                    : FileImage(_image!),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: ColorsTheme.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
