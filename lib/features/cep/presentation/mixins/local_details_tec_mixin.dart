import 'package:flutter/material.dart';

mixin LocalDetailsTECMixin {
  final stateTEC = TextEditingController();
  final cityTEC = TextEditingController();
  final streetTEC = TextEditingController();

  void onDispose() {
    stateTEC.dispose();
    cityTEC.dispose();
    streetTEC.dispose();
  }
}
