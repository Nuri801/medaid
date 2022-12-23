import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(),
          body: Center(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(CupertinoIcons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: Container(
              height: kBottomNavigationBarHeight,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.checkmark),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.text_badge_checkmark),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
