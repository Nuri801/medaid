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



// // //

// // //


// // //
// // //

// // //
// // //     super.initState();
// // //   }
// // //


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
