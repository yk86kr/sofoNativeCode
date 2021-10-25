import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sofo_native/main_page.dart';
import 'package:sofo_native/pages/sofo_main.dart';
import 'package:sofo_native/theme_data/colors.dart';
import 'package:sofo_native/theme_data/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { login, notLogin, connecting }

class _LoginPageState extends State<LoginPage> {

  LoginStatus _loginStatus = LoginStatus.notLogin;

  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80,),
              Center(
                child: Container(
                  width: 137.5,
                  height: 175.8,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/sofo_icon_box_m.png'),
                          fit: BoxFit.fill)),),),
              const SizedBox(height: 6,),
              const Text(
                '대학가 맛집 검색 & 리뷰',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        autocorrect: false,
                        controller: userId,
                        cursorColor: textGrey,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '아이디'
                        ),
                      ),
                    )),),
              const SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        autocorrect: false,
                        obscureText: true,
                        controller: password,
                        cursorColor: textGrey,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '비밀번호'
                        ),
                      ),
                    )),),
              const SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: GestureDetector(
                  onTap: (){
                    // ignore: unnecessary_null_comparison
                    if (userId.text == '') {
                      simpleSnackBar('아이디를 입력해주세요', context);
                      // ignore: unnecessary_null_comparison
                    } else if (password.text == '') {
                      simpleSnackBar('비밀번호를 입력해주세요', context);
                    } else {
                     login(userId.text, password.text);
                    }
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: sofoGreen,
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: const Center(
                        child: Text(
                          'sofo 로그인하기',
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),)),
                  ),
                ),
              )
            ]));
  }

  login(String id, String pwd,) async {
    const url = 'https://www.koreapas.com/bbs/login_api.php';
    final response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: utf8,
        body: ({
          'api_key': '1030_F62860871CBAC2E697DB85F7CEC52CD6',
          'user_id': id,
          'password': pwd
        }));
    // print(response.body);

    final data = jsonDecode(response.body);
    bool value = data["result"];
    String error = data['error'];

    if (value == true) {
      String userNick = data["data"]['nickname'];
      setState(() {
        _loginStatus = LoginStatus.login;
        savePref(value, userNick, id);
        // print('23423' + userNick);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      });
    } else {
      simpleSnackBar('로그인에 실패했습니다.', context);
      // print(error);
    }
    
  }

  getPref() async {
    bool? value;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getBool("value");

      _loginStatus = value == true ? LoginStatus.login : LoginStatus.notLogin;
    });
  }

  savePref(bool value, String userNick, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("value", value);
      preferences.setString("userNick", userNick);
      preferences.setString("userId", id);
    });
  }

}
