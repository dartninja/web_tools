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

  String _urlInput = "", _htmlInput = "", _urlOutput = "", _htmlOutput = "";


  void set urlInput(String value) {
    try {
        _urlInput = value;
        _urlOutput = Uri.encodeQueryComponent(value);
    } catch(e,st) {
      _log.warning("urlInput",e,st);
      _urlOutput = "";
    }
  }
  String get urlInput => _urlInput;

  void set urlOutput(String value) {
    try {
      _urlOutput = value;
      _urlInput = Uri.decodeQueryComponent(value);
    } catch(e,st) {
      _log.warning("urlOutput",e,st);
      _urlInput = "";
    }

  }
  String get urlOutput => _urlOutput;

  final HtmlEscape _htmlEscape = new HtmlEscape();
  final HtmlUnescape _htmlUnescape = new HtmlUnescape();


  void set htmlInput(String value) {
    try {
      _htmlInput = value;
      _htmlOutput = _htmlEscape.convert(value);
    } catch(e,st) {
      _log.warning("htmlInput",e,st);
      _htmlOutput= "";
    }
  }
  String get htmlInput => _htmlInput;

  void set htmlOutput (String value) {
    try {
      _htmlOutput= value;
      _htmlInput = _htmlUnescape.convert(value);
    } catch(e,st) {
      _log.warning("htmlOutput",e,st);
      _htmlInput= "";
    }

  }
  String get htmlOutput => _htmlOutput;

}
