// lib/screens/play_game/widgets/draggable_item.dart

import 'package:flutter/material.dart';
import '../../../../models/item_model.dart';

const double _kAvatarRadius = 30.0;
const double _kFeedbackRadius = 20.0;
const double _kItemMargin = 8.0;

class DraggableItem extends StatelessWidget {
  final ItemModel item;
  const DraggableItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(_kItemMargin),
      child: Draggable<ItemModel>(
        data: item,

        feedback: CircleAvatar(
          backgroundImage: AssetImage(item.img),
          backgroundColor: Colors.white,
          radius: _kFeedbackRadius,
        ),
        // The widget shown in place of the original while dragging
        childWhenDragging: CircleAvatar(
          backgroundImage: AssetImage(item.img),
          backgroundColor: Colors.red.withOpacity(0.5),
          radius: 20,
        ),
        // The original widget
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: _kAvatarRadius,
          backgroundImage: AssetImage(item.img),
        ),
      ),
    );
  }
}