import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

const String ADDRESS_BOX = 'ADDRESS_BOX';

abstract class AddressLocalDataSource {
  /// Caches the given data onto the local Storage
  /// for future use,
  /// on failure will throw [CacheException] error
  Future<bool> cacheAddress(Address addressModel);

  /// Get an address from the local storage in case
  /// remote data cannot access data from the internet.
  ///
  /// will throw [CacheException] if not data is found in
  /// the local storage.
  Future<AddressModel> getAnyAddress();

  /// Get all address from the local storage to display as
  /// the ADDRESS BOOK
  ///
  /// will throw [CacheException] if not data is found in
  /// the local storage.
  Future<List<AddressModel>> getAllAddress();
}

class AddresLocalDataSourceImpl extends AddressLocalDataSource {
  final HiveInterface hive;

  AddresLocalDataSourceImpl({@required this.hive});

  @override
  Future<bool> cacheAddress(Address addressModel) async {
    if (!hive.isBoxOpen(ADDRESS_BOX)) hive.openBox(ADDRESS_BOX);
    try {
      Box addressBox = hive.box(ADDRESS_BOX);
      await addressBox.add(addressModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AddressModel> getAnyAddress() {
    if (!hive.isBoxOpen(ADDRESS_BOX)) hive.openBox(ADDRESS_BOX);
    Box addressBox = hive.box(ADDRESS_BOX);
    if (addressBox.isNotEmpty) {
      try {
      return Future.value(addressBox.getAt(0));
      } catch (e) {
        throw CacheException();
      }
    } else
      throw CacheException();
  }

  @override
  Future<List<AddressModel>> getAllAddress() async {
    if (!hive.isBoxOpen(ADDRESS_BOX)) hive.openBox(ADDRESS_BOX);
    Box addressBox = hive.box(ADDRESS_BOX);
    List<AddressModel> res = [];
    if (addressBox.isNotEmpty) {
      for (var address in addressBox.values) {
        res.add(address as AddressModel);
      }
    }

    return res;
  }
}
