import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Device_build.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Device_info_layout.dart';
import 'package:flutter/material.dart';
import 'Device.dart';
import 'Home_layout.dart';
import 'Services.dart';

class Device_layout extends StatefulWidget{
  Device_layout() : super();
  @override
  Device_layout_State createState() => Device_layout_State();
}

class Device_layout_State extends State<Device_layout>{
  List<Device> _devices;
  GlobalKey<ScaffoldState> _scaffoldKey;
  int _selected_Index = 1;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _devices = [];
    _getDevices();
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
      Navigator.push(context, 
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          fullscreenDialog: true,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child){
            
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
            return Home_layout();
          }
          )

      );
    }
  }

  _getDevices(){
    Services.getDevices().then((devices){
      setState(() {
        _devices = devices;

      });
      print("Length ${devices.length}");
    });
  }
  Future<Null> refresh() async {
    await _getDevices();
    return null;
  }

  int device_per_row = 1;
  @override
  Widget build(BuildContext context) {
    for(int i = 0; i < 5;i++){
      if(MediaQuery.of(context).size.width > ((device_per_row + 1) * 160) + (20 * (device_per_row + 1))){
        device_per_row++;
      }
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              new Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  child:
                    new Text(
                      "Devices",
                        style: new TextStyle(fontSize:50.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto"),
                    ),
                  padding: const EdgeInsets.only(top: 35.0, left: 20, bottom: 20),
                ),
              ),
              GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: device_per_row, 
                crossAxisSpacing: 5.0, 
                mainAxisSpacing: 25.0,
                childAspectRatio: (1/.9)),
                itemCount: _devices.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Device item;
                    item = _devices[index];
                  
                  return GridTile(child: Device_built(item: item));
                },
              ),
            ],
          ),
        ),
      ),
      
      );
  }
}