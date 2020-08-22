// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[4] as int,
      userId: fields[5] as int,
      userName: fields[6] as String,
      name: fields[7] as String,
      token: fields[8] as String,
      email: fields[9] as String,
      mobile: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.userName)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.token)
      ..writeByte(9)
      ..write(obj.email)
      ..writeByte(10)
      ..write(obj.mobile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
