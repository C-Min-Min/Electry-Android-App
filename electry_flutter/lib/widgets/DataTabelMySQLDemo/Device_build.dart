import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'Device.dart';
import 'Device_info_layout.dart';
bool isDarkMode;
List<Color> color_palette;

  Icon _icon(Device item) {
    Color clr;
    if(item.dev_state == 1){
      clr = Colors.black;
    }else{
      clr = color_palette[0];
    }
    if(item.image_path == 'lightbulb'){
      return new Icon( 
        Icons.lightbulb_sharp,
        color: clr,
        size: 60.0,
      );
    }else if(item.image_path == 'console'){
      return new Icon( 
        Icons.videogame_asset_rounded,
        color: clr,
        size: 60.0,
      );
    }else if(item.image_path == 'pc'){
      return new Icon( 
        Icons.computer_sharp,
        color: clr,
        size: 60.0,
      );
    }else{
      return new Icon( 
        Icons.lightbulb_sharp,
        color: clr,
        size: 60.0,
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
  _color(int State, bool back_text) {
    if(back_text){
      if(State == 1){
        return BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Colors.yellow[100],
              Colors.yellow[200],
              Colors.yellow[300]
            ]
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        );
      }else{
        return BoxDecoration(
            color: color_palette[2],
            borderRadius: BorderRadius.all(Radius.circular(20))
          );
      }
    }else{
      if(State == 1){
        return Colors.black;
      }else{
        return !isDarkMode ? Colors.black : Colors.white;
      }
    }

  }

  GestureDetector _device(BuildContext context, Device item) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    if(isDarkMode){
      color_palette = [Colors.white,Colors.black,Colors.grey[850]];
    }else{
      color_palette = [Colors.black,Colors.white,Colors.grey[350]];
    }
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
                      child: _icon(item),
                      padding: const EdgeInsets.only(top: 10, left: 10)
                      ),
                    
                    new Padding(
                      child: new Text(
                      item.dev_name,
                      style: new TextStyle(fontSize:20.0,
                      color: _color(item.dev_state, false),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15, top: 10),
                    ),
                    new Padding(
                      child: new Text(
                        _state(item.dev_state),
                        style: new TextStyle(fontSize:18.0,
                        color: _color(item.dev_state, false),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15)
                      ),
                    
                  ],
                ),
                decoration: _color(item.dev_state, true),
                height: double.infinity,
                width: double.infinity,
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),              
            ),
            width: 130,
          height: 130
          ),
          
          );
  }
  class Device_built extends StatelessWidget{
    final Device item;

    const Device_built({
      Key key,
      @required this.item
    }) : super(key: key);

    @override
    Widget build(BuildContext context){
      return _device(context, item);
    }
  }
