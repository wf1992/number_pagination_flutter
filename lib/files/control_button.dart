import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton(
    this.buttonElevation,
    this.buttonRadius,
    this.colorPrimary,
    this.colorBackGround,
    this.icon,
    this.enabled,
    this.onTap,
  );

  final double buttonElevation;
  final double buttonRadius;
  final Color colorPrimary;
  final Color colorBackGround;
  final Widget icon;
  final bool enabled;
  final Function(BuildContext) onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: buttonElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        minimumSize: Size(48, 48),
        foregroundColor: enabled ? colorPrimary : Colors.grey,
        backgroundColor: colorBackGround,
        disabledForegroundColor: colorPrimary,
        disabledBackgroundColor: colorBackGround,
      ),
      onPressed: enabled ? () => onTap(context) : null,
      child: icon,
    );
  }
}
