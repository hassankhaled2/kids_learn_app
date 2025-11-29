


import 'package:flutter/material.dart';
import 'package:kids_learn_app/core/spacing.dart';

import '../../core/app_assets.dart';
import '../../core/app_strings.dart';
import '../../models/item_model.dart';
import '../widgets/play_game_widgets/draggable_board.dart';
import '../widgets/play_game_widgets/draggable_target.dart';
import '../widgets/play_game_widgets/game_over_overlay.dart';
import '../widgets/play_game_widgets/score board.dart';

class PlayGameScreen extends StatefulWidget {
  const PlayGameScreen({super.key});

  @override
  State<PlayGameScreen> createState() => _PlayGameScreenState();
}

class _PlayGameScreenState extends State<PlayGameScreen> {
  List<ItemModel> _imageItems = [];
  List<ItemModel> _textTargets = [];
  int _score = 0;

  bool get _isGameOver => _imageItems.isEmpty;

  @override
  void initState() {
    super.initState();
    _initGame();
  }


  void _initGame() {
    final List<ItemModel> masterItems = [
      ItemModel(value: AppStrings.lionAnimal, name: AppStrings.lionAnimal, img: AppAssets.lionImage),
      ItemModel(value: AppStrings.pandaAnimal, name: AppStrings.pandaAnimal, img: AppAssets.pandaImage),
      ItemModel(value: AppStrings.camelAnimal, name: AppStrings.camelAnimal, img: AppAssets.camelImage),
      ItemModel(value: AppStrings.dogAnimal, name: AppStrings.dogAnimal, img: AppAssets.dogImage),
      ItemModel(value: AppStrings.catAnimal, name: AppStrings.catAnimal, img: AppAssets.catImage),
      ItemModel(value: AppStrings.horseAnimal, name: AppStrings.horseAnimal, img: AppAssets.horseImage),
      ItemModel(value: AppStrings.sheepAnimal, name: AppStrings.sheepAnimal, img: AppAssets.sheepImage),
      ItemModel(value: AppStrings.foxAnimal, name: AppStrings.foxAnimal, img: AppAssets.foxImage),
      ItemModel(value: AppStrings.cowAnimal, name: AppStrings.cowAnimal, img: AppAssets.cowImage),
      ItemModel(value: AppStrings.henAnimal, name: AppStrings.henAnimal, img: AppAssets.henImage),
    ];

    setState(() {
      _score = 0;
      // Deep copy and shuffle for randomization
      _imageItems = List<ItemModel>.from(masterItems)..shuffle();
      _textTargets = List<ItemModel>.from(masterItems)..shuffle();
    });
  }

  void _onMatchAccepted(ItemModel droppedItem, ItemModel targetItem) {
    setState(() {
      _imageItems.remove(droppedItem);
      _textTargets.remove(targetItem);
      _score += 10;
    });
  }

  void _onMatchRejected() {
    setState(() {
      _score = _score > 0 ? _score - 5 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Scoreboard(score: _score),
              Row(
                children: [
                  horizontalSpace(10),
                  Expanded(
                    flex: 1,
                    child: DraggableColumn(items: _imageItems),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: DragTargetColumn(
                      targets: _textTargets,
                      onMatchAccepted: _onMatchAccepted,
                      onMatchRejected: _onMatchRejected,
                    ),
                  ),
                ],
              ),
              if (_isGameOver)
                GameOverOverlay(
                  score: _score,
                  onRestartGame: _initGame,
                ),
            ],
          ),
        ),
      ),
    );
  }
}