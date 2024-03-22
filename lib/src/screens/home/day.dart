import 'package:flutter/material.dart';

class DayModel {
  final String day;
  final bool? disabled;
  final String amlich;
  final Color? color;
  final bool border;
  DayModel({
    required this.day,
    this.disabled,
    required this.amlich,
    this.color,
    required this.border,
  });
}
