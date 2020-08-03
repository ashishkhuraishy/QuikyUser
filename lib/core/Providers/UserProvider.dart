import 'package:hive/hive.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';
import 'package:quiky_user/features/user/domain/usecase/login.dart';
import 'package:quiky_user/features/user/domain/usecase/logout.dart';
import 'package:quiky_user/features/user/domain/usecase/signup.dart';

import '../../injection_container.dart';

class UserProvider {
  Login _login = Login(sl());
  SignUp _signUp = SignUp(sl());
  LogOut _logOut = LogOut(sl());

  final box = Hive.box(CORE_BOX);

  User get getUser => box.get(USER);

  login(String username, String pass) async {
    final result = await _login(username: username, password: pass);

    result.fold((failure) => null, (user) => null);
  }

  signUp(String username, String pass, String name) async {
    final result =
        await _signUp(username: username, password: pass, name: name);

    result.fold((failure) => null, (user) => null);
  }

  logOut() {
    _logOut.call();
  }
}
