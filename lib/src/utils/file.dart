import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getSurfApplicationDocumentsDirectory() async {
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  if (appDocumentsDir == null) {
    throw MissingPlatformDirectoryException(
        'Unable to get application documents directory');
  }
  return appDocumentsDir.path;
}
