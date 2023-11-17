import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

var ss = GroupButtonOptions(
  selectedBorderColor: Colors.pink[900],
  unselectedBorderColor: Colors.amber[900],
  borderRadius: BorderRadius.circular(10),
  spacing: 10,
  runSpacing: 10,
  groupingType: GroupingType.wrap,
  direction: Axis.horizontal,
  buttonHeight: 100,
  buttonWidth: 100,
  mainGroupAlignment: MainGroupAlignment.start,
  crossGroupAlignment: CrossGroupAlignment.start,
  groupRunAlignment: GroupRunAlignment.start,
  textAlign: TextAlign.center,
  textPadding: EdgeInsets.zero,
  alignment: Alignment.center,
  elevation: 0,
);
