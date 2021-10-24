import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Device_info_layout.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Devices_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Device.dart';
import 'Services.dart';

class Settings_layout extends StatefulWidget{
  Settings_layout() : super();
  @override
  Settings_layout_State createState() => Settings_layout_State();
}

class Settings_layout_State extends State<Settings_layout>{
  GlobalKey<ScaffoldState> _scaffoldKey;
  int _selected_Index = 0;
  final db_ip_controller = TextEditingController();
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
    if(_selected_Index == 1){
      Navigator.push(context, 
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          fullscreenDialog: true,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child){
            
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
            return Device_layout();
          }
          )

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SingleChildScrollView(
      child: Column(
        children: [
          new Container(
            alignment: Alignment.topLeft,
            child: Padding(
              child:
                new Text(
                  "Settings",
                    style: new TextStyle(fontSize:50.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto"),
                ),
              padding: const EdgeInsets.only(top: 35.0, left: 20),
            ),
          ),
        ],
        
      ),
        
      
      ),
      
      );
        
  }
}