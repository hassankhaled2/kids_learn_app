// lib/screens/play_game/widgets/draggable_column.dart

import 'package:flutter/material.dart';
import '../../../../models/item_model.dart';
import 'draggable_item.dart';

class DraggableColumn extends StatelessWidget {
  final List<ItemModel> items;
  const DraggableColumn({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: items.map((item) => DraggableItem(item: item)).toList(),
    );
  }
}