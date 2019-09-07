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
    //TODO deal with hidden values (dont add a getter (done), change the value as _v.value in functions)

    //TODO element.constructors take a look if its correct

    final functions = ElementParser.getFunctions(e);
    final functionBodies = functions.join("\n");

    if (e is! ClassElement) {
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the Const annotation from `$name`.', element: e);
    }

    final element = e as ClassElement;

    if (!element.isAbstract) {
      throw InvalidGenerationSourceError(
          'Generator cannot target `$name` since its not an abstract class.',
          todo: 'Make `$name` an abstract class.',
          element: e);
    }

    if (!ElementParser.checkIfInheritedCost(e)) {
      throw InvalidGenerationSourceError(
          'Generator cannot target `$name` which Inherited non const class.',
          todo: 'Add const constructor or @Cost to inherited classes of $name.',
          element: e);
    }

    final allValues = VariableParser.getAllVariablesFrom(element);
    List<String> getterList = List<String>();
    allValues.forEach((variable) {
      final varName = variable[1];
      if (varName[0] != "_") {
        getterList.add("get $varName => _values.${varName};");
      }
    });
    final allGetters = getterList.join("\n");
    final allDefines = allValues
        .map((variable) {
          final varType = variable[0];
          final varName =
              variable[1][0] != "_" ? variable[1] : variable[1].substring(1);
          return "final $varType $varName;";
        })
        .toList()
        .join("\n");
    final allConst = allValues
        .map((variable) {
          final varName =
              variable[1][0] != "_" ? variable[1] : variable[1].substring(1);
          return "this.$varName,";
        })
        .toList()
        .join("\n");

    final allConstWrapped = allValues.length > 0 ? "{$allConst}" : allConst;

    return """
    class _\$$name implements $name{
      final ${name}Values _values;
      
      const _\$${name}(${name}Values v)
        :this._values=v;
      $functionBodies

      //Getters
      $allGetters
    }

    //Values
    class ${name}Values{
      //Define variables with types
      $allDefines

      //Write const constructor
      const ${name}Values($allConstWrapped);
    }
    """;
  }
}
