import 'package:similo/src/copy_with_generator.dart';
import 'package:similo/src/scale_generator.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class CodeParser {
  static String getFunctionSignature(Element element) {
    var content = getClassCode(element);
    var splitted = content.split("${element.name}(");
    if (splitted.length < 2) return element.name;
    splitted = splitted[1].split(")");
    if (splitted.length < 2) return element.name;

    var functionDefine = element.toString().split("(")[0];
    var variables = splitted[0];
    return "$functionDefine($variables)";
  }

  static String getFirstLevel(ClassElement element) {
    var content = getClassCode(element);
    if (content.indexOf("{") < 0 || content.lastIndexOf("}") < 0)
      return content;
    return content.substring(0, content.indexOf("{")) +
        content.substring(content.lastIndexOf("}"));
  }

  static String getDefaultValueFor(ClassElement element, String value,
      {String firstLevelContent}) {
    var levelContent = firstLevelContent ?? getFirstLevel(element);
    var splitted = levelContent.split(";");
    var i = 0;
    List<String> possible;
    while (i != -1 && i < splitted.length) {
      possible = splitted[i].split(value);
      i++;
      if (possible.length > 1 &&
          possible[1].trim().isNotEmpty &&
          possible[1].trim()[0] == "=") {
        i = -1;
      }
    }
    if (i != -1) return "";
    splitted = possible[1].trim().split("=");
    if (splitted.length <= 1) return "";
    return splitted[1];
  }

  static String getTypeFor(ClassElement element, String value,
      {String firstLevelContent}) {
    var levelContent = firstLevelContent ?? getFirstLevel(element);
    var splitted = levelContent.split(";");
    var i = 0;
    List<String> possible;
    while (i != -1 && i < splitted.length) {
      possible = splitted[i].split(value);
      i++;
      if (possible.length > 1) {
        i = -1;
      }
    }
    if (i != -1) return "dynamic";
    return possible[0].replaceAll("final", "").replaceAll("const", "").trim();
  }

  static List<String> getFunctions(
    ClassElement element,
  ) {
    if (element.methods.length == 0) return List<String>();
    final name = element.name;

    var contents = getClassCode(element);
    var functions = element.methods;
    var bodies = List<String>();
    functions.forEach((function) {
      //TODO find a way to check function builders
      if (function.metadata.any((m) =>
          m.element.toString().split(" ")[0] == SimiloBase.COPYWITHCLASS)) {
        bodies.add(
            CopyWithGen().generateForAnnotatedElement(element, null, null));
      } else if (function.metadata.any(
          (m) => m.element.toString().split(" ")[0] == SimiloBase.SCALECLASS)) {
        bodies.add(ScaleGen().generateForAnnotatedElement(element, null, null));
      } else {
        var f = function.toString();
        var splitted = contents.split(f);
        if (splitted.length <= 1 || splitted[1].trim()[0] != "{") {
          throw InvalidGenerationSourceError(
              'Generator cannot target `$name` since it has a function without a body.',
              todo: 'Add a body to missing function',
              element: element);
        }
        var body = getBetween(splitted[1], "{", "}");
        bodies.add("$f{\n$body}");
      }
    });
    return bodies;
  }

  static String getClassCode(Element e) {
    //var contents = await buildStep.readAsString(buildStep.inputId);
    ClassElement element;
    if (e is ClassElement) {
      element = e;
    } else if (e.enclosingElement is ClassElement) {
      element = e.enclosingElement;
    } else {
      throw InvalidGenerationSourceError(
          'Generator cannot target `${e.name}` since its unable to reach parent class.',
          todo: 'Check parent class',
          element: element);
    }
    var contents =
        element.source.contents.data; //Using this might cause problems
    var splitted = contents.split(element.toString());
    if (splitted.length <= 1) {
      throw InvalidGenerationSourceError(
          'Generator cannot target `${element.name}` since it has an invalid class definition.',
          todo: 'Fix class definition',
          element: element);
    }
    return getBetween(splitted[1], "{", "}");
  }

  //Gets between indicators with a stack
  //ignores elements inside root element and returns the first parent element
  static String getBetween(
      String content, String startIndicator, String stopIndicator) {
    assert(startIndicator.length == 1 || stopIndicator.length == 1,
        "Indicators must have one character");
    assert(startIndicator != stopIndicator,
        "Start and stop indicators must be different");
    var stackCounter = 0;
    var stopIndex = 0;
    var startIndex = -1;
    var i = 0;
    while (i < content.length) {
      if (content[i] == startIndicator) {
        if (startIndex == -1) {
          startIndex = i;
        }
        stackCounter++;
      } else if (content[i] == stopIndicator && startIndex != -1) {
        stackCounter--;
      }
      if (stackCounter == 0 && startIndex != -1) {
        stopIndex = i;
        i = content.length;
      }
      i++;
    }
    if (startIndex == -1) return '';
    return content.substring(startIndex + 1, stopIndex);
  }
}
