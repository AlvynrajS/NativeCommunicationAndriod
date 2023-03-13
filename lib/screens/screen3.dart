import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/circle.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    controller.value = 2.0;
  }

  @override
  Widget build(BuildContext context) {
    var circles = 6;
    var showDots = false;
    var showPath = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Circle path Canvas"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, snapshot) {
                    return Center(
                      child: CustomPaint(
                        painter: CirclePainter(
                          circles: circles,
                          progress: controller.value,
                          showDots: showDots,
                          showPath: showPath,
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: Text('Show Dots'),
                ),
                Switch(
                  value: showDots,
                  onChanged: (value) {
                    setState(() {
                      showDots = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: Text('Show Path'),
                ),
                Switch(
                  value: showPath,
                  onChanged: (value) {
                    setState(() {
                      showPath = value;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text('Circles'),
            ),
            Slider(
              value: circles.toDouble(),
              min: 1.0,
              max: 10.0,
              divisions: 9,
              label: circles.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  circles = value.toInt();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text('Progress'),
            ),
            Slider(
              value: controller.value,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  controller.value = value;
                });
              },
            ),
            Center(
              child: RaisedButton(
                child: Text('Animate'),
                onPressed: () {
                  controller.reset();
                  controller.forward();
                },
              ),
            ),
          ],
        ),
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Center(
      //       child: Container(
      //         color: Colors.yellow,
      //         child: CustomPaint(
      //             painter: CirclePainter(
      //           10,
      //           false,
      //           true,
      //           progress: controller.value,
      //         )),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
