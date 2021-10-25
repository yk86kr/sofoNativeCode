import 'package:flutter/material.dart';
import 'package:sofo_native/pages/sofo_main.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const SofoMainPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('sofo'),
      ),
      bottomNavigationBar: sofoBottomBar(),
    );
  }

  BottomAppBar sofoBottomBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        margin: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 0, bottom: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            sofoBottomIcon(const Icon(Icons.home)),
            sofoBottomIcon(const Icon(Icons.search)),
            sofoBottomIcon(const Icon(Icons.list)),
            sofoBottomIcon(const Icon(Icons.wallet_giftcard)),
            sofoBottomIcon(const Icon(Icons.person)),
          ],
        ),
      ),
    );
  }

  IconButton sofoBottomIcon(icon) {
    return IconButton(onPressed: () {}, icon: icon);
  }
}
