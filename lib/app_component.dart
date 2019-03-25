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

  String _input = "", _urlOutput = "", _htmlOutput = "", _b64Output = "";
  String urlError = "", htmlError = "", b64Error = "";

  void set input(String value) {
    _log.fine("input");
    _input = value;

    updateOutputs();
  }
  String get input => _input;


  void updateOutputs({String skip = ""}) {
    if(skip!="url") {
      try {
        _urlOutput = Uri.encodeQueryComponent(_input);
      } catch (e, st) {
        _log.warning("updateOutputs url", e, st);
        _urlOutput = "";
      }
    }

    if(skip!="html") {
      try {
        _htmlOutput = _htmlEscape.convert(_input);
      } catch (e, st) {
        _log.warning("updateOutputs html", e, st);
        _htmlOutput = "";
      }
    }

    if(skip!="b64") {
      try {
        _b64Output = base64.encode(utf8.encode(_input));
      } catch (e, st) {
        _log.warning("updateOutputs b64", e, st);
        _htmlOutput = "";
      }
    }

  }

  void set urlOutput(String value) {
    _log.fine("urlOutput");
    try {
      _urlOutput  = value;
      urlError = "";
      _input  = Uri.decodeQueryComponent(value);
      updateOutputs(skip: "url");
    } catch(e,st) {
      _log.warning("urlOutput",e,st);
      urlError = e.toString();
    }

  }
  String get urlOutput => _urlOutput;

  final HtmlEscape _htmlEscape = new HtmlEscape();
  final HtmlUnescape _htmlUnescape = new HtmlUnescape();



  void set htmlOutput (String value) {
    _log.fine("htmlOutput");
    try {
      _htmlOutput= value;
      htmlError = "";
      _input  = _htmlUnescape.convert(value);
      updateOutputs(skip: "html");
    } catch(e,st) {
      _log.warning("htmlOutput",e,st);
      htmlError = e.toString();
    }

  }
  String get htmlOutput => _htmlOutput;


  void set b64Output (String value) {
    _log.fine("b64Output");
    try {
      _b64Output = value;
      b64Error = "";
      _input = utf8.decode(base64.decode(value));
      updateOutputs(skip: "b64");
    } catch(e,st) {
      _log.warning("htmlOutput",e,st);
      b64Error = e.toString();
    }

  }
  String get b64Output => _b64Output;

}
