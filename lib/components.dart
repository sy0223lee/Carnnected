import 'package:flutter/material.dart';

Text text(content, size, weight, colors) {
  return Text(content,
      style: TextStyle(fontSize: size, fontWeight: weight, color: colors));
}