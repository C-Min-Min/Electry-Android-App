import 'package:flutter/material.dart';

enum TabItem { Home, Devices, History, Notifications, Settings}

Map<TabItem, String> tabName = {
  TabItem.Home: 'red',
  TabItem.Devices: 'green',
  TabItem.History: 'blue',
  TabItem.Notifications: 'blue',
  TabItem.Settings: 'blue',
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.Home: Colors.red,
  TabItem.Devices: Colors.green,
  TabItem.History: Colors.blue,
  TabItem.Notifications: Colors.blue,
  TabItem.Settings: Colors.blue,
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.Home),
        _buildItem(tabItem: TabItem.Devices),
        _buildItem(tabItem: TabItem.History),
        _buildItem(tabItem: TabItem.Notifications),
        _buildItem(tabItem: TabItem.Settings),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData icon = Icons.layers;
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}