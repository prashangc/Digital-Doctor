import '../screens/HomeScreen.dart';
import '../screens/LoginAndSignUp_screen.dart';
import '../state/details_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientTabView extends StatefulWidget {
  const PatientTabView({Key? key}) : super(key: key);
  @override
  State<PatientTabView> createState() => _PatientTabViewState();
  static const routeName = "/login-patient-tab-view-screen";
}

class _PatientTabViewState extends State<PatientTabView> {
  double signUpContainerHeight = 380;
  double signUpPositionTop = 375;
  bool isVisible = true;
  bool isSignUpVisible = false;

  final _form = GlobalKey<FormState>();
  final _formSignUp = GlobalKey<FormState>();

  String? _username;
  String? _password;
  String? _usernameSignUp;
  String? _passwordSignUp;
  String? _email;
  String? _phone;
  String? _confirmPassword;
  bool? _isPatient;

  void _guestLogin() async {
    bool islogin = await Provider.of<DetailsState>(context, listen: false)
        .guestLogin(_username.toString(), _password.toString());
    if (!islogin) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      // Navigator.of(context).pushReplacementNamed(const HomeScreen().routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Register an account.",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  void _loginNow() async {
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      //if not valid / if empty)
      return;
    }
    _form.currentState?.save();
    bool islogin = await Provider.of<DetailsState>(context, listen: false)
        .loginPatient(_username.toString(), _password.toString());
    if (!islogin) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      // Navigator.of(context).pushReplacementNamed(const HomeScreen().routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Please provide correct credentials.",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  void _registerNow() async {
    var isValid = _formSignUp.currentState?.validate();
    if (!isValid!) {
      //if not valid / if empty)
      return;
    }
    _formSignUp.currentState?.save();
    bool isRegister = await Provider.of<DetailsState>(context, listen: false)
        .registerPatient(
            _usernameSignUp.toString(),
            _email.toString(),
            _phone.toString(),
            _confirmPassword.toString(),
            _passwordSignUp.toString());
    if (!isRegister) {
      print("success");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginAndSignUpScreen()));
      // Navigator.of(context).pushReplacementNamed(const HomeScreen().routeName);
    } else {
      print("error");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Please provide correct credentials.",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: isVisible,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 220.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.7,
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0),
                          child: Form(
                            key: _form,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter your Username';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _username = v;
                                  },
                                  cursorHeight: 22,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    labelText: 'Username',
                                  ),
                                ),
                                const SizedBox(
                                  height: 13.0,
                                ),
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter your password';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _password = v;
                                  },
                                  obscureText: true,
                                  cursorHeight: 22,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon:
                                        Icon(Icons.remove_red_eye_outlined),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    labelText: 'Password',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 220.0,
                      left: 85.0,
                      child: SizedBox(
                        width: 240.0,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomeScreen()));

                            _loginNow();
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                      isSignUpVisible = !isSignUpVisible;
                    });
                  },
                  child: const Text(
                    'Create a Patient account?',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'OR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomeScreen()));

                    _guestLogin();
                  },
                  child: const Text(
                    'View as Guest',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.facebook,
                        size: 40.0,
                      ),
                      Icon(
                        Icons.facebook,
                        size: 40.0,
                      ),
                      Icon(
                        Icons.facebook,
                        size: 40.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isSignUpVisible,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                      child: Container(
                        // duration: const Duration(milliseconds: 3000),
                        width: double.infinity,
                        height: signUpContainerHeight,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.7,
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0),
                          child: Form(
                            key: _formSignUp,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter your Username';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _usernameSignUp = v;
                                  },
                                  cursorHeight: 22,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 10.0),
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    labelText: 'Username',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter your Email';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _email = v;
                                  },
                                  cursorHeight: 22,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 10.0),
                                    prefixIcon: Icon(Icons.mail),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    labelText: 'Email',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter your phone number';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _phone = v;
                                  },
                                  cursorHeight: 22,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 10.0),
                                    prefixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    labelText: 'Phone Number',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter your password';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _passwordSignUp = v;
                                  },
                                  obscureText: true,
                                  cursorHeight: 22,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 10.0),
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    labelText: 'Password',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter your password again';
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _confirmPassword = v;
                                  },
                                  obscureText: true,
                                  cursorHeight: 22,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 10.0),
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    labelText: 'Confirm Password',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: signUpPositionTop,
                      left: 85.0,
                      child: SizedBox(
                        width: 240.0,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            var isValid = _formSignUp.currentState?.validate();
                            isValid!
                                ? setState(() {})
                                : setState(() {
                                    signUpContainerHeight = 480;
                                    signUpPositionTop = 480;
                                  });
                            print('tapped');
                            _registerNow();
                          },
                          child: const Text(
                            'SIGNUP',
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 35.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSignUpVisible = !isSignUpVisible;
                      isVisible = !isVisible;
                    });
                  },
                  child: const Text(
                    'Go to Login.',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
