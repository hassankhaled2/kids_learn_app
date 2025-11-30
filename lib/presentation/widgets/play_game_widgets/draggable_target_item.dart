// lib/screens/play_game/widgets/drag_target_item.dart

import 'package:flutter/material.dart';
import '../../../../models/item_model.dart';

const double _kItemMargin = 8.0;

class DragTargetItem extends StatefulWidget {
  final ItemModel targetItem;
  final void Function(ItemModel droppedItem, ItemModel targetItem) onMatchAccepted;
  final VoidCallback onMatchRejected;

  const DragTargetItem({
    super.key,
    required this.targetItem,
    required this.onMatchAccepted,
    required this.onMatchRejected,
  });

  @override
  State<DragTargetItem> createState() => _DragTargetItemState();
}

class _DragTargetItemState extends State<DragTargetItem> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<ItemModel>(
      builder: (BuildContext context, List<ItemModel?> accepted,
          List<dynamic> rejected) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.targetItem.accept
                ? Colors.amber.shade200 // Color when hovering
                : Colors.grey.shade300,
          ),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.width / 8,
          width: MediaQuery.of(context).size.width / 2,
          margin: const EdgeInsets.all(_kItemMargin),
          child: Text(
            widget.targetItem.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
      onWillAcceptWithDetails: (details) {
        // Set visual state to 'ready to accept'
        setState(() {
          widget.targetItem.accept = true;
        });
        return true;
      },
      onAcceptWithDetails: (details) {
        // Check if the dropped item's value matches the target's value
        if (widget.targetItem.value == details.data.value) {
          widget.onMatchAccepted(details.data, widget.targetItem);
        } else {
          widget.onMatchRejected();
        }
        // Reset the 'accept' visual state after a drop
        setState(() {
          widget.targetItem.accept = false;
        });
      },
      onLeave: (data) {
        // Reset visual state
        setState(() {
          widget.targetItem.accept = false;
        });
      },
    );
  }
}