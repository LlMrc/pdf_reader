import 'package:flutter/material.dart';
import 'dart:math';

import 'package:pdf_reader/notes/stickynotepainter.dart';

class StickyNoteContainer extends StatelessWidget {
  const StickyNoteContainer({Key? key, required this.createdDate, required this.name})
      : super(key: key);
  final String name;
  final DateTime createdDate;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 300,
            height: 300,
            child: StickyNote(
              child: Text(
                name,
                maxLines: 10,
                overflow: TextOverflow.clip,
                style: const TextStyle(color: Colors.black, 
                
                fontSize: 16),
              ),
            )));
  }
}

class StickyNote extends StatelessWidget {
  const StickyNote({required this.child, this.color = const Color(0xffffff00)});

  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.01 * pi,
      child: CustomPaint(

          painter: StickyNotePainter(color: color),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          )),
    );
  }
}
