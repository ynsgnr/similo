import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/parsers/class_parser.dart';
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
    print(element);
    print(classElement);
    print(modifiers);
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
        VariableParser.getAllVariablesDefaultsFrom(element.enclosingElement);
    List<String> allModifiers = List<String>();
    variables
        .forEach((v) {
          print(v[0]);
          print(modifiers.containsKey(v[0]));
          if(modifiers.containsKey(v[0])){
            final variableName = v[1];
            final customSet = modifiers[v[0]](variableName);
            print("$variableName: $customSet,");
            allModifiers.add(
              "$variableName: $customSet,"
            );
          }
        });
    print(allModifiers);
    final allSet = allModifiers.join("\n");

    return """${element.toString()}{
      return ${copyWith.name} ($valuesName(
        $allSet
      ));
    }
    """;
  }
}
