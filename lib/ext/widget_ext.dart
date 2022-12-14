import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingEach({
    double? l,
    double? t,
    double? r,
    double? b,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: l ?? .0,
        top: t ?? .0,
        right: r ?? .0,
        bottom: b ?? .0,
      ),
      child: this,
    );
  }

  Widget paddingSym({double? h, double? v}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h ?? .0, vertical: v ?? .0),
      child: this,
    );
  }

  Widget flexible({required int flex}) {
    return Flexible(flex: flex, child: this);
  }

  Widget get expand => Expanded(child: this);

  Widget get center => Center(child: this);

  Widget gesture(VoidCallback onTap) => GestureDetector(onTap: onTap, child: this);

  Widget inkwell(VoidCallback onTap) => InkWell(onTap: onTap, child: this);
}
