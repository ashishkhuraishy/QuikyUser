// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfferAdapter extends TypeAdapter<Offer> {
  @override
  final int typeId = 13;

  @override
  Offer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Offer(
      id: fields[0] as int,
      title: fields[1] as String,
      code: fields[2] as String,
      text: fields[3] as String,
      offerId: fields[4] as int,
      percentage: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Offer obj) {
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
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfferAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
