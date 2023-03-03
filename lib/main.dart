// import 'package:flutter/material.dart';
// import 'package:medaid/components/dory_themes.dart';
// import 'package:medaid/pages/home_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'MedAid',
//       theme: DoryThemes.lightTheme,
//       home: const HomePage(),
//       builder: (context, child) => MediaQuery(
//         data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//         child: child!,
//       ),
//     );
//   }
// }
//

// main.dart

/// The original code for the medaid app is above this line. Everything below this line is experimental.

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Remove the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'KindaCode.com',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   Future<String> getData() async {
//     await Future.delayed(const Duration(seconds: 3));
//     // throw "Error";
//     return 'Big Data';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FutureBuilder(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Text(snapshot.error.toString());
//             } else {
//               return Scaffold(
//                 body: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(snapshot.data.toString()),
//                       ElevatedButton(
//                           onPressed: () {
//                             setState(() {});
//                           },
//                           child: const Text('REFRESH!'))
//                     ],
//                   ),
//                 ),
//               );
//             }
//           }),
//
//     );
//   }
// }


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   // Generate dummy data to fill the list view
//   final List _items = List.generate(50, (index) => 'Item $index');
//
//   // The controller that is assigned to the list view
//   final ScrollController _controller = ScrollController();
//
//
//   // The scroll offset
//   double _scrollOffset = 0;
//
//   // The maximum scroll offset
//
//   // In other words, this means the user has reached the bottom of the list view
//   double? _maxOffset;
//
//
//   @override
//   void initState() {
//     _controller.addListener(() {
//       _maxOffset = _controller.position.maxScrollExtent;
//       setState(() {
//         _scrollOffset = _controller.offset;
//         if (_maxOffset != null && _scrollOffset >= _maxOffset!) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text('You have reached the end of the list view')));
//         } else {
//           ScaffoldMessenger.of(context).removeCurrentSnackBar();
//         }
//       });
//     });
//
//     super.initState();
//   }
//
//   // Discards any resources used by the scroll controller object
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('KindaCode.com')),
//       // implement the list view
//       body: ListView.builder(
//         // attact the controller
//         controller: _controller,
//         itemBuilder: ((context, index) => Card(
//           key: ValueKey(_items[index]),
//           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           elevation: 6,
//           color: Colors.amber.shade100,
//           child: ListTile(
//             title: Text(_items[index]),
//           ),
//         )),
//         itemCount: _items.length,
//       ),
//       // display the scroll offset
//       bottomNavigationBar: BottomAppBar(
//         elevation: 6,
//         // set the background color of the bottom bar based on the the current offset position
//         // if at the top: green
//         // if at the bottom: red
//         // otherwise: blue
//         color: _scrollOffset <= 0
//             ? Colors.green
//             : _maxOffset != null && _scrollOffset >= _maxOffset!
//             ? Colors.red
//             : Colors.blue,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20, left: 20),
//           child: Text(
//             "Offset: ${_scrollOffset.toString()}",
//             style: const TextStyle(
//                 fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity example app'),
      ),
      body: Center(
          child: Text('Connection Status: ${_connectionStatus.toString()}')),
    );
  }



}
