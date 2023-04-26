import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/components/gallery_view_popup.dart';
import 'package:outugo_flutter_mobile/view/components/image_source_sheet.dart';
import 'package:outugo_flutter_mobile/view/controllers/home_controller.dart';
import 'package:path_provider/path_provider.dart';

import 'notes_view_popup.dart';

class VisitStartedOptions extends StatelessWidget {
  VisitStartedOptions({super.key});

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCircularButton(
          Icons.add_a_photo,
          () {
            // Get.bottomSheet(ImageSourceSheet(onImageSelected: (value) {
            //   _getImage(value);
            // }));
            _getImage(ImageSource.camera);
          },
        ),
        Obx(
          () => _buildCircularButton(Icons.photo_library, //Icons.camera_alt,
              () {
            if (homeController.files.isNotEmpty) {
              homeController.tempFiles.value =
                  homeController.selectedInProgressActivity.images ?? [];
              Get.dialog(GalleryViewPopup());
            }
          },
              color: homeController.files.isNotEmpty
                  ? AppTheme.buttonColor
                  : AppTheme.dividerColor),
        ),
        Obx(
          () => _buildCircularButton(Icons.assignment, () {
            homeController.reportCardSummary.isNotEmpty
                ? Get.dialog(NotesViewPopup(
                    title: 'Visit Comments\n(to Office)',
                    buttonLabel: 'Save',
                    clickEvent: (value) {
                      homeController.selectedInProgressActivity.noteForOffice =
                          value;
                      homeController.reportCardSummary.value = value;
                    },
                    text: homeController
                            .selectedInProgressActivity.noteForOffice ??
                        '',
                  ))
                : null;
          },
              color: homeController.reportCardSummary.isNotEmpty
                  ? AppTheme.buttonColor
                  : AppTheme.dividerColor),
        ),
      ],
    );
  }

  // a circular container that accepts an icondata and an onpressed function
  Widget _buildCircularButton(IconData icon, Function onPressed,
      {Color color = AppTheme.buttonColor}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50.0)),
          child: Icon(
            icon,
            size: 24.0,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(13.0),
          margin: EdgeInsets.symmetric(horizontal: 5)),
    );
  }

  void _getImage(ImageSource source) async {
    homeController.selectedInProgressActivity.images ??= [];
    takePhoto(source).then((value) async {
      if (value != null) {
        File image = File(value);

        final folderPath = await localPath();

        print(folderPath);

        // copy the file to a new path
        final File newImage = await image.copy(
            '$folderPath/image${homeController.selectedInProgressActivity.images!.length + 1}.png');
        homeController.selectedInProgressActivity.images!.add(newImage);
        homeController.files.add(newImage);
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
}
