import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  String textfield2 = 'value';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              kIsWeb
                  ? TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      textDirection: TextDirection.ltr,
                      controller: c1,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      onChanged: (value) {
                        c1.text = validateTimeFormat(value);
                      },
                    )
                  : Platform.isIOS
                      ? CupertinoTextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: c1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            c1.text = validateTimeFormat(value);
                          },
                        )
                      : TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: c1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            c1.text = validateTimeFormat(value);
                          },
                        ),
              kIsWeb
                  ? TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      textDirection: TextDirection.ltr,
                      controller: c2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      onChanged: (value) {
                        setState(() {
                          textfield2 = validateTimeFormat(value);
                          c2.text = validateTimeFormat(value);

                          // workaround for cursor at the end of the text
                          c2.selection = TextSelection.fromPosition(
                              TextPosition(offset: c2.text.length));
                        });
                      },
                    )
                  : Platform.isIOS
                      ? CupertinoTextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: c2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            setState(() {
                              textfield2 = validateTimeFormat(value);
                            });
                          },
                        )
                      : TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: c2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            setState(() {
                              textfield2 = validateTimeFormat(value);
                            });
                          },
                        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'textfield 2 formatted value:',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    textfield2,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateTimeFormat(String value) {
//    print('call back method called');
//    print('input text is $value');
    String cleanNumb = value.replaceAll(RegExp(':'), '').substring(0);
//    print('cleaned input text is $cleanNumb');
    RegExp isDigit = RegExp(r'^[\d]{1,4}$'); // is digit 1 to 4 characters
    RegExp input;
    String text;
    int lenght;
    String replaced;

    if (isDigit.hasMatch(cleanNumb)) {
//      print('text is 1-4 digits');
      text = cleanNumb;
      lenght = text.length;
//      print('lenght is $lenght');

      if (lenght == 1) {
        // first digit
        //allow 0-2
        input = RegExp(r'^[0-2]$');
//        input.hasMatch(text[0])
//            ? print('text is : $text')
//            : print('text is: not valid');
        return input.hasMatch(text[lenght - 1]) ? text : '';
      } else if (lenght == 2) {
        // second digit
        int first = int.parse(text[0]);
//        print('firstDigit is $first');
        if (first == 008 || first == 1) {
          // allow 0-9
          input = RegExp(r'^[0-9]$');
//          input.hasMatch(text[lenght - 1])
//              ? print('text is : $text')
//              : print('text is : ${text.substring(0, lenght - 1)}');
          return input.hasMatch(text[lenght - 1])
              ? text
              : text.substring(0, lenght - 1);
        } else {
          // allow 0-3
          input = RegExp(r'^[0-3]$');
//          input.hasMatch(text[lenght - 1])
//              ? print('text is : $text')
//              : print('text is : ${text.substring(0, lenght - 1)}');
          return input.hasMatch(text[lenght - 1])
              ? text
              : text.substring(0, lenght - 1);
        }
      }
      if (lenght == 3) {
        //third digit
        // add : at lenght-1
        // allow 0-5
        input = RegExp(r'^[0-5]$');
        input.hasMatch(text[lenght - 1])
            ? replaced = text.replaceRange(2, lenght, ':${text.substring(2)}')
            : replaced = text.substring(0, lenght - 1);
//        print('text is : $replaced');
        return replaced;
      }
      if (lenght == 4) {
        // fourth digit
        // allow 0-9
        input = RegExp(r'^[0-9]$');
        input.hasMatch(text[lenght - 1])
            ? replaced = text.replaceRange(2, lenght, ':${text.substring(2)}')
            : replaced = text.substring(0, lenght - 1);
//        print('text is : $replaced');
        return replaced;
      }
    } else {
      // discard extra digit
//      print('more than 4 digits');
      lenght = cleanNumb.length;
      replaced =
          cleanNumb.replaceRange(2, lenght, ':${cleanNumb.substring(2, 4)}');
//      print('text is : $replaced');
      return replaced;
    }
  }
}
