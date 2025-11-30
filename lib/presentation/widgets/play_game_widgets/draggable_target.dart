
import 'package:flutter/material.dart';
import '../../../../models/item_model.dart';
import 'draggable_target_item.dart';


class DragTargetColumn extends StatelessWidget {
  final List<ItemModel> targets;
  final void Function(ItemModel droppedItem, ItemModel targetItem) onMatchAccepted;
  final VoidCallback onMatchRejected;

  const DragTargetColumn({
    super.key,
    required this.targets,
    required this.onMatchAccepted,
    required this.onMatchRejected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: targets
          .map(
            (item) => DragTargetItem(
          targetItem: item,
          onMatchAccepted: onMatchAccepted,
          onMatchRejected: onMatchRejected,
        ),
      )
          .toList(),
    );
  }
}