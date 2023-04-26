import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/core/models/normal_models.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:outugo_flutter_mobile/utils/constants/asset_constants/image_constants.dart';

class PetDetailCard extends StatelessWidget {
  PetDetailCard({super.key, required this.pet});

  PetDetail pet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(
              ImageConstants.petPhotoHolder,
            ),
            radius: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.Name ?? '',
                style: AppTheme.title16black600(),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                pet.Breed ?? '',
                style: AppTheme.detail14black400(),
              ),
              SizedBox(
                height: 5,
              ),
              if (pet.ColorMarking != null)
                Text(
                  pet.ColorMarking!,
                  style: AppTheme.detail14black400(),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
