import 'dart:math';

import 'package:flutter/material.dart';


class CircularProgress extends CustomPainter{

  double currentProgress;
  Color currentColor;

  CircularProgress(this.currentProgress,this.currentColor);

  @override
  void paint(Canvas canvas, Size size) {

    Paint outerCircle = Paint()
        ..strokeWidth = 3.5
        ..style = PaintingStyle.stroke
        ..color = Colors.black;

    Paint completeArc = Paint()
        ..strokeWidth = 4
        ..color = currentColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width/2,size.height/2);
    double radius = min(size.width/2,size.height/2) - 4 ;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);



  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }












}