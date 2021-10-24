import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Device_build.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/custom_tab_bar.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomAppBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 65,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF080808) : Colors.white,
        boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 4,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Electry',
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: Responsive.isDesktop(context) ? 1000 : Responsive.isTablet(context) ? 800 : 400,
            child: CustomTabBar(
              icons: icons,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              
            ),
          )
        ],
      ),
    );
  }
}
