import 'package:flutter/material.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  late bool showPass = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          color: Colors.blue,
          elevation: 8,
          cornerRadius: 50,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [40, 350, double.infinity],
            positioning: SnapPositioning.pixelOffset,
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 100.0, top: 200.0),
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Geser ke atas\nuntuk',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5092FF),
                            height: 1) // This sets the line height (45 / 36)
                        ),
                    TextSpan(
                        text: ' Masuk',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1)),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          builder: (context, state) {
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                height: 10,
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
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        right: 20,
                        bottom: 20,
                        left: 20),
                    child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Nomor Induk Karyawan',
                            labelStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                            ),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.04,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: showPass,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Kata Sandi',
                            labelStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                            ),
                              
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPass ? Icons.visibility : Icons.visibility_off,
                                  color: const Color(0xff5A5A5A),
                                ),
                                onPressed: (){
                                  setState(() {
                                    setState(() {
                                      showPass = !showPass;
                                    });
                                  });
                                },
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff1D5C96)),
                          onPressed: () {
                            String username = _usernameController.text;
                            String password = _usernameController.text;
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                    ]),
                  )
                ]),
              ),
            );
          }),
    );
  }
}
