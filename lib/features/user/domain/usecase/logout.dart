import 'package:quiky_user/features/user/domain/repository/user_repository.dart';

class LogOut {
  final UserRepository repository;

  LogOut(this.repository);

  void call() {
    return repository.logout();
  }
}
