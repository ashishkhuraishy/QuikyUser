import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/address.dart';
import '../repository/address_repo.dart';

class GetAddress {
  final AddressRepository addressRepository;

  GetAddress(this.addressRepository);

  Future<Either<Failure, Address>> execute() async {
    return await addressRepository.getAddress();
  }

}
