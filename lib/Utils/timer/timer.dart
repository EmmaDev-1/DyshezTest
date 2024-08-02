import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int _seconds = 4;
  Timer? _timer;
  bool _isButtonEnabled = false;

  int get seconds => _seconds;
  bool get isButtonEnabled => _isButtonEnabled;

  TimerProvider() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        _isButtonEnabled = true;
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  void resetTimer() {
    _seconds = 4;
    _isButtonEnabled = false;
    _startTimer();
    notifyListeners();
  }
}
