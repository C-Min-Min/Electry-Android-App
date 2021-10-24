import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Devices_layout.dart';
import 'package:flutter/material.dart';
import 'Home_layout.dart';

class DataTableDemo extends StatefulWidget{
  DataTableDemo() : super();
  @override
  DataTableDemoState createState() => DataTableDemoState(); 
}

class DataTableDemoState extends State<DataTableDemo>{
  GlobalKey<ScaffoldState> _scaffoldKey;
  int _selected_Index = 0;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
  }

  void onItemTapped(int index){
    setState(() {
      _selected_Index = index;
      print(index);
    });
    _page_layout();
  }

  void _page_layout(){
    if(_selected_Index == 0){
      print("assss");
      Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>Home_layout())
      );
    }else if(_selected_Index == 1){
      Device_screen();
    }
  }

  void Device_screen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Device_layout(),
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
              currentIndex: _selected_Index,
              onTap: onItemTapped,

            ),
          ),
        ),
        );
      })
    );
  }

  void Home_screen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Home_layout(),
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
              currentIndex: _selected_Index,
              onTap: onItemTapped,

            ),
          ),
        ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      body: Home_layout(),
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
              currentIndex: _selected_Index,
              onTap: onItemTapped,

            ),
          ),
        ),
      );
  }

  
   
}