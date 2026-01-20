// common/widgets/system_ui_wrapper.dart
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/system_ui_helper.dart';

class SystemUIWrapper extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  const SystemUIWrapper({
    super.key,
    required this.child,
    this.systemUiOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    final overlayStyle = systemUiOverlayStyle ??
        SystemUIHelper.getOverlayStyle(Theme.of(context).brightness);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: child,
    );
  }
}

// Usage in specific screens where you need custom status bar styling
class CustomStatusBarPage extends StatelessWidget {
  const CustomStatusBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      systemUiOverlayStyle:
          SystemUIHelper.getOverlayStyleForColor(AppColors.error),
      child: Scaffold(
        backgroundColor: AppColors.error,
        appBar: AppBar(
          title: Text('Custom Status Bar'),
          backgroundColor: AppColors.error,
        ),
        body: Center(
          child: Text('Custom colored status bar'),
        ),
      ),
    );
  }
}
