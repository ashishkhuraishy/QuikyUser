import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/home/domain/usecase/get_stores.dart';

import '../../injection_container.dart';

class RestaurantService {
  GetStores _getStores = GetStores(repository: sl());

  ValueNotifier<String> error = ValueNotifier<String>("");
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  List<Restaurant> restaurants = [];

  final double lat, lng;
  final StoreType storeType;

  RestaurantService({
    @required this.lat,
    @required this.lng,
    @required this.storeType,
  });

  Future<List<Restaurant>> getStores() async {
    final result = await _getStores(
      lat: this.lat,
      lng: this.lng,
      storeType: this.storeType,
    );

    result.fold(
      (failure) => error.value = failure.toString(),
      (restauantList) => restaurants = restauantList,
    );
    return restaurants;
  }

  List<Restaurant> get trending {
    return restaurants
        .where((element) => element.option == "trending")
        .toList();
  }

  List<Restaurant> get nearby {
    List<Restaurant> temp = restaurants;
    temp.sort((a, b) => double.parse(a.avgDeliveryTime)
        .compareTo(double.parse(b.avgDeliveryTime)));
    return temp;
  }

  List<Restaurant> get rating {
    List<Restaurant> temp = restaurants;
    temp.sort((a, b) =>
        double.parse(a.avgRating).compareTo(double.parse(b.avgRating)));
    return temp;
  }

  List<Restaurant> get newArrivals {
    return restaurants.where((element) => element.highlightStatus).toList();
  }
}
