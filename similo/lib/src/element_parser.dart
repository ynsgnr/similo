import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';
import 'package:similo/src/copy_with_generator.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ElementParser {
  static List<String> getClassAndValueNames(ClassElement classElement){
    String valuesName = "${classElement.name}Values";
    String className = "_\$${classElement.name}";
    classElement.metadata.forEach((m) {
      if (m.element.toString().split(" ")[0] == SimiloBase.CONSTNAMEDCLASS) {
        if (m.constantValue.getField(ConstNamed.VALUESNAME) != null &&
            m.constantValue.getField(ConstNamed.VALUESNAME).toStringValue() !=
                null) {
          valuesName =
              m.constantValue.getField(ConstNamed.VALUESNAME).toStringValue();
        }
        if (m.constantValue.getField(ConstNamed.CLASSNAME) != null &&
            m.constantValue.getField(ConstNamed.CLASSNAME).toStringValue() !=
                null) {
          className =
              m.constantValue.getField(ConstNamed.CLASSNAME).toStringValue();
        }
      }
    });
    return [className,valuesName];
  }
  static List<Element> getFunctionAndClass(Element e, String byAnnotationName) {
    var notAfunction = InvalidGenerationSourceError(
        'Copy generator cannot target `${e.name}` since it is not a function.',
        todo: 'Remove the Const annotation from `${e.name}`.',
        element: e);
    Element element;
    ClassElement classElement;
    if (e is! FunctionElement || e is! MethodElement) {
      if (e is! ClassElement) {
        throw notAfunction;
      } else {
        classElement = e as ClassElement;
        classElement.methods.forEach((m) {
          m.metadata.forEach((metadata) {
            if (metadata.element.toString().split(" ")[0] == byAnnotationName) {
              element = m;
            }
          });
        });
      }
    } else {
      element = e;
      classElement = element.enclosingElement as ClassElement;
    }
    return [element, classElement];
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

  static List<String> getFunctions(
    ClassElement element,
  ) {
    if (element.methods.length == 0) return List<String>();
    final name = element.name;

    var contents = getClassCode(element);
    var functions = element.methods;
    var bodies = List<String>();
    functions.forEach((function) {
      if (function.metadata.any((m) =>
          m.element.toString().split(" ")[0] == SimiloBase.COPYWITHCLASS)) {
        bodies.add(
            CopyWithGen().generateForAnnotatedElement(element, null, null));
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

  static bool isInheritedConst(Element element) {
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

  static bool isConst(ClassElement element) {
    return isInheritedConst(element) && element.unnamedConstructor.isConst;
  }
}
