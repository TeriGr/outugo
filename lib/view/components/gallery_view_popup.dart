import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/image_source_sheet.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:path_provider/path_provider.dart';

class GalleryViewPopup extends StatefulWidget {
  @override
  _GalleryViewPopupState createState() => _GalleryViewPopupState();
}

class _GalleryViewPopupState extends State<GalleryViewPopup> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.all(34.0),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text(
                "Visit Photo Gallery",
                style: AppTheme.subHeadlineStyle()
                    .merge(TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              imagesListView(context),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(5.0)),
                  child: Text(
                    'Cancel',
                    style: AppTheme.titleStyle()
                        .merge(TextStyle(color: Colors.black)),
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
                ElevatedButton(
                  child: Text(
                    'OK',
                    style: AppTheme.titleStyle()
                        .merge(TextStyle(color: Colors.white)),
                  ),
                  onPressed: () {
                    homeController.selectedInProgressActivity.images =
                        homeController.tempFiles;
                    homeController.files.value = homeController.tempFiles;
                    Navigator.pop(context, true);
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  imagesListView(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(8),
      child: Obx(
        () => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return cards(context, index);
          },
          itemCount: homeController.tempFiles.length + 1,
        ),
      ),
    );
  }

  Widget cards(BuildContext context, int index) {
    log('message');
    return Stack(
      children: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Center(
              child: index == homeController.tempFiles.length
                  ? captureImage()
                  : thumbnailView(context, index),
            ),
          ),
        ),
      ],
    );
  }

  Widget captureImage() {
    return GestureDetector(
      onTap: () {
        // Get.bottomSheet(ImageSourceSheet(onImageSelected: (value) {
        //   _getImage(value);
        // }));
        _getImage(ImageSource.camera);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget thumbnailView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => showImagePreview(context, index),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Center(
              child: Image.file(homeController.tempFiles[index]),
            ),
          ),
          Positioned(
            top: -10,
            right: -16,
            child: TextButton(
              onPressed: () => removeImage(index),
              child: Image.asset(
                'assets/images/alert_cancel.png',
                width: 25,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _getImage(ImageSource source) async {
    takePhoto(source).then((value) async {
      if (value != null) {
        File image = File(value);

        final folderPath = await localPath();

        print(folderPath);

        final File newImage = await image.copy(
            '$folderPath/image${homeController.tempFiles.length + 1}.png');
        var temp = homeController.tempFiles;
        temp.add(newImage);
        homeController.tempFiles = temp;
      }
    });
  }

  Future<String> localPath() async {
    Directory directory = await getApplicationDocumentsDirectory();

    final Directory activityImagesDirectory = Directory(
        '${directory.path}/images/${homeController.selectedActivity.RecordID}');
    if (await activityImagesDirectory.exists()) {
      return activityImagesDirectory.path;
    }

    final Directory appDocDirNewFolder =
        await activityImagesDirectory.create(recursive: true);
    return appDocDirNewFolder.path;
  }

  void removeImage(int index) {
    var temp = homeController.tempFiles;
    temp.removeAt(index);
    homeController.tempFiles = temp;
  }

  showImagePreview(BuildContext context, int index) {
    Navigator.of(context).push(
      CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) {
            return Stack(
              children: [
                Container(
                  child: Center(
                    child: Image.file(homeController.tempFiles[index]),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Image.asset(
                      'assets/images/alert_cancel.png',
                      width: 25,
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
