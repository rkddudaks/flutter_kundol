// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooUserAdapter extends TypeAdapter<WooUser> {
  @override
  final int typeId = 9;

  @override
  WooUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooUser()
      .._id = fields[0] as int?
      .._dateCreated = fields[1] as String?
      .._dateCreatedGmt = fields[2] as String?
      .._dateModified = fields[3] as String?
      .._dateModifiedGmt = fields[4] as String?
      .._email = fields[5] as String?
      .._firstName = fields[6] as String?
      .._lastName = fields[7] as String?
      .._role = fields[8] as String?
      .._username = fields[9] as String?
      .._billing = fields[10] as WooUserBilling?
      .._shipping = fields[11] as WooUserShipping?
      .._isPayingCustomer = fields[12] as bool?
      .._avatarUrl = fields[13] as String?
      .._cookie = fields[14] as String?;
  }

  @override
  void write(BinaryWriter writer, WooUser obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._dateCreated)
      ..writeByte(2)
      ..write(obj._dateCreatedGmt)
      ..writeByte(3)
      ..write(obj._dateModified)
      ..writeByte(4)
      ..write(obj._dateModifiedGmt)
      ..writeByte(5)
      ..write(obj._email)
      ..writeByte(6)
      ..write(obj._firstName)
      ..writeByte(7)
      ..write(obj._lastName)
      ..writeByte(8)
      ..write(obj._role)
      ..writeByte(9)
      ..write(obj._username)
      ..writeByte(10)
      ..write(obj._billing)
      ..writeByte(11)
      ..write(obj._shipping)
      ..writeByte(12)
      ..write(obj._isPayingCustomer)
      ..writeByte(13)
      ..write(obj._avatarUrl)
      ..writeByte(14)
      ..write(obj._cookie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
