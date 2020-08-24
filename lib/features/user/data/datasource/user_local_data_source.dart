import 'package:hive/hive.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';

const String CORE_BOX = 'CORE_BOX';
const String USER = 'USER';

abstract class UserLocalDataSource {
  Future<void> cacheUser(User user);
  Future<void> logout();
}

class UserLocalDataSourceImpl extends UserLocalDataSource {
  final HiveInterface hive;

  UserLocalDataSourceImpl({this.hive});

  @override
  Future<void> cacheUser(User user) async {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);

    Box box = hive.box(CORE_BOX);
    await box.put(USER, user);
  }

  @override
  Future<void> logout() async {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);

    Box box = hive.box(CORE_BOX);
    await box.put(USER, null);
  }
}
