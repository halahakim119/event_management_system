import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 1; // Unique identifier for this TypeAdapter

  @override
  ThemeMode read(BinaryReader reader) {
    // Read the integer value from the binary data and convert it back to ThemeMode
    final index = reader.readInt();
    return ThemeMode.values[index];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    // Convert ThemeMode to an integer and write it to the binary data
    writer.writeInt(obj.index);
  }
}
