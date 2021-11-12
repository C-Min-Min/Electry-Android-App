import 'package:electry_flutter/MainLayout/Devices_layout.dart';
import 'package:electry_flutter/widgets/Responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api_conn/Device.dart';
import '../api_conn/Services.dart';
import '../widgets/Device_build.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout() : super();
  @override
  HomeLayoutState createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {
  List<Device> _devices;
  List<Device> favDevices;
  int onDevices;
  int selectedIndex = 0;
  var screenWidth;
  var screenHeight;
  var blockSizeHorizontal;
  var blockSizeVertical;
  bool isDarkMode;
  @override
  void initState() {
    super.initState();
    _devices = [];
    onDevices = 0;
    favDevices = [];
    _getDevices();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageLayout();
  }

  void pageLayout() {
    if (selectedIndex == 1) {
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 300),
              fullscreenDialog: true,
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secAnimation) {
                return DeviceLayout();
              }));
    }
  }

  _getDevices() {
    onDevices = 0;
    favDevices = [];
    Services.getDevices().then((devices) {
      setState(() {
        _devices = devices;
        for (int i = 0; i < _devices.length; i++) {
          if (devices[i].devFav == 1) {
            favDevices.add(devices[i]);
          }
        }
      });
      for (int i = 0; i < _devices.length; i++) {
        if (_devices[i].devState == 1) {
          onDevices++;
        }
      }
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
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Container(
                alignment: Alignment.topLeft,
                child: Responsive.isMobile(context)
                    ? Padding(
                        child: Text(
                          'electry',
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2),
                        ),
                        padding: Responsive.isMobilePortrait(context)
                            ? const EdgeInsets.only(top: 40.0, left: 10)
                            : const EdgeInsets.only(top: 15.0, left: 10),
                      )
                    : null,
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  child: new Text(
                    "Home",
                    style: new TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto"),
                  ),
                  padding: Responsive.isMobile(context)
                      ? const EdgeInsets.only(top: 5.0, left: 20)
                      : const EdgeInsets.only(top: 35.0, left: 20),
                ),
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  child: new Text(
                    "On",
                    style: new TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto"),
                  ),
                  padding: const EdgeInsets.only(top: 15.0, left: 25.0),
                ),
              ),
              Container(
                child: Padding(
                  padding: Responsive.isDesktop(context)
                      ? const EdgeInsets.only(left: 20)
                      : const EdgeInsets.all(0),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            Responsive.isMobilePortrait(context) ? 2 : 4,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 25.0,
                        childAspectRatio: (1 / .9)),
                    itemCount: onDevices,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Device item;
                      if (_devices[index].devState == 1) {
                        item = _devices[index];
                      }

                      return GridTile(child: DeviceBuilt(item: item));
                    },
                  ),
                ),
                width: Responsive.isMobile(context) ? double.infinity : 800,
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  child: new Text(
                    "Favourite",
                    style: new TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto"),
                  ),
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 25.0, bottom: 10),
                ),
              ),
              Container(
                child: Padding(
                  padding: Responsive.isDesktop(context)
                      ? const EdgeInsets.only(left: 20)
                      : const EdgeInsets.all(0),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            Responsive.isMobilePortrait(context) ? 2 : 4,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 25.0,
                        childAspectRatio: (1 / .9)),
                    itemCount: favDevices.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Device item;
                      item = favDevices[index];

                      return GridTile(
                          child: DeviceBuilt(
                        item: item,
                      ));
                    },
                  ),
                ),
                width: Responsive.isMobile(context) ? double.infinity : 800,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 25.0, bottom: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
