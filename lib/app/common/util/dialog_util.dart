import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'exports.dart';

class DialogUtil {
  static bool isDialogShowing = false;
  static BuildContext? alertContext;
  static String defaultTitle = Strings.appName;
  static Future<T?> confirm<T>(
    BuildContext context,
    Widget content, {
    String? title,
    String? cancelText,
    String? submitText,
    Function? onCancel,
    Function? onSubmit,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          useRootNavigator: false,
          builder: (context) {
            return _alertConfirm(
              context,
              content,
              title: title,
              cancelText: cancelText,
              submitText: submitText,
              onCancel: onCancel,
              onSubmit: onSubmit,
            );
          });
    }
    return showDialog<T>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? defaultTitle),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          content: content,
          actions: <Widget>[
            TextButton(
                child: Text(cancelText ?? 'Hủy bỏ'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) {
                    onCancel();
                  }
                }),
            TextButton(
              child: Text(submitText ?? Strings.confirm),
              onPressed: () {
                Navigator.of(context).pop();
                if (onSubmit != null) {
                  onSubmit();
                }
              },
            )
          ],
        );
      },
    );
  }

  static Future<T?> options<T>(
    BuildContext context, {
    String? title,
    List<T>? options,
    Widget? Function(T item)? creatorItem,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return _simpleOptions<T>(
            context,
            title: title,
            options: options,
            creatorItem: creatorItem,
          );
        },
      );
    }
    return showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: title != null ? Text(title) : null,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          children: options
              ?.map(
                (item) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, item),
                  child: creatorItem?.call(item),
                ),
              )
              .toList(),
        );
      },
    );
  }

  static Future<T?> alert<T>(
    BuildContext context,
    dynamic content, {
    Function? onSubmit,
    String? title,
    String? submit,
    bool? barrierDismissible,
  }) {
    isDialogShowing = true;
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context, useRootNavigator: false,
        barrierDismissible:
            barrierDismissible ?? false, // user must tap button!
        builder: (BuildContext context) {
          alertContext = context;
          return _alert(
            context,
            content,
            onSubmit: onSubmit,
            title: title,
            submit: submit,
          );
        },
      );
    }
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible ?? false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: title?.isNotEmpty == true ? Text(title!) : Text(defaultTitle),
          content: content is String && content.isNotEmpty == true
              ? Text(content)
              : content,
          actions: <Widget>[
            TextButton(
              child: Text(submit ?? 'Closed'),
              onPressed: () {
                isDialogShowing = false;
                Navigator.of(context).pop();
                if (onSubmit != null) {
                  onSubmit();
                }
              },
            )
          ],
        );
      },
    );
  }

  static _alertConfirm(
    BuildContext context,
    Widget content, {
    String? title,
    String? cancelText,
    String? submitText,
    Function? onCancel,
    Function? onSubmit,
  }) {
    return CupertinoAlertDialog(
      title: Text(title ?? defaultTitle),
      content: content,
      actions: <Widget>[
        CupertinoDialogAction(
            child: Text(cancelText ?? 'Huỷ'),
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) {
                onCancel();
              }
            }),
        CupertinoDialogAction(
          child: Text(submitText ?? 'Closed'),
          onPressed: () {
            Navigator.of(context).pop();
            if (onSubmit != null) {
              onSubmit();
            }
          },
        )
      ],
    );
  }

  static _simpleOptions<T>(
    BuildContext context, {
    String? title,
    List<T>? options,
    Widget? Function(T item)? creatorItem,
  }) {
    return CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      actions: options
              ?.map(
                (item) => CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context, item),
                  child: creatorItem?.call(item) ?? Container(),
                ),
              )
              .toList() ??
          [],
    );
  }

  static _alert(
    BuildContext context,
    dynamic content, {
    Function? onSubmit,
    String? title,
    String? submit,
  }) {
    return CupertinoAlertDialog(
      title: title?.isNotEmpty == true ? Text(title ?? '') : Text(defaultTitle),
      content: content is String && content.isNotEmpty == true
          ? Text(content)
          : content,
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(submit ?? 'Closed'),
          onPressed: () {
            isDialogShowing = false;
            Navigator.of(context).pop();
            if (onSubmit != null) {
              onSubmit();
            }
          },
        )
      ],
    );
  }

  static comingSoonMessage(BuildContext context) {
    DialogUtil.alert(
        context, "Chức năng đang phát triển vui lòng thử lại sau.");
  }

  static dismissAlert() {
    if (isDialogShowing == true && alertContext != null) {
      Navigator.pop(alertContext!);
    }
  }

  // static showFlushBar(BuildContext context, String message,
  //     {Color? backgroundColor,
  //     Widget? iconFlushBar,
  //     Duration duration = const Duration(seconds: 2)}) {
  //   Flushbar(
  //     backgroundColor: backgroundColor ?? Colors.green,
  //     flushbarStyle: FlushbarStyle.GROUNDED,
  //     messageColor: Colors.white,
  //     duration: duration,
  //     flushbarPosition: FlushbarPosition.TOP,
  //     icon: iconFlushBar ??
  //         const Icon(
  //           Icons.check_circle_rounded,
  //           color: Colors.white,
  //         ),
  //     message: message,
  //   ).show(context);
  // }

  static Future<T?> confirmSheet<T>(
    BuildContext context, {
    String? title,
    String? content,
    String? cancelText,
    String? submitText,
    Color? submitColor,
    Color? cancelColor,
  }) {
    return showCupertinoModalPopup(
        context: context,
        useRootNavigator: false,
        builder: (popupContext) {
          return CupertinoActionSheet(
            title: Text(
              title ?? defaultTitle,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            message: (content != null && content.isNotEmpty)
                ? Container(
                    alignment: Alignment.center,
                    child: Text(content,
                        style: Theme.of(context).textTheme.caption),
                  )
                : null,
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(popupContext).pop(true);
                },
                child: Text(
                  submitText ?? "Xác nhận",
                  style: TextStyle(
                    color: submitColor ?? const Color(0XFF007AFF),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(popupContext).pop();
              },
              child: Text(
                cancelText ?? "Hủy",
                style: TextStyle(
                  color: cancelColor ?? const Color(0XFF007AFF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        });
  }

  static Future<T?> optionSheet<T>(
    BuildContext context, {
    String? title,
    String? content,
    String? cancelText,
    Color? cancelColor,
    @required List<OptionSheetModel>? options,
  }) {
    return showCupertinoModalPopup(
        context: context,
        useRootNavigator: false,
        builder: (popupContext) {
          return CupertinoActionSheet(
            title: Text(
              title ?? defaultTitle,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            message: (content != null && content.isNotEmpty)
                ? Container(
                    alignment: Alignment.center,
                    child: Text(content,
                        style: Theme.of(context).textTheme.caption),
                  )
                : null,
            actions: options!
                .map<CupertinoActionSheetAction>(
                    (e) => CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.of(popupContext).pop(e.id);
                          },
                          child: Text(
                            e.name,
                            style: TextStyle(
                              color: e.textColor ?? const Color(0XFF007AFF),
                              fontWeight: (e.isBold == true
                                  ? FontWeight.w500
                                  : FontWeight.w400),
                            ),
                          ),
                        ))
                .toList(),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(popupContext).pop();
              },
              child: Text(
                cancelText ?? "Hủy",
                style: TextStyle(
                  color: cancelColor ?? const Color(0XFF007AFF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        });
  }
}

class OptionSheetModel {
  int id;
  String name;
  bool isBold;
  Color? textColor;

  OptionSheetModel(
      {this.id = 0, this.name = "", this.isBold = false, this.textColor});
}
