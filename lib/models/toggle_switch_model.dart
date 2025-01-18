import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:provider/provider.dart';

class CustomToggleSwitch extends StatefulWidget {
  double boxHeight;
  double boxWidth;
  double buttonHeight;
  double buttonWidth;


    CustomToggleSwitch({
    required this.boxHeight,
    required this.boxWidth,
    required this.buttonHeight,
    required this.buttonWidth,
  });

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> with TickerProviderStateMixin {
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);
  

  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;

  late Animation<double> _iconAnimation;
  late AnimationController _animationController;
  late Alignment position;
  late Alignment reach;





  @override
  void initState(){
    position=Alignment.centerLeft;
    reach=Alignment.centerRight;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _alignmentAnimation = Tween<Alignment>(
      begin: position,
      end: reach,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _iconAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _animationController=AnimationController(vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });
    _controller.addListener(() {
      setState(() {});
    });
    if (noteDatabase.allColors[noteDatabase.themeColor][3]) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose(); // Add this line to properly dispose the animation controller
    super.dispose();
  }

  void _toggleSwitch() {
    setState(() {

      if(noteDatabase.themeColor==0){
        noteDatabase.themeColor=1;

      }else if(noteDatabase.themeColor==1){
        noteDatabase.themeColor=0;
      }

      if (noteDatabase.allColors[noteDatabase.themeColor][3]) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    noteDatabase.updateDatabase();

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
          onTap: _toggleSwitch,
          child: Center(
            child: Container(
              width: widget.boxWidth,
              height: widget.boxHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,

                  colors: !noteDatabase.allColors[noteDatabase.themeColor][3]?[Colors.yellow,Colors.blue]:[Colors.black, Colors.grey],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: AnimatedBuilder(
                  animation: _alignmentAnimation,
                  builder: (context, child) {
                    return Align(
                      alignment: _alignmentAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: widget.buttonWidth,
                    height: widget.buttonHeight,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: AnimatedBuilder(
                      animation: _iconAnimation,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: noteDatabase.allColors[noteDatabase.themeColor][3] ? 0.0 : 1.0,
                              duration: Duration(milliseconds: 500),
                              child: Lottie.asset(
                                'assets/cloudy-sun.json',
                                frameRate: FrameRate(25),
                                controller: _animationController,
                                onLoaded: (composition) {
                                  _animationController.duration = composition.duration;
                                  _animationController.forward();
                                  noteDatabase.updateDatabase();
                                },

                                fit: BoxFit.fill,
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: noteDatabase.allColors[noteDatabase.themeColor][3] ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 500),
                              child: Lottie.asset(
                                'assets/moon.json',
                                frameRate: FrameRate(25),
                                controller: _animationController,
                                onLoaded: (composition) {
                                  _animationController.duration = composition.duration;
                                  _animationController.forward();
                                  noteDatabase.updateDatabase();
                                },

                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }


}
