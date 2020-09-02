// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentCardAdapter extends TypeAdapter<PaymentCard> {
  @override
  final int typeId = 17;

  @override
  PaymentCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentCard(
      addressCity: fields[0] as String,
      addressCountry: fields[2] as String,
      addressLine1: fields[3] as String,
      addressLine2: fields[4] as String,
      addressState: fields[5] as String,
      addressZip: fields[6] as String,
      brand: fields[7] as String,
      cardId: fields[8] as String,
      country: fields[9] as String,
      expMonth: fields[10] as int,
      expYear: fields[11] as int,
      number: fields[15] as String,
      token: fields[17] as String,
      cvc: fields[16] as String,
      funding: fields[12] as String,
      last4: fields[13] as String,
      name: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentCard obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.addressCity)
      ..writeByte(2)
      ..write(obj.addressCountry)
      ..writeByte(3)
      ..write(obj.addressLine1)
      ..writeByte(4)
      ..write(obj.addressLine2)
      ..writeByte(5)
      ..write(obj.addressState)
      ..writeByte(6)
      ..write(obj.addressZip)
      ..writeByte(7)
      ..write(obj.brand)
      ..writeByte(8)
      ..write(obj.cardId)
      ..writeByte(9)
      ..write(obj.country)
      ..writeByte(10)
      ..write(obj.expMonth)
      ..writeByte(11)
      ..write(obj.expYear)
      ..writeByte(12)
      ..write(obj.funding)
      ..writeByte(13)
      ..write(obj.last4)
      ..writeByte(14)
      ..write(obj.name)
      ..writeByte(15)
      ..write(obj.number)
      ..writeByte(16)
      ..write(obj.cvc)
      ..writeByte(17)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
