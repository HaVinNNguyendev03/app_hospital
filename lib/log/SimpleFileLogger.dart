import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
class SimpleFileLogger {
  late final File logFile;
  final Logger _logger = Logger();

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
     // Kiểm tra và tạo thư mục
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
    logFile = File('${directory.path}/app.log');
  }

  void log(String message, Level level) {
    _logger.log(level, message);
    logFile.writeAsStringSync('$message\n', mode: FileMode.append);
  }
}