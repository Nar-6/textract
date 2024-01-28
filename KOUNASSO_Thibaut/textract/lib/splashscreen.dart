import 'package:flutter/material.dart';
import 'dart:async';

import 'package:textract/homepage.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  Future<void> simulateLoading() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Changez la durée selon vos besoins
  }

  @override
  void initState() {
    super.initState();
    simulateLoading().then((_) {
      // Naviguez vers l'écran principal après le chargement
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[ 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: CustomPaint(
                      painter: MyPainter(),
                      child: const SizedBox(
                        width: 200.0,
                        height: 100.0,
                        
                      ),
                    ),
                  ),
                ],
              ),
              const Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [  
                  Text(
                    'TEXTRACT',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipPath(
                    clipper: CustomClipPath2(),
                    child: CustomPaint(
                      painter: MyPainter(),
                      child: const SizedBox(
                        width: 200.0,
                        height: 100.0,
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
        )
        );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(0, 0); //1.point
    path.lineTo(0, h); // 2
    // path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.lineTo(w, 0); //5
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // throw UnimplementedError();
    return false;
  }
}

class CustomClipPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(w, 0); //1.point
    path.lineTo(w, h); // 2
     path.lineTo(0, h); //5

    // path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // throw UnimplementedError();
    return false;
  }
}


class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Dessinez le rectangle avec une couleur personnalisée
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    // ..strokeWidth = 2.0; // Contour

    canvas.drawRect(
        Rect.fromPoints(
            const Offset(-75.0, -200.0), Offset(size.width, size.height)),
        paint);

    // canvas.rotate(100);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


