
import 'package:flutter/material.dart';

class FlatButtonNavBar extends StatefulWidget {
  final int index;
  final int currentIndex;



  const FlatButtonNavBar({Key? key, required this.index,  required this.currentIndex, })
      : super(key: key);

  @override
  State<FlatButtonNavBar> createState() => _FlatButtonNavBarState();
}

class _FlatButtonNavBarState extends State<FlatButtonNavBar>
{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.pinkAccent,
          child: Icon(Icons.headphones,color: Colors.white,),
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
