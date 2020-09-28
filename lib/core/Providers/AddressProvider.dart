import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/features/location_service/domain/usecase/cache_address.dart';
import 'package:quiky_user/features/location_service/domain/usecase/get_address.dart';
import 'package:quiky_user/injection_container.dart';

class AddressProvider extends ChangeNotifier {
  Address _addressModel = Address(
    formattedAddress: '',
    shortAddress: '',
    lat: 0.0,
    long: 0.0,
  );
  GetAddress getAddress = GetAddress(sl());
  CacheAddress cacheAddress = CacheAddress(repo: sl());

  Address get currentAddress => _addressModel;

  Failure _failure;
  get error => _failure;

  getCurrentAddress() async {
    print('Get Address Called');
    final resultEither = await getAddress.execute();

    resultEither.fold(
      (failure) {
        _catchError(failure);
        // throw ConnectionFailure();
      },
      (address) {
        _addressModel = address;
        print(_addressModel.shortAddress);
        notifyListeners();
      },
    );
  }

  cacheCurrentAddress(Address address) async {
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

  makeCurrentAddress(Address address) async {
    _addressModel = address;
    notifyListeners();
  }

  _catchError(Failure failure) {
    print('Error Occured at AddressProvider : ${failure.runtimeType}');
    switch (failure.runtimeType) {
      case ConnectionFailure:
        _failure = ConnectionFailure as Failure;
        // TODO : Do Something when Connection Fails
        break;
      case CacheFailure:
        _failure = CacheFailure as Failure;

        /// TODO : Do Something when getting data
        /// from localStorage  Fails
        break;
      case LocationFailure:
        _failure = LocationFailure as Failure;
        // TODO : Do Something when getting Location Fails
        break;
      case ServerFailure:
        _failure = ServerFailure as Failure;
        // TODO : Do Something when Api response has errors Fails
        break;
      default:
    }
  }
}
