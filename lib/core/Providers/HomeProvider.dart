import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/home/domain/usecase/get_featured.dart';
import 'package:quiky_user/features/home/domain/usecase/get_popular.dart';
import 'package:quiky_user/features/home/domain/usecase/get_trending_grocry.dart';
import 'package:quiky_user/features/home/domain/usecase/get_trending_restaurants.dart';

import '../../features/home/data/model/recipie_model.dart';
import '../../features/home/domain/entity/recipie.dart';
import '../../features/home/domain/usecase/get_recipies.dart';
import '../../injection_container.dart';
import '../error/failure.dart';

class HomeProvider extends ChangeNotifier {
  /// Initialisations
  GetRecipies _getRecipies = GetRecipies(repository: sl());
  GetTrendingGrocery _getTrendingGrocery = GetTrendingGrocery(repository: sl());
  GetTrendingRestaurents _getTrendingRestaurents =
      GetTrendingRestaurents(repository: sl());
  GetFeatured _getFeatured = GetFeatured(repository: sl());
  GetPopular _getPopular = GetPopular(repository: sl());

  /// Local declarations
  List<RecipieModel> _recipies;
  List<Restaurant> _trendingResList;
  List<Restaurant> _trendingGrosList;
  List<Restaurant> _populatList;
  List<Restaurant> _featuredList;

  int _error;

  // Getter methods
  List<Recipie> get getRecipies => _recipies;
  int get error => _error;
  List<Restaurant> get inTheSpotLight => _featuredList;
  List<Restaurant> get popularBrands => _populatList;
  List<Restaurant> get restaurantsNearBy => _trendingResList;
  List<Restaurant> get storesNearBy => _trendingGrosList;

  /// Call this fn each time the location is changed
  ///
  /// Only call this after making sure Lat & Long are non - null
  getData(double lat, double long) {
    _getRecipiesData();
    _trendingGrosList = _getRestaurantData(_getTrendingRestaurents, lat, long);
    _featuredList = _getRestaurantData(_getFeatured, lat, long);
    _populatList = _getRestaurantData(_getPopular, lat, long);
    _trendingGrosList = _getRestaurantData(_getTrendingGrocery, lat, long);
  }

  /// Local Helper Methods
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

  _getRestaurantData(Function foo, double lat, double long) async {
    final result = await foo(lat: lat, long: long);
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
      return null;
    }, (value) {
      notifyListeners();
      return value;
    });
  }
}
