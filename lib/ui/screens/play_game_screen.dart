import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kids_learn_app/utils/app_strings.dart';
import 'package:kids_learn_app/utils/themes/app_colors.dart';

import '../../models/item_model.dart';
import '../../utils/app_assets.dart';

class playGameScreen extends StatefulWidget {
  const playGameScreen({super.key});

  @override
  State<playGameScreen> createState() => _playGameScreenState();
}

class _playGameScreenState extends State<playGameScreen> {
  List<ItemModel> item1 = [];
  List<ItemModel> item2 = [];
  late int score;
  bool gameover = false;

  initGame() {
    gameover = false;
    score = 0;
    item1 = [
      ItemModel(value: AppStrings.lionAnimal, name: AppStrings.lionAnimal, img: AppAssets.lionImage),
      ItemModel(
        value: AppStrings.pandaAnimal,
        name: AppStrings.pandaAnimal,
        img: AppAssets.pandaImage,
      ),
      ItemModel(
        value: AppStrings.camelAnimal,
        name: AppStrings.camelAnimal,
        img:  AppAssets.camelImage,
      ),
      ItemModel(
        value: AppStrings.dogAnimal,
        name: AppStrings.dogAnimal,
        img: AppAssets.dogImage,
      ),
      ItemModel(
        value:AppStrings.catAnimal,
        name: AppStrings.catAnimal,
        img: AppAssets.catImage,
      ),
      ItemModel(
        value:AppStrings.horseAnimal,
        name: AppStrings.horseAnimal,
        img: AppAssets.horseImage,
      ),
      ItemModel(
        value: AppStrings.sheepAnimal,
        name: AppStrings.sheepAnimal,
        img: AppAssets.sheepImage,
      ),
      ItemModel(
        value: AppStrings.foxAnimal,
        name:  AppStrings.foxAnimal,
        img:  AppAssets.foxImage,
      ),
      ItemModel(
        value: AppStrings.cowAnimal,
        name: AppStrings.cowAnimal,
        img: AppAssets.cowImage,
      ),
      ItemModel(
        value: AppStrings.henAnimal,
        name: AppStrings.henAnimal,
        img:AppAssets.henImage,
      ),
    ];
    item2 = List<ItemModel>.from(item1);
    // عرض بشكل عشوائى
    item1.shuffle();
    item2.shuffle();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (item1.length == 0) gameover = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    SizedBox(
                      width: 140,
                    ),
                    Text(
                      AppStrings.scoreText,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$score',
                      style: TextStyle(fontSize: 30, color: AppColors.pinkColor),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Column(
                    children: item1
                        .map((item) => Container(
                              margin: EdgeInsets.all(8),
                              child: Draggable<ItemModel>(
                                feedback: CircleAvatar(
                                  // child: SvgPicture.asset(
                                  //
                                  //   item.img,
                                  //
                                  // ),
                                  backgroundImage: AssetImage(
                                    item.img,
                                  ),

                                  backgroundColor: Colors.white,
                                  radius: 20,
                                ),
                                data: item,
                                childWhenDragging: CircleAvatar(
                                  // child: SvgPicture.asset(
                                  //
                                  //   item.img,
                                  //
                                  // ),
                                  backgroundImage: AssetImage(
                                    item.img,
                                  ),
                                  backgroundColor: Colors.red,

                                  radius: 20,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                    item.img,
                                  ),
                                  // child: SvgPicture.asset(
                                  //   cacheColorFilter: true,
                                  //    item.img,
                                  //
                                  // ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Spacer(flex: 2),
                  Column(
                    children: item2
                        .map(
                          (item) => DragTarget<ItemModel>(
                            builder: (BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected) {
                              return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: item.accept
                                          ? Colors.grey[200]
                                          : Colors.grey[300]),
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.width / 8,
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: EdgeInsets.all(8),
                                  child: Text(
                                    item.name,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    // Text, Container,
                                  ));
                            },
                            onAcceptWithDetails: (re) {
                              if (item.value == re.data.value) {
                                setState(() {
                                  item1.remove(re.data);
                                  item2.remove(re.data);
                                });
                                score += 10;
                                item.accept = false;
                              } else {
                                setState(() {
                                  score -= 5;
                                  item.accept = false;
                                });
                              }
                            },
                            onWillAcceptWithDetails: (re) {
                              setState(() {
                                item.accept = true;
                              });
                              return true;
                            },
                            onLeave: (re) {
                              setState(() {
                                item.accept = false;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  //

                  //
                ],
              ),
              if (gameover)
                Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppStrings.gameOverText,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      Text(
                        result(),
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: Colors.grey[
                                  500], // This sets the text color to gray
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              if (gameover)
                Center(
                  child: ElevatedButton(
                      // style: ButtonStyle(
                      //     backgroundColor:
                      //         MaterialStatePropertyAll(Colors.white)
                      // ),
                      onPressed: () {
                        setState(() {
                          initGame();
                        });
                      },
                      child: Text(
                        AppStrings.newGameText,
                        style: TextStyle(
                          color:AppColors.white,
                        ),
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String result() {
    if (score == 100) {
      return AppStrings.awesomeText;
    } else {
      return AppStrings.playAgaintogetbetterScoreText;
    }
  }
}
