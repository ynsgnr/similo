import 'package:similo_annotations/annotations.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';

class ElementParser {

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
