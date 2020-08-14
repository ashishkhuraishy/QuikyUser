// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfferModelAdapter extends TypeAdapter<OfferModel> {
  @override
  OfferModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfferModel(
      id: fields[0] as int,
      title: fields[1] as String,
      code: fields[2] as String,
      text: fields[3] as String,
      offerId: fields[4] as int,
      percentage: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OfferModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.offerId)
      ..writeByte(5)
      ..write(obj.percentage);
  }

  @override
  int get typeId => 5;
}
