
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicappapp/nav_bar/flat_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavigationItem extends StatefulWidget {
  final Function(int tab) changeCurrentTab;
  final int index;
  final int currentIndex;
  final IconData unSelectedIconData;
  final IconData iconDataSelected;

  const BottomNavigationItem({
    super.key,

    required this.changeCurrentTab,
    required this.index,
    required this.currentIndex, required this.unSelectedIconData, required this.iconDataSelected,
  });

  @override
  State<BottomNavigationItem> createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends State<BottomNavigationItem> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 60.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              widget.changeCurrentTab(widget.currentIndex);

            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 1,
                  child: Icon(
                    widget.currentIndex == widget.index
                        ? widget.iconDataSelected
                        : widget.unSelectedIconData,
                    color: widget.currentIndex == widget.index
                        ? Colors.pinkAccent
                        : Colors.white),
                ),
              const SizedBox(height: 4,),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.linear,
                width: 20,
                height: 3,
                decoration: BoxDecoration(
                  color: widget.currentIndex == widget.index
                      ? Colors.pinkAccent
                      : Colors.transparent
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> changeIndex;
  final int index;

  const BottomNavBar({Key? key, required this.changeIndex, required this.index})
      : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Color(0xff4C5F96)),
        ),
      ),
      child: BottomAppBar(
          color: const Color(0xff1A2545),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                BottomNavigationItem(
                  iconDataSelected : Icons.home,
                  unSelectedIconData:Icons.home_outlined,
                  changeCurrentTab: widget.changeIndex,
                  index: widget.index,
                  currentIndex: 0,
                ),
                BottomNavigationItem(
                  iconDataSelected : Icons.search,
                  unSelectedIconData:Icons.search,
                  changeCurrentTab: widget.changeIndex,
                  index: widget.index,
                  currentIndex: 1,
                ),
                Expanded(child: FlatButtonNavBar( currentIndex: 2, index: widget.index, )),
                BottomNavigationItem(
                    iconDataSelected : Icons.settings_input_antenna,
                    unSelectedIconData:Icons.settings_input_antenna_outlined,
                    changeCurrentTab: widget.changeIndex,
                    index: widget.index,
                    currentIndex: 3),
                BottomNavigationItem(
                  iconDataSelected : Icons.settings,
                  unSelectedIconData:Icons.settings,
                  changeCurrentTab: widget.changeIndex,
                  index: widget.index,
                  currentIndex: 4,
                ),
              ],
            ),
          )),
    );
  }
}
