import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TileWidget extends StatefulWidget {
  const TileWidget({
    Key? key,
    required this.number,
    required this.width,
    required this.height,
    required this.color,
    this.size,
  }) : super(key: key);

  final String number;
  final double width;
  final double height;
  final Color color;
  final double? size;

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Center(
        child: Text(
          widget.number,
          style: GoogleFonts.sourceCodePro(
            fontSize: widget.size,
            fontWeight: FontWeight.bold,
            color: Colors.black12,
          ),
        ),
      ),
    );
  }
}
