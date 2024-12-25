import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_theme_builder/material_theme_builder.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: MaterialThemeBuilder(
                primary: Colors.lightBlueAccent,
                secondary: Colors.blue,
                tertiary: Colors.lightBlue)
            .toScheme(),
      ),
    ),
  );
}
