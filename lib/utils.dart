import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Load [Image] from asset path.
/// https://stackoverflow.com/a/61338308/1321917
Future<ui.Image> loadUiImage(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final list = Uint8List.view(data.buffer);
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(list, completer.complete);
  return completer.future;
}

late Color _pickedColor;

// raise the [showDialog] widget
Future<Color?> pickColor({
  required BuildContext context,
  Color? pickerColor,
}) =>
    showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor ?? Colors.orange,
              onColorChanged: (color) => _pickedColor = color,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop(_pickedColor);
              },
            ),
          ],
        );
      },
    );
