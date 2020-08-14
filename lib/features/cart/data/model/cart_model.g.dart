// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  CartModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModel(
      storeId: fields[0] as int,
      offers: (fields[1] as List)?.cast<OfferModel>(),
      cartItems: (fields[2] as List)?.cast<CartItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.storeId)
      ..writeByte(1)
      ..write(obj.offers)
      ..writeByte(2)
      ..write(obj.cartItems);
  }

  @override
  int get typeId => 3;
}
