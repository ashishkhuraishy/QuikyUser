// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressModel.dart';

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
      formatedAddress: fields[0] as String,
      shortAddress: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.formatedAddress)
      ..writeByte(1)
      ..write(obj.shortAddress);
  }

  @override
  int get typeId => 0;
}