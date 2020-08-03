// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  AddressModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel(
      formattedAddress: fields[0] as String,
      shortAddress: fields[1] as String,
      lat: fields[2] as double,
      long: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.formattedAddress)
      ..writeByte(1)
      ..write(obj.shortAddress)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.long);
  }

  @override
  int get typeId => 2;
}
