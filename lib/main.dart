import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Flip Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlipCardPage(),
    );
  }
}

class FlipCardPage extends StatefulWidget {
  @override
  _FlipCardPageState createState() => _FlipCardPageState();
}

class _FlipCardPageState extends State<FlipCardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _spinAnimation;
  bool _isFront = true;
  bool _isHorizontal = true; // To track swipe direction
  bool _isSpinning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _spinAnimation = Tween(begin: 0.0, end: 2 * 3.1415926535897932).animate(_controller);

    _spinAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard(bool isHorizontal) {
    setState(() {
      _isHorizontal = isHorizontal;
    });
    if (_isFront) {
      _controller.forward(from: 0.0);
    } else {
      _controller.reverse(from: 2 * 3.1415926535897932);
    }
    _isFront = !_isFront;
  }

  void _toggleSpin() {
    setState(() {
      _isSpinning = !_isSpinning;
    });
    if (_isSpinning) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('@zain_dev_',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onHorizontalDragEnd: (_) => _flipCard(true),
              onVerticalDragEnd: (_) => _flipCard(false),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final angle = _animation.value * 3.1415926535897932;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(_isHorizontal ? angle : 0)
                      ..rotateX(_isHorizontal ? 0 : angle),
                    child: _animation.value <= 0.5
                        ? Image.asset('assets/fn.png')
                        : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(
                            _isHorizontal ? 3.1415926535897932 : 0)
                        ..rotateX(_isHorizontal ? 0 : 3.1415926535897932),
                      child: Image.asset('assets/bk.png'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleSpin,
              child: Text(_isSpinning ? 'Stop Spinning' : 'Spin'),
            ),
          ],
        ),
      ),
    );
  }
}
