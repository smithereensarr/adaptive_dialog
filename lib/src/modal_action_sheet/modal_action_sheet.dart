import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/modal_action_sheet/material_modal_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_modal_action_sheet.dart';

export 'sheet_action.dart';

/// Show modal action sheet, whose appearance is adaptive according to platform

/// The [isDismissible] parameter only works for material style and it specifies
/// whether the bottom sheet will be dismissed when user taps on the scrim.
Future<T?> showModalActionSheet<T>({
  required BuildContext context,
  String? title,
  String? message,
  List<SheetAction<T>> actions = const [],
  String? cancelLabel,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  bool isDismissible = true,
  bool useRootNavigator = true,
  MaterialModalActionSheetConfiguration? materialConfiguration,
  WillPopCallback? onWillPop,
}) {
  void pop(T? key) => Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).pop(key);
  final theme = Theme.of(context);
  return style.isCupertinoStyle(theme)
      ? showCupertinoModalPopup(
          context: context,
          useRootNavigator: useRootNavigator,
          builder: (context) => CupertinoModalActionSheet(
            onPressed: pop,
            title: title,
            message: message,
            actions: actions,
            cancelLabel: cancelLabel,
            onWillPop: onWillPop,
          ),
        )
      : showModalBottomSheet(
          context: context,
          isScrollControlled: materialConfiguration != null,
          isDismissible: isDismissible,
          useRootNavigator: useRootNavigator,
          builder: (context) => MaterialModalActionSheet(
            onPressed: pop,
            title: title,
            message: message,
            actions: actions,
            materialConfiguration: materialConfiguration,
            onWillPop: onWillPop,
          ),
        );
}

@immutable
class MaterialModalActionSheetConfiguration {
  const MaterialModalActionSheetConfiguration({
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.9,
  });
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
}
