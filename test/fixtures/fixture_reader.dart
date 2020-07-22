import 'dart:io';

import 'package:path/path.dart';

String fixture(String name) => File(join(
        dirname(Platform.script.toFilePath()), 'test', 'fixtures', '$name'))
    .readAsStringSync();
