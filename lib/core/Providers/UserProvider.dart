import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';
import 'package:quiky_user/features/user/domain/usecase/login.dart';
import 'package:quiky_user/features/user/domain/usecase/logout.dart';
import 'package:quiky_user/features/user/domain/usecase/signup.dart';

import '../../injection_container.dart';

class UserProvider extends ChangeNotifier {
  Login _login = Login(sl());
  SignUp _signUp = SignUp(sl());
  LogOut _logOut = LogOut(sl());
  bool loading = false;
  String error = "";

  final box = Hive.box(CORE_BOX);

  User get getUser => box.get(USER);

  setError() {
    error="";
    notifyListeners();
  }

  load(bool b) {
    loading = b;
    notifyListeners();
  }

  login(String username, String pass) async {
    load(true);

    final result = await _login(username: username, password: pass);

    result.fold((failure) => failure, (user) => user);
    print(result);
    if (result.isLeft())
      error = result.fold((l) => l, (r) => r).toString();
    else
      error = "";
    load(false);
  }

  signUp(String username, String pass, String name) async {
    load(true);
    final result =
        await _signUp(username: username, password: pass, name: name);
    result.fold((failure) => failure, (user) => user);
    print(result);
    if (result.isLeft())
      error = result.fold((l) => l, (r) => r).toString();
    else
      error = "";
    load(false);
  }

  logOut() {
    _logOut.call();
  }
}
