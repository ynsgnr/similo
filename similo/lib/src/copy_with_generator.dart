import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/variable_parser.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class CopyWithGen extends GeneratorForAnnotation<SimiloBase> {
  const CopyWithGen();

  @override
  generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    var notAfunction = InvalidGenerationSourceError(
        'Generator cannot target `${e.name}` since it is not a function.',
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
            if (metadata.element.toString().split(" ")[0] ==
                SimiloBase.COPYWITHCLASS) {
              element = m;
            }
          });
        });
      }
    } else {
      element = e;
      classElement = element.enclosingElement as ClassElement;
    }
    if (element == null || classElement == null)return "";

    String valuesName = "${classElement.name}Values";
    String className = "_\$${classElement.name}";
    classElement.metadata.forEach((m) {
      if (m.element.toString().split(" ")[0] == SimiloBase.CONSTNAMEDCLASS) {
        if(m.constantValue.getField(ConstNamed.VALUESNAME) != null && m.constantValue.getField(ConstNamed.VALUESNAME).toStringValue()!=null){
          valuesName = m.constantValue.getField(ConstNamed.VALUESNAME).toStringValue();
        }
        if(m.constantValue.getField(ConstNamed.CLASSNAME) != null && m.constantValue.getField(ConstNamed.CLASSNAME).toStringValue()!=null){
          className = m.constantValue.getField(ConstNamed.CLASSNAME).toStringValue();
        }
      }
    });
    final variables =
        VariableParser.getAllVariablesDefaultsFrom(element.enclosingElement);
    final allSet = variables
        .map((v) =>
            "${v[1]}: v.${v[1]}!=${v[2].isEmpty ? "null" : v[2]} ? v.${v[1]} : this._values.${v[1]},")
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
