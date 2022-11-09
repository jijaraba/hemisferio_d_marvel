import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.hint,
    this.label,
    this.focusNode,
    this.requiredMessage,
    this.errorText,
    this.maxLines = 1,
    this.isRequired = false,
    this.hasPassword = false,
    this.isDate = false,
    this.isTime = false,
    this.isList = false,
    this.maxLength,
    this.listValue,
    this.inputType = TextInputType.text,
    this.textController,
    this.action = TextInputAction.done,
    this.backgroundColor = Colors.white,
    this.textColor,
    this.borderColor,
    this.focusedColor,
    this.hintColor,
    this.errorColor,
    this.passwordButtonColor,
    this.fontSize = 16,
    this.fontErrorSize = 12,
    this.fontCounterSize = 10,
    this.padding = const EdgeInsets.fromLTRB(12, 14, 12, 14),
    this.capitalization = TextCapitalization.none,
    this.onChange,
    this.onSubmitted,
    this.prefix,
    this.dateFormat,
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  final String? hint;
  final String? label;
  final String? requiredMessage;
  final String? errorText;
  final int maxLines;
  final bool isRequired;
  final bool hasPassword;
  final bool isDate;
  final bool isTime;
  final bool isList;
  final int? maxLength;
  final List<String>? listValue;
  final TextInputType inputType;
  final TextEditingController? textController;
  final TextInputAction action;
  final ValueChanged<String>? onChange;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? focusedColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? passwordButtonColor;
  final double fontSize;
  final double fontErrorSize;
  final double fontCounterSize;
  final EdgeInsets padding;
  final TextCapitalization capitalization;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefix;
  final DateFormat? dateFormat;
  final DateTime? minDate;
  final DateTime? maxDate;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textController = TextEditingController();
  late FocusNode _customFocusNode = FocusNode();

  // Is required
  bool _hasRequired = false;

  // Has password
  bool _isVisiblePassword = false;
  bool _isPasswordActive = false;

  //  Is Date to show calendar on Android and iOS
  DateFormat? _customDateFormat;
  DateTime? _currentDate;

  DateTime? _minimumDate;
  DateTime? _maximumDate;

  late TimeOfDay? _currentTime;

  //Subject Selected
  String _subjectSelected = '';

  @override
  void initState() {
    super.initState();

    _isVisiblePassword = widget.hasPassword;

    if (widget.focusNode != null) _customFocusNode = widget.focusNode!;
    if (widget.textController != null) _textController = widget.textController!;

    if (widget.isDate) {
      _minimumDate = widget.minDate ?? DateTime.now();
      _maximumDate = widget.maxDate ??
          DateTime.now().add(
            const Duration(days: 15),
          );

      _customDateFormat = widget.dateFormat ?? DateFormat('dd/MM/yyyy');
      _currentDate = _minimumDate!.difference(DateTime.now()).inDays >= 0
          ? _minimumDate
          : _maximumDate;
    }

    if (widget.isTime) {
      _customDateFormat = widget.dateFormat ?? DateFormat.jm();
      _currentTime = TimeOfDay.now();
    }

    _customFocusNode.addListener(_configureFocus);
  }

  @override
  void dispose() {
    super.dispose();

    _customFocusNode
      ..removeListener(() => setState(() {}))
      ..dispose();

    if (widget.textController == null) _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return TextField(
      controller: _textController,
      keyboardType: widget.inputType,
      maxLines: widget.maxLines,
      focusNode: _customFocusNode,
      textInputAction: widget.action,
      obscureText: _isVisiblePassword,
      style: TextStyle(color: Colors.white),
      textCapitalization: widget.capitalization,
      onChanged: _onChange,
      onSubmitted: widget.onSubmitted,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor,
        hintText: widget.hint,
        alignLabelWithHint: true,
        hintStyle: TextStyle(
          fontSize: widget.fontSize,
          color: widget.hintColor ?? colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w400,
        ),
        labelText: widget.label,
        labelStyle: textTheme.bodyText1!.copyWith(
          color: _customFocusNode.hasFocus
              ? widget.focusedColor ?? colorScheme.primary
              : null,
        ),
        errorMaxLines: 3,
        errorText: _setMessage(),
        errorStyle: TextStyle(
          fontSize: widget.fontErrorSize,
          color: widget.errorColor ?? colorScheme.error,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorColor ?? colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding: widget.hasPassword
            ? const EdgeInsets.symmetric(horizontal: 10)
            : widget.padding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: widget.borderColor ?? colorScheme.onSurfaceVariant,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? colorScheme.onSurfaceVariant,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.focusedColor ?? colorScheme.primary),
          borderRadius: BorderRadius.circular(4),
        ),
        focusColor: widget.focusedColor ?? colorScheme.primary,
        prefixIcon: widget.prefix,
        prefixIconColor: widget.textColor,
        prefixStyle: TextStyle(
          fontSize: widget.fontErrorSize,
          color: widget.textColor,
        ),
        suffixIcon: _setSuffixIcon(),
      ),
    );
  }

  Widget? _setSuffixIcon() {
    final colorScheme = Theme.of(context).colorScheme;
    return widget.hasPassword
        ? IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.remove_red_eye,
              color: _isPasswordActive
                  ? widget.passwordButtonColor ?? colorScheme.onSurfaceVariant
                  : colorScheme.onSurfaceVariant.withOpacity(1),
              size: 24,
            ),
            onPressed: _visiblePassword,
          )
        : widget.isDate
            ? Icon(
                Icons.calendar_today_outlined,
                color: colorScheme.onSurfaceVariant,
                size: 24,
              )
            : widget.isList
                ? Icon(
                    Icons.arrow_drop_down_outlined,
                    color: colorScheme.onSurfaceVariant,
                    size: 24,
                  )
                : null;
  }

  // Private methods

  void _configureFocus() {
    if (mounted) {
      if (_customFocusNode.hasFocus) {
        if (_customDateFormat != null) {
          _customFocusNode.unfocus();
          if (Platform.isAndroid) {
            if (widget.isDate) {
              _selectDateAndroid(context);
            } else if (widget.isTime) {
              _selectedTimeAndroid(context);
            }
          } else {
            if (widget.isDate) {
              _selectedDateIOS(context);
            } else if (widget.isTime) {
              _selectedTimeIOS(context);
            }
          }
        } else if (widget.isList) {
          _customFocusNode.unfocus();
          _selectedItem(context);
        }
        setState(() => _hasRequired = false);
      } else {
        _validateRequired();
      }
    }
  }

  String? _setMessage() {
    if (_hasRequired) return widget.requiredMessage;
    if (widget.errorText != null) return widget.errorText;
    return null;
  }

  void _validateRequired() {
    setState(() {
      _hasRequired = widget.isRequired && _textController.value.text == '';
    });
  }

  void _visiblePassword() {
    setState(() {
      _isVisiblePassword = !_isVisiblePassword;
      _isPasswordActive = !_isPasswordActive;
    });
  }

  void _onChange(String value) => widget.onChange!(value);

  Future<void> _selectDateAndroid(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _currentDate!,
      firstDate: _minimumDate!,
      lastDate: _maximumDate!,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      _currentDate = pickedDate;
      _setFormatText();
    }

    _validateRequired();
  }

  Future<void> _selectedTimeAndroid(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime!,
    );

    if (pickedTime != null) {
      _currentTime = pickedTime;
      _setFormatText();
    }

    _validateRequired();
  }

  void _selectedDateIOS(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      builder: (_) {
        return _PickerContainerIos(
          onClose: () => _closeIOSPicker(context),
          child: cupertino.SizedBox(
            height: MediaQuery.of(context).size.height / 4.5,
            child: cupertino.DefaultTextStyle(
              style: const TextStyle(fontSize: 22),
              child: cupertino.CupertinoDatePicker(
                mode: cupertino.CupertinoDatePickerMode.date,
                initialDateTime: _currentDate,
                minimumDate: _minimumDate,
                maximumDate: _maximumDate,
                onDateTimeChanged: (DateTime pickedDate) {
                  _currentDate = pickedDate;
                  _setFormatText();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectedTimeIOS(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      builder: (_) {
        final date = DateTime.now();
        return _PickerContainerIos(
          onClose: () => _closeIOSPicker(context),
          child: cupertino.SizedBox(
            height: MediaQuery.of(context).size.height / 4.5,
            child: cupertino.DefaultTextStyle(
              style: const TextStyle(fontSize: 22),
              child: cupertino.CupertinoDatePicker(
                mode: cupertino.CupertinoDatePickerMode.time,
                initialDateTime: DateTime(
                  date.year,
                  date.month,
                  date.day,
                  _currentTime!.hour,
                  _currentTime!.minute,
                ),
                onDateTimeChanged: (DateTime pickedTime) {
                  _currentTime = TimeOfDay.fromDateTime(pickedTime);
                  _setFormatText();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectedItem(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Container(
            alignment: Alignment.center,
            child: ListView.separated(
              itemCount: widget.listValue!.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) => GestureDetector(
                child: Container(
                  padding: EdgeInsets.zero,
                  color: widget.textController!.value.text ==
                          widget.listValue![index]
                      ? colorScheme.primary.withOpacity(0.16)
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.listValue![index],
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: widget.textController!.value.text ==
                                  widget.listValue![index]
                              ? ClipOval(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                )
                              : null,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  _subjectSelected = widget.listValue![index];
                  _textController.text = _subjectSelected;
                  widget.onChange!(_subjectSelected);
                  _hasRequired = false;
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _closeIOSPicker(BuildContext context) {
    _validateRequired();
    Navigator.pop(context);
  }

  void _setFormatText() {
    final finalDate = widget.isDate
        ? _currentDate
        : DateTime.now().fromTimeOfDay(_currentTime!);
    final textDate = _customDateFormat!.format(finalDate!);

    _textController.text = textDate;
    widget.onChange!(textDate);
  }
}

class _PickerContainerIos extends StatelessWidget {
  const _PickerContainerIos({
    Key? key,
    required this.child,
    required this.onClose,
    this.closeText = 'Cerrar',
  }) : super(key: key);

  final Widget child;
  final Function() onClose;
  final String closeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onClose,
              child: cupertino.Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Text(
                  closeText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime fromTimeOfDay(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
