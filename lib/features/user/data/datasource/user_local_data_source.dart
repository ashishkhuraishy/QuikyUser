import 'package:quiky_user/features/user/domain/entity/user.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser(User user);
  Future<void> logout();
}
