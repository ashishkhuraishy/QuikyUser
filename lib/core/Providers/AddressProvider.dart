import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/features/location_service/domain/usecase/cache_address.dart';
import 'package:quiky_user/features/location_service/domain/usecase/get_address.dart';
import 'package:quiky_user/injection_container.dart';

class AddressProvider extends ChangeNotifier {
  AddressModel _addressModel = AddressModel(
    formattedAddress: '',
    shortAddress: '',
    lat: 0.0,
    long: 0.0,
  );
  GetAddress getAddress = GetAddress(sl());
  CacheAddress cacheAddress = CacheAddress(repo: sl());

  Address get currentAddress => _addressModel;

  getCurrentAddress() async {
    final resultEither = await getAddress.execute();

    resultEither.fold(
      (failure) => _catchError(failure),
      (address) {
        _addressModel = address;
        notifyListeners();
      },
    );
  }

  cacheCurrentAddress(AddressModel address) async {
    final resultEither = await cacheAddress(address);

    resultEither.fold(
      (failure) => _catchError(failure),
      (sucess) {
        if (sucess) {
          _addressModel = address;
          notifyListeners();
        }
      },
    );
  }

  _catchError(Failure failure) {
    print('Error Occured at AddressProvider : ${failure.runtimeType}');
    switch (failure.runtimeType) {
      case ConnectionFailure:
        // TODO : Do Something when Connection Fails
        break;
      case CacheFailure:

        /// TODO : Do Something when getting data
        /// from localStorage  Fails
        break;
      case LocationFailure:
        // TODO : Do Something when getting Location Fails
        break;
      case ServerFailure:
        // TODO : Do Something when Api response has errors Fails
        break;
      default:
    }
  }
}
