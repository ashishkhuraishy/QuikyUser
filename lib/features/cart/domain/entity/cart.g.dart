// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartAdapter extends TypeAdapter<Cart> {
  @override
  final int typeId = 14;

  @override
  Cart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cart(
      storeId: fields[0] as int,
      offers: (fields[1] as List)?.cast<Offer>(),
      cartItems: (fields[2] as List)?.cast<CartItem>(),
      storeName: fields[3] as String,
      storeAddress: fields[4] as String,
      storeImage: fields[5] as String,
      storeLogo: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.storeId)
      ..writeByte(3)
      ..write(obj.storeName)
      ..writeByte(4)
      ..write(obj.storeAddress)
      ..writeByte(5)
      ..write(obj.storeImage)
      ..writeByte(6)
      ..write(obj.storeLogo)
      ..writeByte(1)
      ..write(obj.offers)
      ..writeByte(2)
      ..write(obj.cartItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
