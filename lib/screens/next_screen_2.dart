import 'package:contact_access/Widgets/dotted_border.dart';
import 'package:flutter/material.dart';

import '../Widgets/circle.dart';
import '../Widgets/dotted_line.dart';
import '../Widgets/line.dart';

class NextScreen2 extends StatefulWidget {
  const NextScreen2({Key? key}) : super(key: key);

  @override
  State<NextScreen2> createState() => _NextScreen2State();
}

class _NextScreen2State extends State<NextScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dotted border")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.0),
                  )),
              const SizedBox(height: 10),
              Container(
                height: 100,
                width: 100,
                color: Colors.orange,
                child: CustomPaint(
                  painter: DottedBorderPainter(
                      strokeWidth: 10.0, paintingStyle: PaintingStyle.stroke),
                  // painter: DashedBorderPainter(
                  //     color: Colors.green,
                  //     strokeWidth: 10.0,
                  //     dashWidth: 100.0,
                  //     gapWidth: 100.0),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 200,
                color: Colors.greenAccent,
                child: CustomPaint(
                  painter: LinePainter(progress: 0.50),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 200,
                color: Colors.white,
                child: CustomPaint(
                  painter: DashLinePainter(progress: 1),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 200,
                height: 200,
                color: Colors.yellow,
                child: CustomPaint(
                  painter: DottedBorderPainter(strokeWidth: 10),
                  child: Container(height: 20,width: 20,color: Colors.cyan,),
                ),
              ),
              const SizedBox(height: 100),

            ],
          ),
        ),
      ),
    );
  }
}
