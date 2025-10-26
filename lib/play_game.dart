import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'item_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ItemModel> item1 = [];
  List<ItemModel> item2 = [];
  late int score;
  bool gameover = false;
  initGame() {
    gameover = false;
    score = 0;
    item1 = [
      ItemModel(value: 'Lion', name: 'Lion', img: 'assets/images/Stylized-Cartoon-Lion.svg'),
      ItemModel(
        value: 'panda',
        name: 'panda',
        img: 'assets/images/image-from-rawpixel-id-6483614-svg.svg',
      ),
      ItemModel(
        value: 'camel',
        name: 'camel',
        img: 'assets/images/camal.jpg',
      ),
      ItemModel(
        value: 'dog',
        name: 'dog',
        img: 'assets/images/dog.jpg',
      ),
      ItemModel(
        value: 'cat',
        name: 'cat',
        img: 'assets/images/cat.jpg',
      ),
      ItemModel(
        value: 'horse',
        name: 'horse',
        img: 'assets/images/horse.jpg',
      ),
      ItemModel(
        value: 'sheep',
        name: 'sheep',
        img: 'assets/images/sheep.jpg',
      ),
      ItemModel(
        value: 'fox',
        name: 'fox',
        img: 'assets/images/fox.jpg',
      ),
      ItemModel(
        value: 'cow',
        name: 'cow',
        img: 'assets/images/cow.jpg',
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
                    SizedBox(width: 180,),
        
                    Text('Score:',),
                    SizedBox(width: 10,),
                    Text(
                      '$score',
                      style: TextStyle(fontSize: 30,color: Colors.teal),
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
                                  child: SvgPicture.asset(
        
                                    item.img,
        
                                  ),
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                ),
                                data: item,
                                childWhenDragging: CircleAvatar(
                                  child: SvgPicture.asset(
        
                                    item.img,
        
                                  ),
                                  backgroundColor: Colors.white,
        
                                  radius: 20,
                                ),
                                child:CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 30,
                                  child: SvgPicture.asset(
                                    cacheColorFilter: true,
                                     item.img,
        
                                  ),
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
                                List<dynamic> accepted, List<dynamic> rejected) {
                              return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          item.accept ? Colors.grey[200] : Colors.grey[300]),
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.width /8,
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: EdgeInsets.all(8),
                                  child: Text(
                                    item.name,
                                    style: Theme.of(context).textTheme.titleLarge,
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
                        child: Text('Game over',style: TextStyle(color:Colors.red ),),
                      ),
                    ),
        
                    Text(
                      result(),
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: Colors.grey[500], // This sets the text color to gray
                      ),
                    ),
                    SizedBox(height: 20,),
        
        
                  ],
                ),
              ),
              if (gameover)
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        initGame();
                      });
                    },
                    child: Text('New Game')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String result() {
    if (score == 100) {
      return 'Awesome';
    } else {
      return 'Play Again to get better Score';
    }
  }
}
