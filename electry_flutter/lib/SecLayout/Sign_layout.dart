import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginLayout extends StatefulWidget {
  LoginLayout() : super();
  @override
  LoginLayoutState createState() => LoginLayoutState();
}

class LoginLayoutState extends State<LoginLayout> {
  @override
  void initState() {
    super.initState();
  }

  final textFieldFocusNode = FocusNode();
  final textFieldFocusNodeRepeat = FocusNode();
  bool _obscured = true;
  bool _obscuredRepeat = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscuredRepeat() {
    setState(() {
      _obscuredRepeat = !_obscuredRepeat;
      if (textFieldFocusNodeRepeat.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNodeRepeat.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 15),
                child: Text(
                  'electry',
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  height: 420,
                  width: 330,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.grey[350],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: isDarkMode
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                            cursorColor: Colors.blueAccent,
                            style: TextStyle(color: Colors.blueAccent),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  color: Colors.blueAccent,
                                  fontFamily: 'OpenSans'),
                              suffixIcon: Icon(
                                Icons.account_circle,
                                color: Colors.blueAccent,
                                size: 17,
                              ),
                            )),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                            cursorColor: Colors.blueAccent,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.blueAccent),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.blueAccent,
                                  fontFamily: 'OpenSans'),
                              suffixIcon: Icon(
                                Icons.mail,
                                color: Colors.blueAccent,
                                size: 17,
                              ),
                            )),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                            cursorColor: Colors.blueAccent,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscured,
                            focusNode: textFieldFocusNode,
                            style: TextStyle(color: Colors.blueAccent),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.blueAccent,
                                  fontFamily: 'OpenSans'),
                              suffixIcon: GestureDetector(
                                onTap: _toggleObscured,
                                child: Icon(
                                  _obscured
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: Colors.blueAccent,
                                  size: 17,
                                ),
                              ),
                            )),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                            cursorColor: Colors.blueAccent,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscuredRepeat,
                            focusNode: textFieldFocusNodeRepeat,
                            style: TextStyle(color: Colors.blueAccent),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.blueAccent,
                                  fontFamily: 'OpenSans'),
                              suffixIcon: GestureDetector(
                                onTap: _toggleObscuredRepeat,
                                child: Icon(
                                  _obscuredRepeat
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: Colors.blueAccent,
                                  size: 17,
                                ),
                              ),
                            )),
                      ),
                      /*Padding(
                        padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password',
                            )
                          ],
                        ),
                      )*/
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[800]),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
