// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woo_user_billing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WooUserBillingAdapter extends TypeAdapter<WooUserBilling> {
  @override
  final int typeId = 10;

  @override
  WooUserBilling read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WooUserBilling()
      .._firstName = fields[0] as String?
      .._lastName = fields[1] as String?
      .._company = fields[2] as String?
      .._address1 = fields[3] as String?
      .._address2 = fields[4] as String?
      .._city = fields[5] as String?
      .._postcode = fields[6] as String?
      .._country = fields[7] as String?
      .._state = fields[8] as String?
      .._email = fields[9] as String?
      .._phone = fields[10] as String?;
  }

  @override
  void write(BinaryWriter writer, WooUserBilling obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj._firstName)
      ..writeByte(1)
      ..write(obj._lastName)
      ..writeByte(2)
      ..write(obj._company)
      ..writeByte(3)
      ..write(obj._address1)
      ..writeByte(4)
      ..write(obj._address2)
      ..writeByte(5)
      ..write(obj._city)
      ..writeByte(6)
      ..write(obj._postcode)
      ..writeByte(7)
      ..write(obj._country)
      ..writeByte(8)
      ..write(obj._state)
      ..writeByte(9)
      ..write(obj._email)
      ..writeByte(10)
      ..write(obj._phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooUserBillingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
