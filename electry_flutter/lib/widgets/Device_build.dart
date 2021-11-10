import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../api_conn/Device.dart';
import '../SecLayout/Device_info_layout.dart';

bool isDarkMode;
List<Color> colorPalette;

Icon _icon(Device item) {
  Color clr;
  if (item.devState == 1) {
    clr = Colors.black;
  } else {
    clr = colorPalette[0];
  }
  if (item.imagePath == 'lightbulb') {
    return new Icon(
      Icons.lightbulb_sharp,
      color: clr,
      size: 60.0,
    );
  } else if (item.imagePath == 'console') {
    return new Icon(
      Icons.videogame_asset_rounded,
      color: clr,
      size: 60.0,
    );
  } else if (item.imagePath == 'pc') {
    return new Icon(
      Icons.computer_sharp,
      color: clr,
      size: 60.0,
    );
  } else {
    return new Icon(
      Icons.lightbulb_sharp,
      color: clr,
      size: 60.0,
    );
  }
}

String _state(int state) {
  if (state == 1) {
    return "On";
  } else {
    return "Off";
  }
}

_color(int state, bool backText) {
  if (backText) {
    if (state == 1) {
      return BoxDecoration(
          gradient: RadialGradient(colors: [
            Colors.white,
            Colors.yellow[100],
            Colors.yellow[200],
            Colors.yellow[300]
          ]),
          borderRadius: BorderRadius.all(Radius.circular(20)));
    } else {
      return BoxDecoration(
          color: colorPalette[2],
          borderRadius: BorderRadius.all(Radius.circular(20)));
    }
  } else {
    if (state == 1) {
      return Colors.black;
    } else {
      return !isDarkMode ? Colors.black : Colors.white;
    }
  }
}

GestureDetector _device(BuildContext context, Device item) {
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  isDarkMode = brightness == Brightness.dark;
  if (isDarkMode) {
    colorPalette = [Colors.white, Colors.black, Colors.grey[850]];
  } else {
    colorPalette = [Colors.black, Colors.white, Colors.grey[350]];
  }
  return GestureDetector(
    onTap: () {
      print("${item.devId}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeviceInfoLayout(item.devId)));
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
                    padding: const EdgeInsets.only(top: 10, left: 10)),
                new Padding(
                  child: new Text(
                    item.devName,
                    maxLines: 2,
                    style: new TextStyle(
                        fontSize: 20.0,
                        overflow: TextOverflow.ellipsis,
                        color: _color(item.devState, false),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto"),
                  ),
                  padding: const EdgeInsets.only(left: 15, top: 10),
                ),
                new Padding(
                    child: new Text(
                      _state(item.devState),
                      style: new TextStyle(
                          fontSize: 18.0,
                          color: _color(item.devState, false),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto"),
                    ),
                    padding: const EdgeInsets.only(left: 15)),
              ],
            ),
            decoration: _color(item.devState, true),
            height: double.infinity,
            width: double.infinity,
          ),
          padding: const EdgeInsets.only(left: 10, right: 10),
        ),
        width: 130,
        height: 130),
  );
}

class DeviceBuilt extends StatelessWidget {
  final Device item;

  const DeviceBuilt({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _device(context, item);
  }
}
