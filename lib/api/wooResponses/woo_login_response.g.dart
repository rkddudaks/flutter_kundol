// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_login_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooLoginResponseAdapter extends TypeAdapter<WooLoginResponse> {
  @override
  final int typeId = 12;

  @override
  WooLoginResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooLoginResponse()
      .._cookie = fields[0] as String?
      .._user = fields[1] as WooLoginUser?;
  }

  @override
  void write(BinaryWriter writer, WooLoginResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._cookie)
      ..writeByte(1)
      ..write(obj._user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooLoginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
