import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/parsers/class_parser.dart';
import 'package:similo/src/parsers/code_parser.dart';
import 'package:similo/src/parsers/variable_parser.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class CustomModifier extends GeneratorForAnnotation<SimiloBase> {
  final Map<String,String Function(String)> modifiers;

  const CustomModifier(this.modifiers);

  @override
  generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    var elements = ClassParser.getFunctionAndClass(e, SimiloBase.CUSTOMCLASS);
    var element = elements[0];
    var classElement = elements[1];
    if (element == null || classElement == null) return "";

    var valuesName = ClassParser.getClassAndValueNames(classElement)[1];

    var copyWith = ClassParser.getFunctionAndClass(e, SimiloBase.COPYWITHCLASS)[0];
    if(copyWith==null){
      throw InvalidGenerationSourceError(
        'Custom generator cannot target `${e.name}` since it is not a part of class with copy function.',
        todo: 'Add a @CopyWith annotation and create a copy function for the class`.',
        element: e);
    }

    final variables =
        VariableParser.getAllVariablesDefaultsFrom(classElement);
    List<String> allModifiers = List<String>();
    variables
        .forEach((v) {
          if(modifiers.containsKey(v[0])){
            final variableName = v[1];
            final customSet = modifiers[v[0]](variableName);
            allModifiers.add(
              "$variableName: $customSet,"
            );
          }
        });
    final allSet = allModifiers.join("\n");
    final function = element.toString().contains("dynamic") ? CodeParser.getFunctionSignature(element)  : element.toString() ;

    return """$function{
      return ${copyWith.name} ($valuesName(
        $allSet
      ));
    }
    """;
  }
}
