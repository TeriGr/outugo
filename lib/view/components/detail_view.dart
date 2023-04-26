import 'package:flutter/cupertino.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/widgets/blue_container.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DetailView extends StatelessWidget {
  const DetailView(
      {super.key, required this.title, this.details, this.haveHeader = true});
  final String title;
  final Map<String, String>? details;
  final bool haveHeader;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlueContainer(title: title),
        if (details != null)
          ListView.builder(
            itemCount: details!.entries.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) => buildNotes(
              details!.keys.elementAt(index),
              details!.values.elementAt(index), haveHeader: haveHeader,
              // children: details!.entries
              //     .map((e) =>
              //         buildNotes(e.key, e.value, haveHeader: haveHeader))
              //     .toList(),
            ),
          ),
        // : SizedBox()
      ],
      // header: BlueContainer(title: title),
      // overlapHeaders: true,
      // content: (details != null)
      //     ? ListView.builder(
      //         itemCount: details!.entries.length,
      //         physics: BouncingScrollPhysics(),
      //         shrinkWrap: true,
      //         itemBuilder: (context, index) => buildNotes(
      //               details!.keys.elementAt(index),
      //               details!.values.elementAt(index), haveHeader: haveHeader,
      //               // children: details!.entries
      //               //     .map((e) =>
      //               //         buildNotes(e.key, e.value, haveHeader: haveHeader))
      //               //     .toList(),
      //             ))
      //     : SizedBox());
    );
  }
}
