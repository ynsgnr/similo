import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';
import 'package:source_gen/source_gen.dart';

class ElementParser {
  static Future<List<String>> getFunctions(
      ClassElement element, BuildStep buildStep) async {
    if (element.methods.length == 0) return List<String>();
    final name = element.name;
    final error = InvalidGenerationSourceError(
        'Generator cannot target `$name` since it has a function without a body.',
        todo: 'Add a body to missing function',
        element: element);

    //TODO use get class contents
    var contents = await buildStep.readAsString(buildStep.inputId);

    var functions = element.methods.map((m) => m.toString()).toList();
    var bodies = List<String>();
    functions.forEach((f) {
      //Parse the function body
      var splitted = contents.split(f);
      if (splitted.length == 0) {
        throw error;
      }
      splitted = splitted[1].split("{");
      if (splitted.length == 0) {
        throw error;
      }

      //Cant use this method because there might me other paranthesises inside function
      var body = splitted[1].split("}")[0];
      print(body);
      bodies.add("$f{\n$body}");
    });
    return bodies;
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
