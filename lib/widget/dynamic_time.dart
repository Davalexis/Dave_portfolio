import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DynamicTime extends StatefulWidget {
  const DynamicTime({super.key, required this.textSize});

  final double textSize;

  @override
  State<DynamicTime> createState() => _DynamicTimeState();
}

class _DynamicTimeState extends State<DynamicTime> {
  late Stream<DateTime> _timeStream;
  late StreamSubscription<DateTime> _timeSubscription;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timeStream = Stream.periodic(const Duration(seconds: 1), (count) {
      return DateTime.now();
    });
    _timeSubscription = _timeStream.listen((time) {
      if (mounted) {
        setState(() {
          _currentTime = time;
        });
      }
    });
  }

  @override
  void dispose() {
    _timeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('h:mm:ss a').format(_currentTime),
      style: GoogleFonts.inter(
        fontSize: widget.textSize - 1,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
