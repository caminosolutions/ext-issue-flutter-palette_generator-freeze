import 'package:flutter/material.dart';
import 'package:palette_generator_freeze_on_web/image_is_black.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    final contentWidget = _load == false
        ? FilledButton(onPressed: () => setState(() => _load = true), child: const Text('calculate'))
        : ImageIsBlackWidget(
            /// image size = 263KB
            imageProvider: const AssetImage('vanessa-bucceri-X1gTLgWMDKg-unsplash_hd.jpg'),

            /// image sizes > 2MB
            // imageProvider: const AssetImage('assets/pexels-christian-heitz-842711.jpg'),
            // imageProvider: Image.asset('assets/pexels-christian-heitz-842711.jpg').image,
            // imageProvider: AssetImage('assets/pexels-mohamed-almari-1485894.jpg'),
            // imageProvider: AssetImage('assets/pexels-vlad-alexandru-popa-1402787.jpg'),
            builder: (isBlack) => Text(
              'IsBlack: $isBlack',
            ),
          );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[contentWidget],
        ),
      ),
    );
  }
}
