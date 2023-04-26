import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';

class CustomContainerTabs extends StatefulWidget {
  const CustomContainerTabs(
      {super.key,
      required this.titles,
      required this.onTabSelected,
      this.width});
  final List<String> titles;
  final ValueSetter<int> onTabSelected;
  final double? width;
  @override
  State<CustomContainerTabs> createState() => _CustomContainerTabsState();
}

class _CustomContainerTabsState extends State<CustomContainerTabs> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 32,
      width: widget.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selected = index;
              });
              log(selected.toString());
              widget.onTabSelected(index);
            },
            child: Container(
              color: selected == index ? AppTheme.primaryColor : Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
              width: widget.width != null
                  ? widget.width! / widget.titles.length
                  : null,
              child: Center(
                child: Text(
                  widget.titles[index],
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: selected == index
                        ? Colors.white
                        : AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: widget.titles.length,
      ),
    );
  }
}
