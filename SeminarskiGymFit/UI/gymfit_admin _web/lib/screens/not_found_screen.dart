import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("The screen could not be found!"),
            ElevatedButton(
              onPressed: () {
                // Use Navigator to pop the current route
                Navigator.of(context).popAndPushNamed("/gymFit");
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}