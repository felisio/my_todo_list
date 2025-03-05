import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum Category { personal, work, shopping, other }

const categoryIcons = {
  Category.personal: Icons.person,
  Category.work: Icons.work,
  Category.shopping: Icons.shopping_cart,
  Category.other: Icons.more_horiz,
};

final categoryColors = {
  Category.personal: const Color.fromARGB(255, 150, 193, 228),
  Category.work: const Color.fromARGB(255, 147, 203, 149),
  Category.shopping: const Color.fromARGB(255, 195, 130, 206),
  Category.other: const Color.fromARGB(255, 221, 179, 116),
};

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2;

  @override
  Category read(BinaryReader reader) {
    final index = reader.readInt();
    return Category.values[index];
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeInt(obj.index);
  }
}
