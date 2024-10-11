import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelverse_mobile_app/src/auth/auth_provider.dart';
import 'package:travelverse_mobile_app/src/auth/user_model.dart';

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

Future<UserApp?> login(String email, password) async {
  try {
    Response response = await post(
        Uri.parse('https://dev.strapi.travelverse.in/api/auth/local'),
        body: {'identifier': email, 'password': password});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      final prefs = await SharedPreferences.getInstance();
      data['user']['apiToken'] = data['jwt'];
      UserApp userapp = UserApp.fromJson(data['user']);
      prefs.setString('user', jsonEncode(data['user']));
      print(data['token']);
      print('Login successfully');
      return userapp;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

// Define a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          Text('Login',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 38,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Username',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 40,
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: usernameController,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 16,
                      height: 1),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Password',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 40,
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: passwordController,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 16,
                      height: 1),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 4)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 38,
          ),
          LoginButton(),
          SizedBox(
            height: 50,
          ),
          Wrap(
            direction: Axis.vertical,
            spacing: 10,
            children: [
              Text(
                'Trouble Logging in?',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              CallUsButton()
            ],
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          UserApp? userapp = await login(usernameController.text.toString(),
              passwordController.text.toString());
          if (userapp != null) {
            // ignore: use_build_context_synchronously
            context.read<AuthProvider>().setUser(userapp);
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF03C3DF),
            padding: EdgeInsets.all(0),
            fixedSize: Size(254, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Text(
          'Login',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ));
  }
}

class CallUsButton extends StatelessWidget {
  const CallUsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF03C3DF),
            padding: EdgeInsets.all(0),
            fixedSize: Size(115, 39),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/PhoneIcon.png',
              width: 20,
              height: 20,
            ),
            Text(
              'Call us',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            )
          ],
        ));
  }
}
