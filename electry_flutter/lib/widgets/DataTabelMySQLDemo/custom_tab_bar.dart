import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;

  const CustomTabBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
    this.isBottomIndicator = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator ? Border(
          bottom: BorderSide(
            color: Colors.blueAccent,
            width: 3.0,
          ),
        ):  Border(
          top: BorderSide(
            color: Colors.blueAccent,
            width: 3.0,
          ),
        ), 
      ),
      tabs: icons.asMap()
          .map(
            (i, e) => MapEntry(i, Tab(
              icon: Icon(
                e,
                color: i==selectedIndex ? Colors.blueAccent : isDarkMode ? Colors.white54 : Colors.black45,
                size: 30,
              ),
            ),
          )).values
          .toList(),
      onTap: onTap,
    );
  }
}