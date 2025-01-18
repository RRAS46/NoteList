import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:notelist_v3/databases/note_database.dart';
import 'package:notelist_v3/pages/notes_page.dart';
import 'package:provider/provider.dart';


class CutsomCarouselWidget extends StatefulWidget {
  double height;
  double margin;
  Axis axisDirection;

  BoxDecoration decoration;
  TextStyle textStyle;

  List itemList;

  CutsomCarouselWidget({super.key,required this.height,this.margin=0,required this.itemList,this.axisDirection=Axis.horizontal,BoxDecoration? decoration,TextStyle? textStyle}): decoration = decoration ?? BoxDecoration(color: Colors.white), textStyle = textStyle ?? TextStyle();

  @override
  State<CutsomCarouselWidget> createState() => _CutsomCarouselWidgetState();
}

class _CutsomCarouselWidgetState extends State<CutsomCarouselWidget> {
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        late NoteDatabase noteDatabase=Provider.of<NoteDatabase>(context, listen: false);

        setState(() {
          noteDatabase.currentCategoryList=_currentIndex;
          noteDatabase.updateDatabase();
        });
        Navigator.push(context,MaterialPageRoute(builder: (context) => NotesPage(isLocked: false,),));
      },
      child: Container(
        child: Column(
          children: [
            CarouselSlider(
                items: widget.itemList.map((item) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: widget.margin),
                    decoration: widget.decoration,
                    child: Center(child: Text(item.toString(),style: widget.textStyle,)),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: widget.height,
                  animateToClosest: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  scrollDirection: widget.axisDirection,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },

                )
            ),
            SizedBox(height: 16),
            buildBullets(),
          ],
        ),

      ),
    );
  }


  Widget buildBullets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.itemList.length, (index) {
        return buildBullet(index);
      }),
    );
  }

  Widget buildBullet(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width:  _currentIndex == index ? 15 : 8,
        height: _currentIndex == index ? 15 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}



class PremiumCustomCarousel extends StatefulWidget {
  double height;
  double margin;
  Axis axisDirection;

  BoxDecoration decoration;
  TextStyle textStyle;

  List itemList;

  PremiumCustomCarousel({super.key,required this.height,this.margin=0,required this.itemList,this.axisDirection=Axis.horizontal,BoxDecoration? decoration,TextStyle? textStyle}): decoration = decoration ?? BoxDecoration(color: Colors.white), textStyle = textStyle ?? TextStyle();


  @override
  State<PremiumCustomCarousel> createState() => _PremiumCustomCarouselState();
}

class _PremiumCustomCarouselState extends State<PremiumCustomCarousel> {
  int _currentIndex=0;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
              items: widget.itemList.map((item) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: widget.margin),
                  decoration: widget.decoration,
                  child: Center(child: Text(item.toString(),style: widget.textStyle,)),
                );
              }).toList(),
              options: CarouselOptions(
                height: widget.height,
                animateToClosest: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                scrollDirection: widget.axisDirection,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },

              )
          ),
          SizedBox(height: 16),
          buildBullets(),
        ],
      ),

    );
  }


  Widget buildBullets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.itemList.length, (index) {
        return buildBullet(index);
      }),
    );
  }

  Widget buildBullet(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width:  _currentIndex == index ? 15 : 8,
        height: _currentIndex == index ? 15 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}

class PremiumCustomCard extends StatelessWidget {
  List<dynamic> firstCard;
  List<List<dynamic>> secondCard;
  
  PremiumCustomCard({
    super.key,
    List<dynamic>? firstCard,
    List<List<dynamic>>? secondCard,
  }) : firstCard= firstCard ?? List.generate(3, (index) => ""),secondCard = secondCard ?? List.generate(3, (index) {
    IconData iconData = Icons.circle_outlined; // You can change the icon as needed
    Icon icon = Icon(iconData);
    String text = "";
    return [icon, text];
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Center(
              child: Column(
                children: [
                  Text(firstCard[0]),
                  Text(firstCard[1]),
                  Text(firstCard[2])
                ],
              ),
            ),
          ),
          ListView(
            children: [
              ListTile(
                leading: Icon(secondCard[0][0]),
                title: Text(secondCard[0][1]),
              ),
              ListTile(
                leading: Icon(secondCard[1][0]),
                title: Text(secondCard[1][1]),
              ),
              ListTile(
                leading: Icon(secondCard[2][0]),
                title: Text(secondCard[2][1]),
              ),
            ],
          ),
          MaterialButton(
            onPressed: (){},

          ),
        ],
      ),
    );
  }

}

