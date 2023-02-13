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
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'KindaCode.com',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Generate dummy data to fill the list view
  final List _items = List.generate(50, (index) => 'Item $index');

  // The controller that is assigned to the list view
  final ScrollController _controller = ScrollController();

  // The scroll offset
  double _scrollOffset = 0;

  // The maximum scroll offset
  // In other words, this means the user has reached the bottom of the list view
  double? _maxOffset;

  @override
  void initState() {
    _controller.addListener(() {
      _maxOffset = _controller.position.maxScrollExtent;
      setState(() {
        _scrollOffset = _controller.offset;
        if (_maxOffset != null && _scrollOffset >= _maxOffset!) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('You have reached the end of the list view')));
        } else {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      });
    });

    super.initState();
  }

  // Discards any resources used by the scroll controller object
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KindaCode.com')),
      // implement the list view
      body: ListView.builder(
        // attact the controller
        controller: _controller,
        itemBuilder: ((context, index) => Card(
          key: ValueKey(_items[index]),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 6,
          color: Colors.amber.shade100,
          child: ListTile(
            title: Text(_items[index]),
          ),
        )),
        itemCount: _items.length,
      ),
      // display the scroll offset
      bottomNavigationBar: BottomAppBar(
        elevation: 6,
        // set the background color of the bottom bar based on the the current offset position
        // if at the top: green
        // if at the bottom: red
        // otherwise: blue
        color: _scrollOffset <= 0
            ? Colors.green
            : _maxOffset != null && _scrollOffset >= _maxOffset!
            ? Colors.red
            : Colors.blue,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "Offset: ${_scrollOffset.toString()}",
            style: const TextStyle(
                fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
