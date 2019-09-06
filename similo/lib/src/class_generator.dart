import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/element_parser.dart';
import 'package:similo/src/variable_parser.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ClassDefiner extends GeneratorForAnnotation<SimiloBase> {

  const ClassDefiner();

  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {

    
    final name = e.name;

    //TODO add CopyWith, Scale

    print(e);

    if (e is! ClassElement) {
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the Const annotation from `$name`.', element: e);
    }

    final element = e as ClassElement;

    if (!element.isAbstract) {
      throw InvalidGenerationSourceError('Generator cannot target `$name` since its not an abstract class.',
          todo: 'Make `$name` an abstract class.', element: e);
    }

    if (!ElementParser.checkIfInheritedCost(e)) {
      throw InvalidGenerationSourceError(
          'Generator cannot target `$name` which Inherited non const class.',
          todo:
              'Add const constructor or @Cost to inherited classes of $name.',
          element: e);
    }

    final allValues = VariableParser.getAllVariablesFrom(element);
    final allGetters = allValues.map((variable){
        final varName = variable[1];
        return "get $varName => _values.${varName};";
    }).toList().join("\n");
    final allDefines = allValues.map((variable){
        final varType = variable[0];
        final varName = variable[1];
        return "final $varType $varName;";
    }).toList().join("\n");
    final allConst = allValues.map((variable){
        final varName = variable[1];
        return "this.$varName,";
    }).toList().join("\n");

    return """
    class _\$$name implements $name{
      final ${name}Values _values;
      
      const _\$${name}(${name}Values v):this._values=v;

      //Getters
      $allGetters
    }

    //Values
    class ${name}Values{
      //Define variables with types
      $allDefines

      //Write const constructor
      const ${name}Values({$allConst});
    }
    """;
  }
}
