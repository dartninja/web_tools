import 'package:angular/angular.dart';
import 'package:dart_tools/app_component.template.dart' as ng;
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

void main() {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
    if(rec.error!=null) {
      print(rec.error.toString());
    }
    if(rec.stackTrace!=null) {
      print(Trace.format(rec.stackTrace));
    }
  });

  runApp(ng.AppComponentNgFactory);
}
