import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogModel {
  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);
  Item getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Item {
  late final int id;
  late final String name;
  late final Color color;
  late final int price = 42;

  Item(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id; //=>はreturnと同じ意味を持つ
  @override
  bool operator ==(Object other) =>
      other is Item && other.id == id; //おそらく全ての条件を満たしている時Trueが返される
}
