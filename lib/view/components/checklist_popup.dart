import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class ChecklistPopup extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final clickEvent;
  final notesController = TextEditingController();

  ChecklistPopup({
    this.title = "Successful",
    this.clickEvent,
    this.buttonLabel = "OK",
  });

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
              Text(
                title,
                style: AppTheme.subHeadlineStyle()
                    .merge(TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: AppTheme.white,
                        border: Border.all(
                          color: AppTheme.secondaryButtonColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'No',
                        style: AppTheme.subTitleBoldStyle().merge(
                          TextStyle(color: AppTheme.secondaryButtonColor),
                        ),
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Colors.green,
                      ),
                      child: Text(
                        'Yes',
                        style: AppTheme.subTitleBoldStyle().merge(
                          TextStyle(color: AppTheme.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (clickEvent != null) {
                        clickEvent!();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
