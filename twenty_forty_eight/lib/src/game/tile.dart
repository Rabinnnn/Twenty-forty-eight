import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final int value;
  const TileWidget({super.key, required this.value});

  Color _tileColor() {
    switch (value) {
      case 2:
        return const Color(0xffeee4da);
      case 4:
        return const Color(0xffede0c8);
      case 8:
        return const Color(0xfff2b179);
      case 16:
        return const Color(0xfff59563);
      case 32:
        return const Color(0xfff67c5f);
      case 64:
        return const Color(0xfff65e3b);
      case 128:
        return const Color(0xffedcf72);
      case 256:
        return const Color(0xffedcc61);
      case 512:
        return const Color(0xffedc850);
      case 1024:
        return const Color(0xffedc53f);
      case 2048:
        return const Color(0xffedc22e);
      default:
        return const Color(0xff3c3a32);
    }
  }

  TextStyle _textStyle() {
    if (value <= 4) return const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xff776e65));
    if (value < 1024) return const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tileColor(),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: value == 0 ? const SizedBox() : Text('$value', style: _textStyle()),
      ),
    );
  }
}
