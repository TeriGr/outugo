import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_pages.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:outugo_flutter_mobile/view/bindings/initial_bindings.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: getInitialRoute(),
      initialBinding: InitialBindings(),
    );
  }
}
