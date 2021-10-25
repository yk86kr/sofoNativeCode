import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sofo_native/theme_data/colors.dart';

class SofoMainPage extends StatefulWidget {
  const SofoMainPage({Key? key}) : super(key: key);

  @override
  _SofoMainPageState createState() => _SofoMainPageState();
}

class _SofoMainPageState extends State<SofoMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mainLogo(),
            Padding(
              padding: const EdgeInsets.only(top:8.0, bottom: 20),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.location_searching),
                label: const Text('서울시 성북구 안암동 5가'),
                style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
              ),
            )
          ],
        ),
      )),
    );
  }

  Column mainLogo() {
    return Column(
      children: const [
        SizedBox(
          height: 20,
        ),
        Image(
          image: AssetImage('assets/sofo_icon_box_m.png'),
          width: 137.5,
          height: 175.8,
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          '대학가 맛집 검색 & 리뷰',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
