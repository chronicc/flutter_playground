import 'package:clippers/widgets/point.dart';
import 'package:flutter/material.dart';
import 'package:clippers/widgets/wave_clipper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clipper Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime),
        useMaterial3: true,
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final double height = 200;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // Form
  final _formKey = GlobalKey<FormState>();
  double? _amplitude;
  double? _stretch;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = widget.height;
    double maxAmplitude = height / 2;
    double maxStretch = width / 2;

    _amplitude ??= getDefaultAmplitude();
    _stretch ??= getDefaultStretch();

    // Wave Clipper
    var p0 = Offset(0, maxAmplitude + _amplitude!);
    var p1 = Offset(maxStretch - _stretch!, maxAmplitude + _amplitude!);
    var p2 = Offset(width / 2, maxAmplitude);
    var p3 = Offset(maxStretch + _stretch!, maxAmplitude - _amplitude!);
    var p4 = Offset(width, maxAmplitude - _amplitude!);
    var p5 = Offset(width, 0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Wave Clipper'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(p0: p0, p1: p1, p2: p2, p3: p3, p4: p4, p5: p5),
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  height: height,
                ),
              ),
              Point(offset: p0),
              Point(offset: p1),
              Point(offset: p2),
              Point(offset: p3),
              Point(offset: p4),
              Point(offset: p5),
            ],
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Amplitude',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Slider(
                    label: _amplitude!.round().toString(),
                    max: maxAmplitude,
                    value: _amplitude!,
                    onChanged: (double value) {
                      setState(() {
                        _amplitude = value;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Stretch',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Slider(
                    label: _stretch!.round().toString(),
                    max: maxStretch,
                    value: _stretch!,
                    onChanged: (double value) {
                      setState(() {
                        _stretch = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: FilledButton(
                      onPressed: reset,
                      child: const Text('Reset'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void reset() {
    setState(() {
      _amplitude = getDefaultAmplitude();
      _stretch = getDefaultStretch();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All values resetted')),
    );
  }

  double getDefaultAmplitude() {
    return widget.height / 4;
  }

  double getDefaultStretch() {
    return MediaQuery.of(context).size.width / 4;
  }
}
