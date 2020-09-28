import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/Providers/UserProvider.dart';
import '../features/user/domain/entity/user.dart';
import '../theme/themedata.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  Future<void> signup(context) async {
    Provider.of<UserProvider>(context, listen: false).setError();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await Provider.of<UserProvider>(context, listen: false)
          .signUp(formdata['phone'], formdata["password"], formdata['name']);
      // Provider.of<UserProvider>(context, listen: false).login("123456987", "test@123");

      if (Provider.of<UserProvider>(context, listen: false).getUser != null) {
        Provider.of<UserProvider>(context, listen: false).setError();
        // Navigator.of(context).popAndPushNamed("/home");
        Navigator.of(context).pop();

      }
    }
  }

  User u;

  final Map formdata = {
    'name': '',
    'phone': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    // final User u = Provider.of<UserProvider>(context,listen: false).getUser;
    // print(u);
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo.png',
                width: 138,
                height: 138,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'NEW TO QUIKY? SIGN UP!',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  onSaved: (val) {
                    formdata["name"] = val;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                  ),
                  validator: (val) => val.isEmpty ? "Name is Empty" : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  onSaved: (val) {
                    formdata["phone"] = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Phone Number"),
                  validator: (val) => val.isEmpty ? "Phone is empty" : null,
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: TextFormField(
              //     onSaved: (val) {},
              //     decoration: InputDecoration(hintText: "Phone Number"),
              //     keyboardType: TextInputType.emailAddress,
              //     validator: (val) {
              //       if (val.isEmpty) {
              //         return "Email is empty";
              //       }
              //     },
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  onSaved: (val) {
                    formdata["password"] = val;
                  },
                  decoration: InputDecoration(hintText: "Password"),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (val) {
                    Pattern pattern = r'^(?=.*?[0-9]).{6,}$';
                    RegExp regex = new RegExp(pattern);
                    if (val.isEmpty) {
                      return "Password is empty";
                    } else if (val.length < 6) {
                      return "Password must be 6 characters and one number";
                    } else if (!regex.hasMatch(val)) {
                      return "Password must be 6 characters and one number";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Consumer<UserProvider>(builder: (ctx, provider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      provider.error != ""
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 2, color: Colors.red),
                                  color: Color.fromRGBO(255, 0, 0, 0.2)),
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "${provider.error}",
                              ),
                            )
                          : Container(),
                      RaisedButton(
                        onPressed: () async {
                          //  u =await provider.signUp(formdata['phone'], formdata['password'], formdata['name']);
                          //  u =await provider.signUp("8854783531", "asdasd1", "ajmal");
                          //  u =await provider.login("navya@test.com", "test");
                          // print(u.name);
                          signup(context);
                          // print(provider.getUser);
                          // print(loading);
                        },
                        child: provider.loading
                            ? Container(
                                width: 19,
                                height: 19,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ))
                            : Text(
                                "Sign Up",
                                style: whiteBold13,
                              ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 0.0,
                        color: primary,
                      ),
                    ],
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account? ",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      child: Text(
                        "  Sign In",
                        style: TextStyle(color: primary),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
