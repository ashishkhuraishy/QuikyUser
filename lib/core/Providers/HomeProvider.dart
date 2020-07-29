import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/data/model/restaurant_model.dart';
import 'package:quiky_user/features/home/domain/usecase/get_featured.dart';
import 'package:quiky_user/features/home/domain/usecase/get_popular.dart';
import 'package:quiky_user/features/home/domain/usecase/get_trending_grocry.dart';
import 'package:quiky_user/features/home/domain/usecase/get_trending_restaurants.dart';

import '../../features/home/data/model/recipie_model.dart';
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
  List<RestaurantModel> _trendingResList;
  List<RestaurantModel> _trendingGrosList;
  List<RestaurantModel> _populatList;
  List<RestaurantModel> _featuredList;

  // Getter methods
  List<RecipieModel> get getRecipies => _recipies;
  List<RestaurantModel> get inTheSpotLight => _featuredList;
  List<RestaurantModel> get popularBrands => _populatList;
  List<RestaurantModel> get restaurantsNearBy => _trendingResList;
  List<RestaurantModel> get storesNearBy => _trendingGrosList;

  // Error handling
  int _error;
  int get error => _error;

  /// Call this fn when the location is changed
  ///
  /// Only call this after making sure Lat & Long are non - null
  getData(double lat, double long) async {
    await _getFeaturedData(lat, long);
    await _getPopularData(lat, long);
    await _getRecipiesData();
    await _getTrendingRestaurantData(lat, long);
    await _getTrendingGeroceryData(lat, long);
  }

  /// Local Helper Methods
  _getRecipiesData() async {
    final result = await _getRecipies();
    result.fold((failure) {
      _checkeroor(failure, 'GetRecipie');
    }, (recipies) {
      print('Recipies $recipies');
      _recipies = recipies;
      notifyListeners();
    });
  }

  _getFeaturedData(double lat, double long) async {
    final result = await _getFeatured(lat: lat, long: long);
    result.fold((failure) {
      _checkeroor(failure, 'GetFeatured');
    }, (restaurants) {
      print('Featured ${restaurants[0].title}');
      _featuredList = restaurants;
      notifyListeners();
    });
  }

  _getPopularData(double lat, double long) async {
    final result = await _getPopular(lat: lat, long: long);
    result.fold((failure) {
      _checkeroor(failure, 'GetPopular');
    }, (restaurants) {
      print('Popular ${restaurants[0].title}');
      _populatList = restaurants;
      notifyListeners();
    });
  }

  _getTrendingRestaurantData(double lat, double long) async {
    final result = await _getTrendingRestaurents(lat: lat, long: long);
    result.fold((failure) {
      _checkeroor(failure, 'GetTrendingRestaurant');
    }, (restaurants) {
      print('Trending Restaurants ${restaurants[0].title}');
      _trendingResList = restaurants;
      notifyListeners();
    });
  }

  _getTrendingGeroceryData(double lat, double long) async {
    final result = await _getTrendingGrocery(lat: lat, long: long);
    result.fold((failure) {
      _checkeroor(failure, 'GetTrendingGrocery');
    }, (restaurants) {
      print('Trending Grocery ${restaurants[0].title}');
      _trendingGrosList = restaurants;
      notifyListeners();
    });
  }

  _checkeroor(Failure failure, String fnName) {
    switch (failure.runtimeType) {
      case ConnectionFailure: // No Internet Connection
        _error = 1;
        break;
      case ServerFailure: // Error with Server response
        _error = 2;
        break;
      default:
        _error = 3;
    }
    print('Error ${failure.runtimeType} happened at $fnName');
    notifyListeners();
  }
}
