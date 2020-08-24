import 'dart:io';

import 'package:path/path.dart';

String fixture(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('\\test')) {
    dir = dir.replaceAll('\\test', '');
  }
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File(join('$dir', 'test', 'fixtures', '$name')).readAsStringSync();
}
