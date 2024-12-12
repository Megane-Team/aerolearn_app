import 'package:flutter/material.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';
import 'package:aerolearn/utils/asset.dart';
import 'package:aerolearn/action/login.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  late bool showPass = true;
  late bool _isAtEnd = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SheetController _slideController = SheetController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff12395D),
      body: SlidingSheet(
          controller: _slideController,
          color: Colors.blue,
          elevation: 8,
          cornerRadius: 50,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [40, double.infinity, double.infinity],
            positioning: SnapPositioning.pixelOffset,
          ),
          openDuration: const Duration(milliseconds: 100),
          listener: (state) {
            if (state.extent == state.maxExtent) {
              setState(() {
                _isAtEnd = true;
              });
            } else {
              setState(() {
                _isAtEnd = false;
              });
            }
            FocusScope.of(context).unfocus();
          },
          body: Center(
            child: SizedBox(
              child: Column(
                children: [
                  Stack(
                    children: [
                      _isAtEnd
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: double.infinity,
                              child: Image.asset(
                                Assets.logos("half_logo"),
                                alignment: Alignment.centerRight,
                                fit: BoxFit.contain,
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: double.infinity,
                              child: Image.asset(
                                Assets.logos("half_logo"),
                                alignment: Alignment.centerRight,
                                fit: BoxFit.contain,
                              ),
                            ),
                      if (_isAtEnd)
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.5,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.38,
                            left: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: SelectableText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Halo,\n',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff5092FF),
                                    height: 1.2,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Selamat datang di \nAeroLearn!',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Conditional rendering based on _isAtEnd
                      if (!_isAtEnd)
                        Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.2,
                          ),
                          child: SelectableText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Geser ke atas\nuntuk',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.08,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff5092FF),
                                    height: 1.2,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                TextSpan(
                                  text: '  Masuk',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.08,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (!_isAtEnd)
                        GestureDetector(
                          onPanUpdate: (details) {
                            // Trigger the sliding action based on drag direction
                            if (details.delta.dy < 0) {
                              // Dragging up
                              _slideController.snapToExtent(
                                  _slideController.state?.maxExtent ??
                                      350); // Snap to max extent
                            } else if (details.delta.dy > 0) {
                              // Dragging down
                              _slideController.snapToExtent(
                                  40); // Adjust the extent as needed
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Image.asset(
                              Assets.icons("arrow_slide"),
                              scale: 1,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          builder: (context, state) {
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                height: double.infinity,
                color: Colors.white,
                child: Column(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      alignment: Alignment.center,
                      height: 5,
                      width: 200,
                      color: const Color(0xffD9D9D9),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = MediaQuery.of(context).size.width;
                        double fontSize = screenWidth * 0.05;

                        return Text(
                          'Masuk ke akunmu',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1D5C96),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height *
                          0.04, // Vertical padding
                      horizontal: 20, // Fixed horizontal padding
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: _emailController,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04, // Adjusted font size
                                ),
                              ),
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width *
                                    0.04, // Adjusted font size
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: _passwordController,
                              obscureText: showPass,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Kata Sandi',
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04, // Adjusted font size
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPass
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xff5A5A5A),
                                  ),
                                  iconSize: 25,
                                  onPressed: () {
                                    setState(() {
                                      showPass = !showPass;
                                    });
                                  },
                                ),
                              ),
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width *
                                    0.04, // Adjusted font size
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan kata sandi';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1D5C96),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var loginResult = await ApiService.login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  if (loginResult == null) {
                                    showDialog(
                                        // ignore: use_build_context_synchronously
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Login Failed'),
                                            content: Text(
                                                'Invalid Email or password. Please try again.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
                                  } else if (loginResult != "peserta") {
                                    showDialog(
                                      // ignore: use_build_context_synchronously
                                      context: context, // Add context parameter
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Login Failed'),
                                          content: Text(
                                              'Invalid Email or password. Please try again.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    context.go('/mainpage');
                                  }
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Color(0xffFFFFFF)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            );
          }),
    );
  }
}
