import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';
import 'package:quiky_user/features/home/domain/usecase/get_recipies.dart';

import '../../injection_container.dart';

class HomeProvider extends ChangeNotifier {
  List<RecipieModel> _recipies;
  GetRecipies _getRecipies = GetRecipies(repository: sl());
  int _error;

  List<Recipie> get getRecipies => _recipies;
  int get error => _error;

  getData(double lat, double long) {
    _getRecipiesData();
  }

  _getRecipiesData() async {
    final result = await _getRecipies();
    result.fold((failure) {
      switch (failure.runtimeType) {
        case ConnectionFailure: // No Internet Connection
          _error = 1;
          break;
        case ServerFailure: // Error with Server response
          _error = 2;
          _recipies = [];
          break;
        default:
          _error = 3;
      }
      notifyListeners();
    }, (recipies) {
      _recipies = recipies;
      notifyListeners();
    });
  }
}
