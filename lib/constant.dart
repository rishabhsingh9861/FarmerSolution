import 'package:flutter/material.dart';

const textsty = TextStyle(
  fontSize: 25,
  color: Colors.black,
);
const textst = TextStyle(
  fontSize: 20,
  color: Colors.black,
);

PreferredSizeWidget appbar = AppBar(
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
  centerTitle: true,
  title: const Text(
    'कृषि समाधान',
    style: textsty,
  ),
);
