import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/home/domain/usecase/get_stores.dart';

import '../../injection_container.dart';

class RestaurantService {
  GetStores _getStores = GetStores(repository: sl());

  ValueNotifier<String> error = ValueNotifier<String>("");
  ValueNotifier<List<Restaurant>> restaurants =
      ValueNotifier<List<Restaurant>>([]);

  final double lat, lng;
  final StoreType storeType;

  RestaurantService({
    @required this.lat,
    @required this.lng,
    @required this.storeType,
  });

  getStores() async {
    final result = await _getStores(
      lat: this.lat,
      lng: this.lng,
      storeType: this.storeType,
    );

    result.fold(
      (failure) => error.value = failure.toString(),
      (restauantList) => restaurants.value = restauantList,
    );
  }
}
