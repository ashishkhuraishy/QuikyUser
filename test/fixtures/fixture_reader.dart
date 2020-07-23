import 'dart:io';

import 'package:path/path.dart';

Future<String> fixture(String name) async => File(join(
        dirname(Platform.script.toFilePath()), 'test', 'fixtures', '$name'))
    .readAsStringSync();
