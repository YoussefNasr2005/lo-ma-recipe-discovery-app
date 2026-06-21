// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealModelAdapter extends TypeAdapter<MealModel> {
  @override
  final int typeId = 0;

  @override
  MealModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealModel(
      idMeal: fields[0] as String?,
      strMeal: fields[1] as String?,
      strMealThumb: fields[2] as String?,
      strInstructions: fields[3] as String?,
      strYoutube: fields[4] as String?,
      strCategory: fields[5] as String?,
      strArea: fields[6] as String?,
      strCountry: fields[7] as String?,
      strIngredient: (fields[8] as List).cast<String>(),
      strMeasure: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MealModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.idMeal)
      ..writeByte(1)
      ..write(obj.strMeal)
      ..writeByte(2)
      ..write(obj.strMealThumb)
      ..writeByte(3)
      ..write(obj.strInstructions)
      ..writeByte(4)
      ..write(obj.strYoutube)
      ..writeByte(5)
      ..write(obj.strCategory)
      ..writeByte(6)
      ..write(obj.strArea)
      ..writeByte(7)
      ..write(obj.strCountry)
      ..writeByte(8)
      ..write(obj.strIngredient)
      ..writeByte(9)
      ..write(obj.strMeasure);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
