import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _showSheet(context),
              child: const Text('Open BottomSheet'),
            ),
            ElevatedButton(
              onPressed: () => _showFixedSheet(context),
              child: const Text('Open fixed BottomSheet'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          minChildSize: 0.0,
          initialChildSize: 1.0,
          snap: true,
          snapSizes: const [0.0, 1.0],
          builder: (context, scrollController) {
            return Container(
              color: Colors.blue,
            );
          },
        );
      },
    );
  }

  void _showFixedSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          minChildSize: 0.0,
          initialChildSize: 1.0,
          snap: true,
          snapSizes: const [0.0, 1.0],
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
