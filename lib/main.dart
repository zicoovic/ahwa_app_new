import 'package:ahwa_app_new/screens/pending_screen.dart';
import 'package:ahwa_app_new/widgets/custom_bottom_sheet.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('Smart Ahwa App')),
            body: drinks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No pending orders'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await customBottom(context);
                            setState(() {});
                          },
                          child: Text('Add Drink'),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You have ${drinks.length} pending orders'),
                        SizedBox(height: 20),
                        Icon(Icons.pending_actions, size: 50),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PendingScreen(),
                              ),
                            );
                          },
                          child: Text('pending orders'),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
