import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Device_info_layout.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Devices_layout.dart';
import 'package:electry_flutter/widgets/DataTabelMySQLDemo/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'Device.dart';
import 'Services.dart';
import 'Device_build.dart';
class Home_layout extends StatefulWidget{
  Home_layout() : super();
  @override
  Home_layout_State createState() => Home_layout_State();
}

class Home_layout_State extends State<Home_layout>{
  List<Device> _devices;
  List<Device> _fav_devices;
  GlobalKey<ScaffoldState> _scaffoldKey;
  int _on_devices; 
  int _selected_Index = 0;
  var screenWidth;
  var screenHeight;
  var blockSizeHorizontal;
  var blockSizeVertical;
  bool isDarkMode;
  List<Color> color_palette = [];
  @override
  void initState() {
    super.initState();
    _devices = [];
    _scaffoldKey = GlobalKey();
    _on_devices = 0;
    _fav_devices = [];
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

  _getDevices(){
    _on_devices = 0;
    _fav_devices = [];
    Services.getDevices().then((devices){
      setState(() {
        _devices = devices;
        for(int i = 0; i < _devices.length; i++){
          if(devices[i].dev_fav == 1){
            _fav_devices.add(devices[i]);
          }
        }
      });
      print("Length ${devices.length}");
      for(int i = 0; i < _devices.length; i++){
        if(_devices[i].dev_state == 1){
          _on_devices++;
        }
      }
      print("Length ${_fav_devices.length}");
    });
  }

  Future<Null> refresh() async {
    await _getDevices();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              alignment: Alignment.topLeft,
              child: Padding(
                child:
                  new Text(
                    "Home",
                      style: new TextStyle(fontSize:50.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 35.0, left: 20),
              ),
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: Padding(
                child: 
                  new Text(
                    "On",
                      style: new TextStyle(fontSize: 45.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 15.0, left: 25.0,),
              ),
            ),
            Container(
              child: Padding(
                padding: Responsive.isDesktop(context) ? const EdgeInsets.only(left: 20) : const EdgeInsets.all(0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobilePortrait(context) ? 2 : 4, 
                    crossAxisSpacing: 5.0, 
                    mainAxisSpacing: 25.0,
                    childAspectRatio: (1/.9)),
                    itemCount: _on_devices,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Device item;
                      if(_devices[index].dev_state == 1){
                        item = _devices[index];
                      }
                      
      
                      return GridTile(child: Device_built(item: item));
                    },
                  ),
              ),
              width: Responsive.isMobile(context) ? double.infinity : 800,
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: Padding(
                child: 
                  new Text(
                    "Favourite",
                      style: new TextStyle(fontSize: 45.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 15.0, left: 25.0, bottom: 10),
              ),
            ),
            Container(
              child: Padding(
                padding: Responsive.isDesktop(context) ? const EdgeInsets.only(left: 20) : const EdgeInsets.all(0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobilePortrait(context) ? 2 : 4, 
                    crossAxisSpacing: 5.0, 
                    mainAxisSpacing: 25.0,
                    childAspectRatio: (1/.9)),
                    itemCount: _fav_devices.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Device item;
                      item = _fav_devices[index];
      
                      return GridTile(child: Device_built(item: item,));
                    },
                ),
              ),
              width: Responsive.isMobile(context) ? double.infinity : 800,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 25.0, bottom: 10),
              ),
            
          ],
          
        ),
          
        
        ),
      ),
      
      );
        
  }
}