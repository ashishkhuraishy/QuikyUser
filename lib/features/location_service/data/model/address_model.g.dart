// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 6;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
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
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
