import 'dart:convert';

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:angular_components/angular_components.dart';
import 'src/todo_list/todo_list_component.dart';
import 'package:html_unescape/html_unescape.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  providers: [materialProviders],
  directives: [TodoListComponent,materialInputDirectives,
  MaterialTabComponent, MaterialTabPanelComponent, MaterialRadioGroupComponent, MaterialRadioComponent,
    MaterialInputComponent, MaterialMultilineInputComponent
  ],
)
class AppComponent {
  Logger _log = new Logger("AppComponent");
  // Nothing here yet. All logic is in TodoListComponent.

  bool encodeUrl = true, encodeHtml = true;
  String urlInput = "", htmlInput = "";

  String get urlOutput {
    try {
      if (encodeUrl) {
        return Uri.encodeQueryComponent(urlInput);
      } else {
        return Uri.decodeQueryComponent(urlInput);
      }
    } catch(e,st) {
      _log.warning("urlOutput",e,st);
    }
    return "";
  }
  final HtmlEscape _htmlEscape = new HtmlEscape();
  final HtmlUnescape _htmlUnescape = new HtmlUnescape();

  String get htmlOutput {
    try {
      if (encodeHtml) {
        return _htmlEscape.convert(htmlInput);
      } else {
        return _htmlUnescape.convert(htmlInput);
      }
    } catch(e,st) {
      _log.warning("htmlOutput",e,st);
    }
    return "";
  }
}
