import 'package:electry_flutter/api_conn/Services.dart';
import 'package:electry_flutter/widgets/Responsive/nav_layout.dart';
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

  _login(String userMail, String password) {
    Services.loginUser(userMail, password).then((response) {
      if (response) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NavLayout()));
      } else {
        wrongCredentials = true;
      }
    });
  }

  final textFieldFocusNode = FocusNode();
  final textFieldFocusNodeRepeat = FocusNode();
  bool _obscured = true;
  bool _obscuredRepeat = true;
  final userMailController = TextEditingController();
  final passwordController = TextEditingController();
  bool wrongCredentials = false;

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
                padding: const EdgeInsets.only(top: 120),
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
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 320,
                  width: 330,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: isDarkMode
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                            controller: userMailController,
                            cursorColor: Colors.blueAccent,
                            style: TextStyle(color: Colors.blueAccent),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Username/Email',
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
                            controller: passwordController,
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
                                color: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[300]),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _login(userMailController.text,
                                  passwordController.text);
                            });
                          },
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
