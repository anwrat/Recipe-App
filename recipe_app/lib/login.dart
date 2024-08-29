import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/search.dart';
import 'package:recipe_app/widgets/logo.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<StatefulWidget> createState() =>  _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailField =  TextEditingController();
  final TextEditingController _passwordField =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,//height of appbar
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoSection(image: 'assets/images/mainlogo.png'),
          ],
        ), 
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontWeight: FontWeight.w300,
                    fontSize: 30.0,
                    // color: Color(0xFF035388),
                    color: Colors.amber,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                _buildTextFields(),
                const SizedBox(
                  height: 60.0,
                ),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
         Container(
            child: TextField(
              controller: _emailField,
              textAlign: TextAlign.center,
              // decoration: InputDecoration(
              //   enabledBorder:const UnderlineInputBorder(
              //     borderSide: BorderSide(
              //       color: Colors.grey,
              //       width: 2.0,
              //     ),
              //   ),
              //   hintText: 'Email',
              //   hintStyle: TextStyle(
              //     color: Colors.grey[400],
              //     fontSize: 18.0,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
               decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          ),
                        ),
            ),
          ),
          const SizedBox(
            height: 60.0,
          ),
          Container(
            child: TextField(
              controller: _passwordField,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text(
              'LOGIN',
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF0B69A3),
                letterSpacing: 2.0,
              ),
            ),
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => 
              const SearchPage(),));            },
          ),
         const SizedBox(
            height: 80.0,
          ),
          ElevatedButton (
            child: Icon(
              Icons.close,
              color: Colors.grey[400],
              size: 40.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}