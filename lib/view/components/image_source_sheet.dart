import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key, required this.onImageSelected});

  final ValueSetter<ImageSource> onImageSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text("Choose Image From:", style: AppTheme.title16black600()),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                icon: Icon(Icons.photo_camera),
                onPressed: () {
                  Navigator.pop(context);
                  onImageSelected(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.photo_library),
                onPressed: () {
                  Navigator.pop(context);
                  onImageSelected(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
