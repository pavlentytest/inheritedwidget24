import 'package:flutter/material.dart';


// https://www.geeksforgeeks.org/flutter-inherited-widget/

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyNavigation(),
    );
  }
}

// route function for  Routing of pages
Route generatePage(child) {
  return MaterialPageRoute(builder: (context) => child);
}

class MyNavigation extends StatelessWidget {
  const MyNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      // message as string for our inherited widget
      message: 'Message!!!',
      counter: 0,
      child: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'screen1':
                return generatePage(const FirstScreen());
            case 'screen2':
                return generatePage(const SecondScreen());
          }
        },
        // our first screen in app
        initialRoute: 'screen1',
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {

  const MyInheritedWidget({Key? key,
    required this.child,
    required this.message,
    required this.counter
  }) : super(key: key, child: child);

  @override
  final Widget child;

  // message variable for
  // our inherited widget
  final String message;

  final int counter;

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return true;
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First screen'),
        backgroundColor: Colors.green,
      ),

      body: Center(
        child: ElevatedButton(
          // showing message variable of our
          // inherotedd widget class using of()
          child: Text(MyInheritedWidget.of(context).message),
          onPressed: () {
            Navigator.of(context)
            // navigate to second screen
                .push(MaterialPageRoute(builder: (_) => SecondScreen()));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Second screen'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Text(MyInheritedWidget.of(context).message + "\n This is second screen",
                     style: const TextStyle(fontWeight: FontWeight.bold)
          ),
          // showing message variable of our
          // inherotedd widget class using of()
        )
    );
  }
}