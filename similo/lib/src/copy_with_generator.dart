import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/element_parser.dart';
import 'package:similo/src/variable_parser.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class CopyWithGen extends GeneratorForAnnotation<CopyWithAnnotation> {
  const CopyWithGen();

  @override
  generateForAnnotatedElement(Element e, ConstantReader annotation, BuildStep buildStep) {
    
    if(e is! MethodElement){
      throw InvalidGenerationSourceError('Generator cannot target `${e.name}` since it is not a function.',
          todo: 'Remove the Const annotation from `${e.name}`.', element: e);
    }

    final element = e as MethodElement;
    print(element.name);
    print(element.location);
    print(element.library);
    print(element.enclosingElement);
    print(element.enclosingElement.metadata);
    print(element.enclosingElement.name);
    print(element.enclosingElement.location);
    final classElement = element.enclosingElement as ClassElement;
    final valuesName = "Values"; //TODO get from element parser
    final className = "Class"; //TODO get from element parser
    final variables = VariableParser.getAllVariablesDefaultsFrom(element.enclosingElement);
    print(variables);
    final allSet = variables.map((v)=>"${v[0]}: v.${v[0]}!=${v[2].isEmpty? "null":v[2]} ? v.${v[0]} : this._value.${v[0]}").toList().join("\n");
    print(allSet);

    return """
    ${classElement.name} ${element.name}($valuesName v){
      return $className (TestSomeDefaultValues(
        $allSet
      ))
    }
    """;
  }
}


@ShouldGenerate(r'''
  TestSomeDefault copyWith(TestSomeDefaultValues v){
    return _$TestSomeDefault(TestSomeDefaultValues(
      stringValue: v.stringValue!="test" ? v.stringValue : this._values.stringValue,
      doubleValue: v.doubleValue!=3 ? v.doubleValue : this._values.doubleValue,
      intValue: v.intValue!=null ? v.intValue : this._values.intValue,
      boolValue: v.boolValue!=null ? v.boolValue : this._values.boolValue,
    ))
  }
''')
@Const
abstract class TestSomeDefault {
  final String stringValue = "test";
  final double doubleValue = 3;
  final int intValue;
  final bool boolValue;

  @CopyWith
  TestSomeDefault copyWith(TestSomeDefaultValues v);

  const factory TestSomeDefault(TestSomeDefaultValues b) = _$TestSomeDefault;
}