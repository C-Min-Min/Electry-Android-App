import 'package:electry_flutter/widgets/DataTabelMySQLDemo/tab_navigator.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Devices", "History", "Notifications","Settings"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home" : GlobalKey<NavigatorState>(),
    "Devices" : GlobalKey<NavigatorState>(),
    "History" : GlobalKey<NavigatorState>(),
    "Notifications" : GlobalKey<NavigatorState>(),
    "Settings" : GlobalKey<NavigatorState>(),
  };
  
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = 
          !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 1);

            return false;
          }
        }

        return isFirstRouteInCurrentTab;
      },

        child: Scaffold(
          body: Stack(
            children:<Widget> [
              _buildOffstageNavigator("Home"),
              _buildOffstageNavigator("Devices"),
              _buildOffstageNavigator("Settings")
            ],
          ),
          bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), 
            topLeft: Radius.circular(20)
            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: new BottomNavigationBar(
              unselectedItemColor: Colors.black54,
              selectedItemColor: Colors.black,
              showUnselectedLabels: true,
              items: [
                new BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.grey[200],
                ),

                new BottomNavigationBarItem(
                  icon: const Icon(Icons.devices),
                  label: 'Devices',
                  backgroundColor: Colors.grey[200],
                ),

                new BottomNavigationBarItem(
                  icon: const Icon(Icons.history),
                  label: 'History',
                ),

                new BottomNavigationBarItem(
                  icon: const Icon(Icons.notifications),
                  label: 'Notifications',
                ),

                new BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: 'Settings',
                )
              ],
              currentIndex: _selectedIndex,
              onTap: (int index) { _selectTab(pageKeys[index], index); },
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
        ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  
}