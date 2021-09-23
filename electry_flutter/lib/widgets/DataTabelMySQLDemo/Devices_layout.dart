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

  Icon _icon(String item) {
    if(item == 'lightbulb'){
      return new Icon( 
        Icons.lightbulb_sharp,
        color: Colors.black,
        size: 60.0,
      );
    }else if(item == 'console'){
      return new Icon( 
        Icons.videogame_asset_rounded,
        color: Colors.black,
        size: 60.0,
      );
    }else if(item == 'pc'){
      return new Icon( 
        Icons.computer_sharp,
        color: Colors.black,
        size: 60.0,
      );
    }else{
      return new Icon( 
        Icons.lightbulb_sharp,
        color: Colors.black,
        size: 60.0,
      );
    }
  } 

  BoxDecoration _color(int State) {
    if(State == 1){
      return BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.white,
            Colors.yellow[100],
            Colors.yellow[300],
            
            
          ]
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
      );
    }else{
      return BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.all(Radius.circular(20))
      );
    }
  }

  String _state(int State) {
    if (State == 1){
      return "On";
    }else{
      return "Off";
    }
  }

  GestureDetector _device(Device item) {
    
    return GestureDetector(
          onTap: (){
            print("${item.dev_id}");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Device_info_layout(item.dev_id)));
          },
          child: new Container(
            child: new Padding(
              child: new Container(
                
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      child: _icon(item.image_path),
                      padding: const EdgeInsets.only(top: 10, left: 10)
                      ),
                    
                    new Padding(
                      child: new Text(
                      item.dev_name,
                      style: new TextStyle(fontSize:20.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15, top: 10),
                    ),
                    new Padding(
                      child: new Text(
                        _state(item.dev_state),
                        style: new TextStyle(fontSize:18.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15)
                      ),
                    
                  ],
                ),
                decoration: _color(item.dev_state)
                
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),              
            ),
            width: 160,
            height: 160
          ),
          
          );
  }

  Widget _dev_lay() {
    return SingleChildScrollView(
        child: Column(
          children: [
            new Container(
              alignment: Alignment.topLeft,
              child: Padding(
                child:
                  new Text(
                    "Devices",
                      style: new TextStyle(fontSize:50.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 35.0, left: 20, bottom: 20),
              ),
            ),
            GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 5.0, 
              mainAxisSpacing: 25.0,
              childAspectRatio: (1/.9)),
              itemCount: _devices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Device item;
                  item = _devices[index];
                
                return GridTile(child: _device(item));
              },
            ),
          ],
        ),
      );
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
                    "Devices",
                      style: new TextStyle(fontSize:50.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 35.0, left: 20, bottom: 20),
              ),
            ),
            GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 5.0, 
              mainAxisSpacing: 25.0,
              childAspectRatio: (1/.9)),
              itemCount: _devices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Device item;
                  item = _devices[index];
                
                return GridTile(child: _device(item));
              },
            ),
          ],
        ),
      ),
      
      );
  }
}