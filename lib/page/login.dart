import 'package:flutter/material.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';
import 'package:aerolearn/utils/asset.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  late bool showPass = false;
  late bool _isAtEnd = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SheetController _slideController = SheetController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
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
            snappings: [40, 350, double.infinity],
            positioning: SnapPositioning.pixelOffset,
          ),
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
          },
          body: Center(
            child: SizedBox(
              child: Column(
                children: [
                  Stack(children: [
                    if(!_isAtEnd)
                    SizedBox(
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
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, left: MediaQuery.of(context).size.width * 0.1),
                      child: SelectableText.rich(
                       TextSpan(
                         children: [
                           TextSpan(
                             text: 'Halo,\n',
                             style: TextStyle(
                               fontSize:
                               MediaQuery.of(context).size.width * 0.06,
                               fontWeight: FontWeight.bold,
                               color: const Color(0xff5092FF),
                               height: 1.2,
                             ),
                           ),
                           TextSpan(
                             text: 'Selamat datang di \nAeroLearn!',
                             style: TextStyle(
                               fontSize:
                               MediaQuery.of(context).size.width * 0.06,
                               fontWeight: FontWeight.bold,
                               color: Colors.white,
                               height: 1.2,
                             ),
                           )
                         ]
                       )
                      ),
                    )
                  ]),
                  if(!_isAtEnd)
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.2, top: 0),
                    child: SelectableText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Geser ke atas\nuntuk',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff5092FF),
                                height: 1.2,
                                letterSpacing: 1.2),
                            // This sets the line height (45 / 36)
                          ),
                          TextSpan(
                              text: '  Masuk',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.08,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1)),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  if(!_isAtEnd)
                  SizedBox(
                    child: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                        child: Image.asset(
                          Assets.icons("arrow_slide"),
                          scale: 1.5,
                        )),
                  )
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
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04,
                          right: 20,
                          bottom: 20,
                          left: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: _usernameController,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: 'Nomor Induk Karyawan',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan nomor induk karyawan';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: _passwordController,
                              obscureText: showPass,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Kata Sandi',
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      showPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xff5A5A5A),
                                    ),
                                    iconSize: 25,
                                    onPressed: () {
                                      setState(() {
                                        setState(() {
                                          showPass = !showPass;
                                        });
                                      });
                                    },
                                  )),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
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
                                  backgroundColor: const Color(0xff1D5C96)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Form is valid!')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Form is invalid!')),
                                  );
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Color(0xffFFFFFF)),
                              ),
                            ),
                          ),
                        ]),
                      ))
                ]),
              ),
            );
          }),
    );
  }
}
