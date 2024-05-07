import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getSurfApplicationDocumentsDirectory() async {
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  return appDocumentsDir.path;
}
