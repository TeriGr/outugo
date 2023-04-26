import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class NotesViewPopup extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final String text;
  final ValueSetter<String>? clickEvent;
  final notesController = TextEditingController();

  NotesViewPopup({
    this.title = "Add Notes",
    this.clickEvent,
    required this.text,
    this.buttonLabel = "OK",
  });

  @override
  Widget build(BuildContext context) {
    notesController.text = text;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.topCenter,
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(
                    width: 0.5,
                    color: AppTheme.listHeaderColor,
                  ),
                ),
                child: TextFormField(
                  controller: this.notesController,
                  keyboardAppearance: Brightness.dark,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  autofocus: true,
                  maxLines: 4,
                  style: AppTheme.titleStyle().merge(
                    TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {},
                  decoration: new InputDecoration(
                    labelStyle:
                        AppTheme.subTitleStyle().copyWith(color: Colors.grey),
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    contentPadding: const EdgeInsets.only(
                      top: 10.0,
                      right: 45.0,
                      bottom: 15.0,
                      left: 5.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
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
                        'Cancel',
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
                        buttonLabel,
                        style: AppTheme.subTitleBoldStyle().merge(
                          TextStyle(color: AppTheme.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (clickEvent != null) {
                        clickEvent!(notesController.text);
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
