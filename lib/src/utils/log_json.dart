import 'dart:convert';
import 'package:logger/logger.dart';

final logger = Logger();

void logJson(dynamic data) {
  logger.i(JsonEncoder.withIndent('  ').convert(data));
}
