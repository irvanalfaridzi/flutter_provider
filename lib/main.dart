import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_provider/cart.dart';
import 'package:multi_provider/money.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Cart()),
      ChangeNotifierProvider(create: (_) => Money())
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;

  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = 10;
            // _start--;
            // timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (context.read<Money>().balance >= 500) {
            context.read<Cart>().quantity += 1;
            context.read<Money>().balance -= 500;
          }
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add_shopping_cart),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Multi Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                startTimer();
              },
              child: Text("start"),
            ),
            Text("$_start"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Balance"),
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${context.watch<Money>().balance.toString()}",
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.w700),
                    ),
                  ),
                  height: 30,
                  width: 150,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.purple[100],
                      border: Border.all(color: Colors.purple, width: 2)),
                )
              ],
            ),
            Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Apple (500) x ${context.watch<Cart>().quantity.toString()}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      (500 * context.watch<Cart>().quantity).toString(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              height: 30,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 2)),
            )
          ],
        ),
      ),
    );
  }
}
