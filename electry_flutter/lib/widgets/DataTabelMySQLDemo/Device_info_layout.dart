import 'dart:math';

import 'package:electry_flutter/widgets/DataTabelMySQLDemo/Measurement.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Device.dart';
import 'Services.dart';
class Device_info_layout extends StatefulWidget{
  final int item;
  Device_info_layout(this.item) : super();
  @override
  Device_info_layout_State createState() => Device_info_layout_State();
}

class Device_info_layout_State extends State<Device_info_layout>{
  List<Device> _device;
  bool dev_fav = false;
  List<Measurement> _measure;
  final items = ['lightbulb', 'pc', 'console'];
  String value_icon;
  TextEditingController _textFieldController = TextEditingController();
  List<FlSpot> measures = [FlSpot(0,0.5),FlSpot(24,0.5)];
  double maxY = 100;
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<Color> gradientColors = [
    Color(0xFF101820FF),
    Color(0xFF00B1D2FF),
    Color(0xFF101820FF),
  ];


  @override
  void initState() {
    _getDevice(widget.item);
    super.initState();
    _scaffoldKey = GlobalKey();
    
  }

  _updateDevice(int id, String change, String dev){
    Services.updateDevice(id, change, dev);
  }

  _getDevice(int id){
    Services.searchDevice(id).then((device){
      setState(() {
        _device = device;
      });
      print("Length ${device.length}");
    });
    Services.getMeasurements(id).then((measure){
      setState(() {
        _measure = measure;
      });
    });
  }

  void measurements(String selectDay) {
    measures = [];
    setState(() {
      if(_measure != null){
      for(var measure_c = 0; measure_c < _measure.length; measure_c++){
        List<String> shorter = _measure[measure_c].timestamp.toString().split("T");
        String date ;
        String time ;
        double hour;
        if((int.parse(shorter[1].split(":")[0]) + 3) >= 24){
          date = shorter[0].split("-")[0] + "-" + shorter[0].split("-")[1]  + "-" + (int.parse(shorter[0].split("-")[2]) + 1).toString();
          time = (int.parse(shorter[1].split(":")[0]) - 21).toString() + ":" + shorter[1].split(":")[1] + ":" + shorter[1].split(".")[0].split(":")[2];
          hour = (int.parse(shorter[1].split(":")[0]) - 21) + (int.parse(shorter[1].split(":")[1]) / 60);
        }else{
          date = shorter[0];
          time = (int.parse(shorter[1].split(":")[0]) +3 ).toString() + ":" + shorter[1].split(":")[1] + ":" + shorter[1].split(".")[0].split(":")[2];
          hour = (int.parse(shorter[1].split(":")[0]) +3 ) + (int.parse(shorter[1].split(":")[1]) / 60);
        }
        
        if (date == selectDay) {
          if(_measure[measure_c].state == 1){
            measures.add(FlSpot(hour, 0.5));
          }
          
          measures.add(FlSpot(hour, _measure[measure_c].power.toDouble()));
          while (_measure[measure_c].power.toDouble() >= maxY){
            maxY += 100;
          }

          if(_measure[measure_c].state == 0){
            measures.add(FlSpot(hour, 0.5));
          }
        }
      }
    }else{
      measures = [FlSpot(0,0.5),FlSpot(24,0.5)];
    }
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
            Colors.yellow[200],
            Colors.yellow[300]
          ]
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
      );
    }else{
      return BoxDecoration(
        color: Colors.grey[300],
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

  Container _device_info(Device item) {
    return Container(
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
                      item.dev_desc,
                      style: new TextStyle(fontSize:18.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15, top: 10,right: 25),
                    ),

                    new Padding(
                      child: new Text(
                        _state(item.dev_state),
                        style: new TextStyle(fontSize:18.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10)
                      ),
                    
                  ],
                ),
                decoration: _color(item.dev_state)
                
              ),
              padding: const EdgeInsets.only(left: 20, right: 20),              
            ),
            width: MediaQuery.of(context).size.width,
          );
  }
  CalendarFormat format = CalendarFormat.week;
  DateTime focusedDay;
  DateTime selectedDay;

  bool get_dev_fav(Device item){
    if (item.dev_fav == 1){
      return true;
    }else{
      return false;
    }
  }

  void change_dev_fav(Device item, bool state){
    if (state){
        _updateDevice(item.dev_id, "dev_fav", "1");
      }else{
        _updateDevice(item.dev_id, "dev_fav", "0");
      }
  }

  void change_dev(Device item, change, dev){
    if(change == "name"){
      _updateDevice(item.dev_id, "dev_name", dev);
    }else if(change == "desc"){
      _updateDevice(item.dev_id, "dev_desc", dev);
    }else if(change == "icon"){
      _updateDevice(item.dev_id, "dev_icon", dev);
    }
  }

  Future<void> _editIconDialog(BuildContext context, Device item){
    if(items.contains(item.image_path)){
      value_icon = item.image_path;
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
          title: Text("Edit Icon"),
          content: DropdownButtonFormField<String>(
            value: value_icon,
            items: items.map(buildIconsItem).toList(),
            onChanged: (value) {
              setState(() {
                value_icon = value;
                print(value_icon);
              });
            },
            onSaved: (value) {
              setState(() {
                value_icon = value;
                print(value_icon);
              });
            },
            
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Cancel'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  change_dev(_device[0], "icon", value_icon);
                  print(value_icon);
                  _getDevice(widget.item);
                  measurements(focusedDay.toString().split(" ")[0]);
                  Navigator.pop(context);
                });
              },
            )
          ],
        );
      }
    );
  }

  DropdownMenuItem<String> buildIconsItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );

  Future<void> _editStringDialog(BuildContext context, Device item, String change ){
    if(change == "name"){
      _textFieldController.value = _textFieldController.value.copyWith(
        text: item.dev_name,
        selection: TextSelection.collapsed(offset: _textFieldController.value.selection.baseOffset + item.dev_name.length,),
      );
    }else if(change == "desc"){
      _textFieldController.value = _textFieldController.value.copyWith(
        text: item.dev_desc,
        selection: TextSelection.collapsed(offset: _textFieldController.value.selection.baseOffset + item.dev_desc.length,),
      );
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
          title: Text("Edit " + change),
          content: TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _textFieldController,
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Cancel'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  codeDialog = valueText;
                  change_dev(_device[0], change, codeDialog);
                  print(codeDialog);
                  _getDevice(widget.item);
                  measurements(focusedDay.toString().split(" ")[0]);
                  Navigator.pop(context);
                });
              },
            )
          ],
        );
      }
    );
  }

  String valueText;
  String codeDialog;
  Widget statistics(Device item) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 400,
      child: Padding(
        child: Column(
        children: <Widget>[
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 24,
                minY: 0,
                maxY: maxY,
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 10,
                    interval: 1,
                    getTextStyles: (context, value) => const TextStyle(
                      color: Color(0xFFFBC02D),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        
                        case 0:
                          return "00:00";
                        case 6:
                          return "06:00";
                        case 12:
                          return "12:00";
                        case 18:
                          return "18:00";
                        case 24:
                          return "24:00";
                      }
                      return '';
                    },
                    margin: 8
                  )
                ),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[400],
                      strokeWidth: 1,
                    );
                  }
                ),
                lineBarsData: [
                  
                  LineChartBarData(
                    spots: measures,
                    colors: [Colors.blue[300]],
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: gradientColors
                              .map((color) => color.withOpacity(0.8))
                              .toList()
                    )
                  )
                ]
              ),
            ),
          )
        ],
      ),
      padding: const EdgeInsets.only(top: 25, bottom: 20, right: 30),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (focusedDay == null && selectedDay == null){
      if (_measure != null){
        focusedDay = DateTime.parse(_measure[_measure.length - 1].timestamp);
        selectedDay = DateTime.parse(_measure[_measure.length - 1].timestamp);
        measurements(focusedDay.toString().split(" ")[0]);
      }
    }
    dev_fav = get_dev_fav(_device[0]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            new Container(
              alignment: Alignment.topLeft,
              child: Padding(
                child: 
                  new Text(
                    _device[0].dev_name,
                      style: new TextStyle(fontSize:50.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 45, left: 20, bottom: 20),
              ),
            ),
            _device_info(_device[0]),
            new Container(
              alignment: Alignment.topLeft,
              child: Padding(
                child: 
                  new Text(
                    "Stats",
                      style: new TextStyle(fontSize:40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 25, left: 30, bottom: 20),
              ),
            ),
            Padding(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TableCalendar(
                  firstDay: DateTime.utc(2021, 6, 1),
                  lastDay: DateTime.utc(2024, 12, 31),
                  focusedDay: selectedDay,
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekVisible: true,
                  onDaySelected: (DateTime selectDay, DateTime focusDay){
                    setState(() {
                      focusedDay = focusDay;
                      selectedDay = selectDay;
                    });
                    print(focusedDay.toString().split(" ")[0]);
                    measurements(focusedDay.toString().split(" ")[0]);
                  },
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape:  BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle
                    ),
                    selectedTextStyle: TextStyle(color: Colors.black , fontSize: 18),
                    todayTextStyle: TextStyle(fontSize: 17)

                  ),
                  selectedDayPredicate: (DateTime date){
                    return isSameDay(selectedDay, date);
                  },
                ),
              ),
              padding: const EdgeInsets.only( left: 20, right: 20, bottom: 10),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: statistics(_device[0]),
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: Padding(
                child: 
                  new Text(
                    "Settings",
                      style: new TextStyle(fontSize:40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.only(top: 25, left: 30, bottom: 20),
              ),
            ),
            Padding(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
                child: SwitchListTile(
                  title: new Text('Favourite: ', style: new TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                  value: dev_fav,
                  onChanged: (bool value) {
                    setState(() {
                      dev_fav = value;
                      change_dev_fav(_device[0], value);
                       _getDevice(widget.item);
                      measurements(focusedDay.toString().split(" ")[0]);
                    });
                  }
                ), 
              ),
              padding: const EdgeInsets.only( left: 20, right: 20, bottom: 10),
            ),
            Padding(
              child: OutlinedButton.icon(
                label: new Text('Edit name', style: new TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                icon: Icon(Icons.edit, size: 18,),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)
                ),
                onPressed: (){
                  _editStringDialog(context, _device[0], "name");
                },
              ),
              padding: const EdgeInsets.only( left: 20, right: 20, bottom: 10),
            ),
            Padding(
              child: OutlinedButton.icon(
                label: new Text('Edit description', style: new TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                icon: Icon(Icons.edit, size: 18,),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)
                ),
                onPressed: (){
                  _editStringDialog(context, _device[0], "desc");
                },
              ),
              padding: const EdgeInsets.only( left: 20, right: 20, bottom: 10),
            ),
            Padding(
              child: OutlinedButton.icon(
                label: new Text('Edit icon', style: new TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                icon: Icon(Icons.edit, size: 18,),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)
                ),
                onPressed: (){
                  _editIconDialog(context, _device[0]);
                },
              ),
              padding: const EdgeInsets.only( left: 20, right: 20, bottom: 10),
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
              onPressed: () {
                _getDevice(widget.item);
                measurements(focusedDay.toString().split(" ")[0]);
              },
              child: const Icon(Icons.refresh),
              backgroundColor: Colors.blueAccent,
              tooltip: "Refresh",),
    );
  }
}