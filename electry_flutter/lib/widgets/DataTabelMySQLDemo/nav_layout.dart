import 'package:electry_flutter/widgets/DataTabelMySQLDemo/custom_app_bar.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/custom_tab_bar.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/layouts.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/responsive.dart';
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
    var screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length:_icons.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if(!tabController.indexIsChanging){
              setState(() => _selectedIndex = tabController.index);
            }
          });
          return Scaffold(
            appBar: Responsive.isDesktop(context) || Responsive.isTabletLandscape(context) || Responsive .isMobileLandscape(context)
            ? PreferredSize(
                preferredSize: Size(screenWidth, 100),
                child: CustomAppBar(
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                    onTap: (index) => setState(() => _selectedIndex = index),
                ),
              ) 
              : null,
            body: TabBarView(
              physics: Responsive.isDesktop(context) ? NeverScrollableScrollPhysics() : null,
              children: _screens,
            ),
            bottomNavigationBar: Responsive.isTabletPortrait(context) || Responsive.isMobilePortrait(context) ? Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CustomTabBar (
                icons: _icons,
                selectedIndex: _selectedIndex,
                onTap: (index) => setState(() => _selectedIndex = index),
              ),
            ) : const SizedBox.shrink()
          );
        }
      ),  
    );
  }
}