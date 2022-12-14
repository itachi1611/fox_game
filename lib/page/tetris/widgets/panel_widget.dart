import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({
    super.key,
    required this.child,
    this.topLeft = true,
    this.bottomLeft = true,
    this.topRight = true,
    this.bottomRight = true,
  });

  final Widget child;
  final bool topLeft;
  final bool bottomLeft;
  final bool topRight;
  final bool bottomRight;

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).dividerColor;
    final thickness = Theme.of(context).dividerTheme.thickness!;
    final radius = Radius.circular(thickness);
    return Container(
      constraints: const BoxConstraints(minWidth: 60),
      decoration: BoxDecoration(
        color: dividerColor,
        border: Border.all(color: dividerColor, width: thickness),
        borderRadius: BorderRadius.only(
          topLeft: topLeft ? radius : Radius.zero,
          bottomLeft: bottomLeft ? radius : Radius.zero,
          topRight: topRight ? radius : Radius.zero,
          bottomRight: bottomRight ? radius : Radius.zero,
        ),
      ),
      child: child,
    );
  }
}
