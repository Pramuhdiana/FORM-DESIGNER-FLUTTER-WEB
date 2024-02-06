// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ProgressDialog extends StatefulWidget {
  const ProgressDialog({super.key});

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _simulateProgress();
  }

  void _simulateProgress() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _progress++;
        if (_progress < 100) {
          _simulateProgress();
        } else {
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              value: _progress / 100, // Set the progress value
            ),
            const SizedBox(height: 20),
            Text(
              'Loading ($_progress%)',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
