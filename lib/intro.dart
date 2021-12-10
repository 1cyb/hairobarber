import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:hairobarber/home.dart';

class Intro extends StatelessWidget {
  Map userValues;
  Intro(this.userValues);
  final pages = [
    PageViewModel(
      pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              Color(0xfff8bc24),
              Color(0xff266867),
            ],
          ),
        ),
      ),
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/images/logo.png'),
      body: const Text(
        'Hassle-free  booking  of  flight  tickets  with  full  refund  on  cancellation',
      ),
      title: const Text(
        'Flights',
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      mainImage: Image.asset(
        'assets/images/logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              Color(0xFF1A4645),
              Color(0xfff58800),
            ],
          ),
        ),
      ),
      iconImageAssetPath: 'assets/images/logo.png',
      body: const Text(
        'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels',
      ),
      title: const Text('Hotels'),
      mainImage: Image.asset(
        'assets/images/logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              Color(0xfff58800),
              Color(0xff051821),
            ],
          ),
        ),
      ),
      iconImageAssetPath: 'assets/images/logo.png',
      body: const Text(
        'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
      ),
      title: const Text('Cabs'),
      mainImage: Image.asset(
        'assets/images/logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter',
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF1A4645)),
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            // Use Navigator.pushReplacement if you want to dispose the latest route
            // so the user will not be able to slide back to the Intro Views.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Home(userValues)),
            );
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
