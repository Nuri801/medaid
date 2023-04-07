import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Input',
      home: PasswordInputPage(),
    );
  }
}



class PasswordInputPage extends StatefulWidget {
  @override
  _PasswordInputPageState createState() => _PasswordInputPageState();
}



class _PasswordInputPageState extends State<PasswordInputPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordIsValid = false;

  void _checkPasswordValidity(String value) {
    setState(() {
      _passwordIsValid = value.isNotEmpty && value.length >= 6;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Input'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter a password',
                errorText: _passwordIsValid ? null : 'Password must be at least 6 characters long',
              ),
              onChanged: _checkPasswordValidity,
            ),
          ),
          Expanded(

            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse('https://example.com')),
              onWebViewCreated: (controller) {
                controller.evaluateJavascript(source: 'document.getElementById("password").value = "${_passwordController.text}";');
              },
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(source: 'document.getElementById("password").value = "${_passwordController.text}";');
              },
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

//
// void main() {
//

//   //
//   //   password.fillRange(0, password.length, target.codeUnitAt(0) as String?);

//
// }
//

// //
// // }
//
//

// // //



// // //

// // //


// // //
// // //
// // //   // The scroll offset
// // //   double _scrollOffset = 0;
// // //
// // //   // The maximum scroll offset
// // //
// // //   // In other words, this means the user has reached the bottom of the list view
// // //   double? _maxOffset;
// // //
// // //     });
// // //
// // //     super.initState();
// // //   }
// // //
// // //   }
// // //         // attact the controller
// // //         controller: _controller,
// // //         itemBuilder: ((context, index) => Card(
// // //           key: ValueKey(_items[index]),
// // //           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
// // //           elevation: 6,
// // //           color: Colors.amber.shade100,
// // //           child: ListTile(
// // //             title: Text(_items[index]),
// // //           ),
// // //         )),
// // //         itemCount: _items.length,
// // //       ),
// // //       // display the scroll offset
// // //       bottomNavigationBar: BottomAppBar(
// // //         elevation: 6,
// // //         // set the background color of the bottom bar based on the the current offset position
// // //         // if at the top: green
// // //         // if at the bottom: red
// // //         // otherwise: blue
// // //         color: _scrollOffset <= 0
// // //             ? Colors.green
// // //             : _maxOffset != null && _scrollOffset >= _maxOffset!
// // //             ? Colors.red
// // //             : Colors.blue,
// // //         child: Padding(
// // //           padding: const EdgeInsets.only(top: 20, left: 20),
// // //           child: Text(
// // //             "Offset: ${_scrollOffset.toString()}",
// // //             style: const TextStyle(
// // //                 fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // // ignore_for_file: public_member_api_docs
// //
// // import 'dart:async';
// // import 'dart:developer' as developer;
// //
// // import 'package:connectivity_plus/connectivity_plus.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key, required this.title}) : super(key: key);
// //
// //   final String title;
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   ConnectivityResult _connectionStatus = ConnectivityResult.none;
// //   final Connectivity _connectivity = Connectivity();
// //   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     initConnectivity();
// //     _connectivitySubscription =
// //         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _connectivitySubscription.cancel();
// //     super.dispose();
// //
// //   }
// //
// //   Future<void> initConnectivity() async {
// //     late ConnectivityResult result;
// //     try {
// //       result = await _connectivity.checkConnectivity();
// //     } on PlatformException catch (e) {
// //       developer.log('Couldn\'t check connectivity status', error: e);
// //       return;
// //     }
// //
// //     if (!mounted) {
// //       return Future.value(null);
// //     }
// //
// //     return _updateConnectionStatus(result);
// //   }
// //
// //   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
// //     setState(() {
// //       _connectionStatus = result;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Connectivity example'),
// //       ),
// //       body: Center(
// //           child: Text('Connection Status: ${_connectionStatus.toString()}')),
// //     );
// //   }
// //
// // }
