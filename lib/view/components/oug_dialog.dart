import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  CANCEL,
  INFO,
  CONFIRM,
  NONE,
}

class OUGDialog extends StatelessWidget {
  final AlertDialogType type;
  final String title;
  final String content;
  final String buttonLabel;
  final Function()? clickEvent;

  OUGDialog({
    this.title = "Successful",
    required this.content,
    this.clickEvent,
    this.type = AlertDialogType.INFO,
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
              if (_imageForAlert() != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    _imageForAlert(),
                    width: 60,
                  ),
                ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: AppTheme.subHeadlineStyle()
                    .merge(TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                content,
                style:
                    AppTheme.titleStyle().merge(TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.0),
              type == AlertDialogType.CONFIRM
                  ? withCancel(context)
                  : InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (clickEvent != null) {
                          clickEvent!();
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.green,
                        ),
                        child: Text(
                          buttonLabel,
                          style: AppTheme.subTitleBoldStyle().merge(
                            TextStyle(color: AppTheme.white),
                          ),
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }

  withCancel(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
    );
  }

  String _imageForAlert() {
    if (type == AlertDialogType.SUCCESS) {
      return 'assets/images/alert_success.png';
    } else if (type == AlertDialogType.ERROR) {
      return 'assets/images/alert_error.png';
    } else if (type == AlertDialogType.WARNING) {
      return 'assets/images/alert_error.png';
    } else if (type == AlertDialogType.CONFIRM) {
      return 'assets/images/alert_error.png';
    } else if (type == AlertDialogType.CANCEL) {
      return 'assets/images/alert_cancel.png';
    } else if (type == AlertDialogType.INFO) {
      return 'assets/images/alert_info.png';
    }

    return 'assets/images/alert_info.png';
  }
}
