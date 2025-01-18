import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/pages/premium_page.dart';
import 'package:notelist_v3/pages/settings_page.dart';
import 'package:provider/provider.dart';

class PremiumButton extends StatefulWidget {


  PremiumButton({
    super.key

  });

  @override
  _PremiumButtonState createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> with TickerProviderStateMixin {
  late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);


  late AnimationController _controller;

  late Animation<double> _iconAnimation;
  late AnimationController _animationController;





  @override
  void initState(){
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumPage(),));

    });
    noteDatabase.updateDatabase();

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: _toggleSwitch,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55.0),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: AnimatedBuilder(
                animation: _iconAnimation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Lottie.asset(
                          height: 35,
                          'assets/premium_button.json',
                          frameRate: FrameRate(25),
                          controller: _animationController,
                          onLoaded: (composition) {
                            _animationController.duration = composition.duration;
                            _animationController.forward();
                          },

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
    );
  }


}
