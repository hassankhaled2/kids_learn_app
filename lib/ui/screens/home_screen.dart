import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_learn_app/ui/screens/object_detection_screen.dart';
import 'package:kids_learn_app/ui/screens/play_game_screen.dart';
import 'package:kids_learn_app/utils/spacing.dart';
import 'package:kids_learn_app/utils/themes/app_colors.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/defualt_app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin{
  bool showMore = false;
  late AnimationController _controller;
  late Animation<double> expandAnimation;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() {
      showMore ? _controller.reverse() : _controller.forward();
      showMore = !showMore;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        // appBar: getDefaultAppBarWidget(centerTitle: null, context: null, title: '', color: null, backgroundColor: null, fontWeight: null),
        // appBar: AppBar(title: Text('Kids learn App',style: TextStyle(color: AppColors.white54Color,fontWeight: FontWeight.w100),),elevation: 20,centerTitle: true,),
        appBar:       getDefaultAppBarWidget(centerTitle: true, context: context, title: 'Kids learn App', color: AppColors.white54Color, fontWeight: FontWeight.w100),

          body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              verticalSpace(50),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.pink,
                        blurRadius: 5,
                        offset: Offset(0,4)
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Text(

                        '🚀  Welcome, Little Explorer! 🚀',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(height: 10),
                      const Icon(
                        Icons.pets,
                        size: 50,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(height: 15),
                      const Text(
                        'It’s time to explore something exciting!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              verticalSpace(50),

              customElevatedButton(text: showMore ? "Animals" : "Animals", onPressed: toggleMenu
              ),
              SizeTransition(
                sizeFactor: expandAnimation, axisAlignment: -1,

                child: showMore
                    ? Column(
                  key: const ValueKey('options'),
                  children: [
                    verticalSpace(8),
                    customElevatedButton(
                      text: "Play",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => playGameScreen(),
                          ),
                        );
                      },
                      maxHeight: 60,
                      minWidth: 200,
                    ),
                    verticalSpace(8),
                    customElevatedButton(
                      text: "Clarify Animal",
                      onPressed: ()
                      {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ObjectDetectionScreen(),
                          ),
                        );
                      },
                      maxHeight: 60,
                      minWidth: 150,
                    ),
                  ],
                )
                    : const SizedBox.shrink(), // empty widget when false
              ),
              verticalSpace(8),
              //
              // customElevatedButton(text: "Number", onPressed: ()
              // {      setState(() {
              //
              // });
              // },),
              // verticalSpace(8),
              // customElevatedButton(text:  "Colors", onPressed: ()
              // {      setState(() {
              //
              // });
              // },),
              // verticalSpace(8),
              // customElevatedButton(text:  "A-Z", onPressed: ()
              // {      setState(() {
              //
              // });
              //
              // },),
              // verticalSpace(8),

            ],
          ),
        ),
    )
    );



  }
}
