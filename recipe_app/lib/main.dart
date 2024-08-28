import 'package:flutter/material.dart';
import 'package:recipe_app/home.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/search.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/textfields.dart';
import 'package:recipe_app/widgets/navbar.dart';


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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: Center(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getSelectedScreen(_selectedIndex),
            // //Home Button
            // ElevatedButton(
            //   style: ButtonStyle(
            //       backgroundColor: WidgetStatePropertyAll(MyColors.primarycolor),
            //   ),
            //   //To use a hex color use color class and add 0xff as prefix
            //   child: const Icon(color: Color(0xffFFFFFF),IconData(0xe318, fontFamily: 'MaterialIcons'),),
            //   onPressed:(){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder:(context) =>
            //           const SearchPage(),
            //         )
            //     );
            //   },
            // ),
            // Buttons(
            //   title: "Hello",
            //   onPressed:(){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder:(context) =>
            //           const SearchPage(),
            //         )
            //     );
            // },
            // buttonColor: Colors.blue,
            // textColor:Colors.red,
            // icons:const Icon(color: Color(0xffFFFFFF),IconData(0xe567, fontFamily: 'MaterialIcons'),)
            // ),
          ],
        ),
      ),
      //To place the navbar at bottom of screen
      bottomNavigationBar: NavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
   Widget _getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const Text('Search Screen');
      case 2:
        return const Text('Account Screen');
      case 3:
        return const Text('Settings');
      default:
        return const Text('Home Screen');
    }
  }
}
