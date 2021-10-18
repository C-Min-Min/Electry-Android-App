import 'package:electry_flutter/widgets/DataTabelMySQLDemo/custom_tab_bar.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/layouts.dart';
import 'package:flutter/material.dart';

class NavLayout extends StatefulWidget {
  @override
  _NavLayoutState createState() => _NavLayoutState();
}

class _NavLayoutState extends State<NavLayout> {
  final List<Widget> _screens = [
    Home_layout(),
    Device_layout(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final List<IconData> _icons = [
    Icons.home,
    Icons.devices,
    Icons.history,
    Icons.notifications,
    Icons.settings
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length:_icons.length,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CustomTabBar (
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),  
    );
  }
}