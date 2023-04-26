import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/view/components/oug_web_view.dart';
import 'package:outugo_flutter_mobile/view/components/page_with_appbar.dart';
import 'package:outugo_flutter_mobile/view/components/webview_buttons.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithAppBar(
        title: "Resources",
        child: OUGWebView(
          url: 'https://outugo.com/sitterresources20',
        ));
  }
}
