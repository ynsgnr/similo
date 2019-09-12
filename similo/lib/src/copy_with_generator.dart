import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/parsers/class_parser.dart';
import 'package:similo/src/parsers/variable_parser.dart';
import 'package:similo_annotations/similo_annotations.dart';
import 'package:source_gen/source_gen.dart';

class CopyWithGen extends GeneratorForAnnotation<SimiloBase> {
  const CopyWithGen();

  @override
  generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    var elements =
        ClassParser.getFunctionAndClass(e, SimiloBase.COPYWITHCLASS);
    var element = elements[0];
    var classElement = elements[1];
    if (element == null || classElement == null) return "";

    var names = ClassParser.getClassAndValueNames(classElement);
    var className = names[0];
    var valuesName = names[1];

    final variables =
        VariableParser.getAllVariablesDefaultsFrom(element.enclosingElement);
    final allSet = variables
        .map((v) {
          final variableName = v[1][0] != "_" ? v[1] : v[1].substring(1);
          final variableDefault = v[2].isEmpty ? "null" : v[2];
          return "$variableName: v.$variableName!=$variableDefault ? v.$variableName : this._values.$variableName,";
        })
        .toList()
        .join("\n");

    return """${classElement.name} ${element.name}($valuesName v){
      return $className ($valuesName(
        $allSet
      ));
    }
    """;
  }
}
