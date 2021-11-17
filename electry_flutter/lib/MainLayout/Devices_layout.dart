import 'package:electry_flutter/widgets/Device_build.dart';
import 'package:electry_flutter/widgets/Responsive/responsive.dart';
import 'package:flutter/material.dart';
import '../api_conn/Device.dart';
import '../api_conn/Services.dart';

class DeviceLayout extends StatefulWidget {
  final String privileges;
  DeviceLayout(this.privileges) : super();
  @override
  DeviceLayoutState createState() => DeviceLayoutState();
}

class DeviceLayoutState extends State<DeviceLayout> {
  List<Device> _devices;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _devices = [];
    _getDevices();
  }

  _getDevices() {
    Services.getDevices().then((devices) {
      setState(() {
        _devices = devices;
      });
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
                    "Devices",
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
              Container(
                child: Padding(
                  padding: Responsive.isDesktop(context)
                      ? const EdgeInsets.only(left: 20)
                      : const EdgeInsets.all(0),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isMobilePortrait(context)
                            ? 2
                            : Responsive.isMobileLandscape(context) ||
                                    Responsive.isTablet(context)
                                ? 4
                                : 6,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 25.0,
                        childAspectRatio: (1 / .9)),
                    itemCount: _devices.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Device item;
                      item = _devices[index];

                      return GridTile(
                          child: DeviceBuilt(
                        item: item,
                        privileges: widget.privileges,
                      ));
                    },
                  ),
                ),
                width: Responsive.isMobile(context)
                    ? double.infinity
                    : Responsive.isTablet(context)
                        ? 800
                        : 1200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
