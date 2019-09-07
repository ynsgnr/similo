import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';
import 'package:source_gen/source_gen.dart';

class ElementParser {
  static List<String> getFunctions(
    ClassElement element,
  ) {
    if (element.methods.length == 0) return List<String>();
    final name = element.name;
    final error = InvalidGenerationSourceError(
        'Generator cannot target `$name` since it has a function without a body.',
        todo: 'Add a body to missing function',
        element: element);

    var contents = getClassCode(element);
    var functions = element.methods.map((m) => m.toString()).toList();
    var bodies = List<String>();
    functions.forEach((f) {
      //Parse the function body
      var splitted = contents.split(f);
      if (splitted.length <= 1) {
        throw error;
      }
      if (splitted[1][0] != "{") {
        throw error;
      }
      var body = getBetween(splitted[1], "{", "}");
      bodies.add("$f{\n$body}");
    });
    return bodies;
  }

  static String getClassCode(ClassElement element) {
    //var contents = await buildStep.readAsString(buildStep.inputId);
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

  static bool checkIfInheritedCost(Element element) {
    final map = InheritanceManager(element.library)
        .getMembersInheritedFromClasses(element);
    bool inheritedCost = true;
    map.keys.forEach((key) {
      if (map[key].kind == ElementKind.GETTER && map.containsKey(key + "=")) {
        inheritedCost = false;
      }
    });
    return inheritedCost;
  }
}
