import 'package:electry_flutter/api_conn/Measurement.dart';
import 'package:electry_flutter/widgets/Responsive/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import '../api_conn/Device.dart';
import '../api_conn/Services.dart';
class DeviceInfoLayout extends StatefulWidget{
  final int item;
  DeviceInfoLayout(this.item) : super();
  @override
  DeviceInfoLayoutState createState() => DeviceInfoLayoutState();
}

class DeviceInfoLayoutState extends State<DeviceInfoLayout>{
  List<Device> _device;
  bool devFav = false;
  List<Measurement> _measure;
  final items = ['lightbulb', 'pc', 'console'];
  String valueIcon;
  TextEditingController _textFieldController = TextEditingController();
  List<FlSpot> measures = [FlSpot(0,0.5),FlSpot(24,0.5)];
  double maxY = 100;
  bool isDarkMode;
  List<Color> colorPalette;
  List<Color> gradientColors = [
    Color(0xFF101820FF),
    Color(0xFF00B1D2FF),
    Color(0xFF101820FF),
  ];


  @override
  void initState() {
    _getDevice(widget.item);
    super.initState();
    
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
  Future<Null> refresh() async {
    await _getDevice(widget.item);
    return null;
  }

  void measurements(String selectDay) {
    measures = [];
    setState(() {
      if(_measure != null){
      for(var measureCount = 0; measureCount < _measure.length; measureCount++){
        List<String> shorter = _measure[measureCount].timestamp.toString().split("T");
        String date;
        double hour;
        if((int.parse(shorter[1].split(":")[0]) + 3) >= 24){
          date = shorter[0].split("-")[0] + "-" + shorter[0].split("-")[1]  + "-" + (int.parse(shorter[0].split("-")[2]) + 1).toString();
          hour = (int.parse(shorter[1].split(":")[0]) - 21) + (int.parse(shorter[1].split(":")[1]) / 60);
        }else{
          date = shorter[0];
          hour = (int.parse(shorter[1].split(":")[0]) +3 ) + (int.parse(shorter[1].split(":")[1]) / 60);
        }
        
        if (date == selectDay) {
          if(_measure[measureCount].state == 1){
            measures.add(FlSpot(hour, 0.5));
          }
          
          measures.add(FlSpot(hour, _measure[measureCount].power.toDouble()));
          while (_measure[measureCount].power.toDouble() >= maxY){
            maxY += 100;
          }

          if(_measure[measureCount].state == 0){
            measures.add(FlSpot(hour, 0.5));
          }
        }
      }
    }else{
      measures = [FlSpot(0,0.5),FlSpot(24,0.5)];
    }
    });
    
  }

Icon _icon(Device item) {
    Color clr;
    if(item.devState == 1){
      clr = Colors.black;
    }else{
      clr = colorPalette[0];
    }
    if(item.imagePath == 'lightbulb'){
      return new Icon( 
        Icons.lightbulb_sharp,
        color: clr,
        size: 60.0,
      );
    }else if(item.imagePath == 'console'){
      return new Icon( 
        Icons.videogame_asset_rounded,
        color: clr,
        size: 60.0,
      );
    }else if(item.imagePath == 'pc'){
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

  _color(int state, bool backText) {
    if(backText){
      if(state == 1){
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
            color: colorPalette[2],
            borderRadius: BorderRadius.all(Radius.circular(20))
          );
      }
    }else{
      if(state == 1){
        return Colors.black;
      }else{
        return !isDarkMode ? Colors.black : Colors.white;
      }
    }

  }
  String _state(int state) {
    if (state == 1){
      return "On";
    }else{
      return "Off";
    }
  }

  Container deviceInfo(Device item) {
    return Container(
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
                      item.devName,
                      style: new TextStyle(fontSize:20.0,
                      color: _color(item.devState, false),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15, top: 10),
                    ),
                    
                    new Padding(
                      child: new Text(
                      item.devDesc,
                      style: new TextStyle(fontSize:18.0,
                      color: _color(item.devState, false),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15, top: 10,right: 25),
                    ),

                    new Padding(
                      child: new Text(
                        _state(item.devState),
                        style: new TextStyle(fontSize:18.0,
                        color: _color(item.devState, false),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10)
                      ),
                    
                  ],
                ),
                decoration: _color(item.devState, true)
                
              ),
              padding: const EdgeInsets.only(left: 20, right: 20),              
            ),
            width: MediaQuery.of(context).size.width,
          );
  }
  CalendarFormat format = CalendarFormat.week;
  DateTime focusedDay;
  DateTime selectedDay;

  bool getDevFav(Device item){
    if (item.devFav == 1){
      return true;
    }else{
      return false;
    }
  }

  void changeDevFav(Device item, bool state){
    if (state){
        _updateDevice(item.devId, "devFav", "1");
      }else{
        _updateDevice(item.devId, "devFav", "0");
      }
  }

  void changeDev(Device item, change, dev){
    if(change == "name"){
      _updateDevice(item.devId, "devName", dev);
    }else if(change == "desc"){
      _updateDevice(item.devId, "devDesc", dev);
    }else if(change == "icon"){
      _updateDevice(item.devId, "dev_icon", dev);
    }
  }

  Future<void> _editIconDialog(BuildContext context, Device item){
    if(items.contains(item.imagePath)){
      valueIcon = item.imagePath;
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
          title: Text("Edit Icon", style: TextStyle(fontSize: 30),),
          content: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent, width: 4)
            ),
            child: DropdownButtonFormField<String>(
              value: valueIcon,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

              ),
              items: items.map(buildIconsItem).toList(),
              onChanged: (value) {
                setState(() {
                  valueIcon = value;
                  print(valueIcon);
                });
              },
              onSaved: (value) {
                setState(() {
                  valueIcon = value;
                  print(valueIcon);
                });
              },
              
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Cancel'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  changeDev(_device[0], "icon", valueIcon);
                  print(valueIcon);
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
  int lineCount;
  Future<void> _editStringDialog(BuildContext context, Device item, String change ){
    if(change == "name"){
      lineCount = 1;
      _textFieldController.value = _textFieldController.value.copyWith(
        text: item.devName,
        selection: TextSelection.collapsed(offset: _textFieldController.value.selection.baseOffset + item.devName.length,),
      );
    }else if(change == "desc"){
      lineCount = 5;
      _textFieldController.value = _textFieldController.value.copyWith(
        text: item.devDesc,
        selection: TextSelection.collapsed(offset: _textFieldController.value.selection.baseOffset + item.devDesc.length,),

      );
    }
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
          title: Text("Edit " + change, style: TextStyle(fontSize: 30)),
          content: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent, width: 4)
            ),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: lineCount,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

              ),
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Cancel'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  codeDialog = valueText;
                  changeDev(_device[0], change, codeDialog);
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
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    if(isDarkMode){
      colorPalette = [Colors.white,Colors.black,Colors.grey[850]];
    }else{
      colorPalette = [Colors.black,Colors.white,Colors.grey[350]];
    }
    if(_device[0].devName == ""){
      Navigator.pop(context);
    }
    devFav = getDevFav(_device[0]);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: GestureDetector(
          onPanUpdate: !Responsive.isDesktop(context) ? (details) {
            if (details.delta.dx > 0) {
              Navigator.pop(context);
            }
          }: null,
          
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                new Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    child: 
                      new Text(
                        _device[0].devName,
                          style: new TextStyle(fontSize:50.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto"),
                      ),
                    padding: const EdgeInsets.only(top: 45, left: 20, bottom: 20),
                  ),
                ),
                deviceInfo(_device[0]),
                new Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    child: 
                      new Text(
                        "Stats",
                          style: new TextStyle(fontSize:40.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto"),
                      ),
                    padding: const EdgeInsets.only(top: 25, left: 30, bottom: 20),
                  ),
                ),
                Padding(
                  child: Container(
                    decoration: BoxDecoration(color: colorPalette[2],
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
                  decoration: BoxDecoration(color: colorPalette[2],
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
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto"),
                      ),
                    padding: const EdgeInsets.only(top: 25, left: 30, bottom: 20),
                  ),
                ),
                Padding(
                  child: Container(
                    decoration: BoxDecoration(color: colorPalette[2],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: SwitchListTile(
                      title: new Text('Favourite: ', style: new TextStyle(fontSize: 25, color: colorPalette[0], fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                      value: devFav,
                      activeColor: Colors.blueAccent,
                      onChanged: (bool value) {
                        setState(() {
                          devFav = value;
                          changeDevFav(_device[0], value);
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
                    label: new Text('Edit name', style: new TextStyle(fontSize: 25, color: colorPalette[0], fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                    icon: Icon(Icons.edit, size: 18,color: colorPalette[0],),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colorPalette[2],
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
                    label: new Text('Edit description', style: new TextStyle(fontSize: 25, color: colorPalette[0], fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                    icon: Icon(Icons.edit, size: 18,color: colorPalette[0]),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colorPalette[2],
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
                    label: new Text('Edit icon', style: new TextStyle(fontSize: 25, color: colorPalette[0], fontWeight: FontWeight.w500, fontFamily: "Roboto"),),
                    icon: Icon(Icons.edit, size: 18, color: colorPalette[0],),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colorPalette[2],
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
        ),
      ),
      
      );
  }
}