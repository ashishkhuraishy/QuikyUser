import 'package:hive/hive.dart';

part 'AddressModel.g.dart';

@HiveType(typeId: 0)
class AddressModel {
  @HiveField(0)
  String formatedAddress;
  @HiveField(1)
  String shortAddress;

  AddressModel({this.formatedAddress, this.shortAddress});
}
