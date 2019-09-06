import 'package:similo_annotations/annotations.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';

class ElementParser {
  static parseNameFrom(Element e, ConstantReader annotation) {
    return annotation.peek(SimiloEnums.CLASSNAME) != null
        ? annotation.peek(SimiloEnums.CLASSNAME).stringValue
        : "_\$" + e.name;
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

  static String getExtendedClass(Element element, ConstantReader annotation){
    if (annotation.peek(SimiloEnums.EXTEND) != null) return annotation.peek(SimiloEnums.EXTEND).stringValue;
    final extendedClass = element.toString().split(" extends ");
    if(extendedClass.length==1)return "";
    return extendedClass[1].split(" ")[0];
  }
}