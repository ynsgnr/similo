import 'package:analyzer/dart/element/element.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';

class ClassParser {
  static List<String> getClassAndValueNames(ClassElement classElement) {
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
    return [className, valuesName];
  }

  static List<Element> getFunctionAndClass(Element e, String byAnnotationName) {
    Element element;
    ClassElement classElement;
    if (e is! FunctionElement && e is! MethodElement) {
      if (e is! ClassElement) {
        throw InvalidGenerationSourceError(
        'Copy generator cannot target `${e.name}` since it is not a function.',
        todo: 'Remove the Const annotation from `${e.name}`.',
        element: e);
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

  static bool checkIfInheritedConst(Element element) {
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

  static bool checkIfConst(ClassElement element) {
    return checkIfInheritedConst(element) && element.unnamedConstructor.isConst;
  }
}
