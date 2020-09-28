import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/UserProvider.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';
import 'package:quiky_user/theme/themedata.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  Future<void> login(context) async {
    Provider.of<UserProvider>(context, listen: false).setError();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await Provider.of<UserProvider>(context, listen: false)
          .login(formdata['phone'], formdata["password"]);

      if (Provider.of<UserProvider>(context, listen: false).getUser != null) {
        Provider.of<UserProvider>(context, listen: false).setError();
        // Navigator.of(context).popAndPushNamed("/home");
        Navigator.of(context).pop();
      }
    }
  }

  User u;

  final Map formdata = {
    'phone': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
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
                'LOGIN!',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  onSaved: (val) {
                    formdata["phone"] = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Phone Number"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Phone is empty";
                    }
                    return null;
                  },
                ),
              ),
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
                          login(context);
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
                      "New to Quiky? ",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/signup');
                      },
                      child: Text(
                        "  Sign Up",
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
