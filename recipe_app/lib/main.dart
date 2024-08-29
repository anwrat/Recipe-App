import 'package:flutter/material.dart';
import 'package:recipe_app/login.dart';
import 'package:recipe_app/register.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HamroRecipe',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primarycolor),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
      body: Align(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          // mainAxisAlignment: MainAxisAlignment.center, Use this when center needed
          children: <Widget>[
            Padding(
              child:Text(
                "Everyone can cook, You too!!",
                style: GoogleFonts.indieFlower(
                  fontSize: 30,
                ),),
              padding: const EdgeInsets.all(50),
              ),
            //Login Button
            Padding(
              padding: const EdgeInsets.all(5),
              child:Buttons(
                title: "Register",
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) =>
                        const Register(),
                      )
                  );
              },
              ),
            ),
            Padding(
              child:Text(
                "Already have an account?",
                style: GoogleFonts.leagueSpartan(
                  fontSize: 20,
                ),),
              padding: const EdgeInsets.only(top: 30),
            ),
            InkWell(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
              },
              child: Text(
                'Log-In',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 20,
                  color: MyColors.primarycolor,
                ),), 
            ),
            //To align the image at bottom of page
            Spacer(),
            Column(
              children:[
                Image.asset(
                  'assets/images/clouds.png',
                  width: MediaQuery.of(context).size.width, // Makes the image cover the entire width
                  fit: BoxFit.cover, // Ensures the image scales correctly
                ),
              ], 
            ),
          ],
        ),
      ),
    );
  }
}

