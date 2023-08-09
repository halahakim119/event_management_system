import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 1; // Unique identifier for this TypeAdapter

  @override
ThemeMode read(BinaryReader reader) {
  try {
    final index = reader.readInt();
    return ThemeMode.values[index];
  } catch (e) {
  
    return ThemeMode.light;
  }
}


  @override
  void write(BinaryWriter writer, ThemeMode obj) {
     // Write the index of the ThemeMode value to the binary data
    final index = obj.index;
    writer.writeInt(index);
  }
}
