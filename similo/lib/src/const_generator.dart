import 'dart:async';
import 'dart:mirrors';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/element_parser.dart';
import 'package:similo/src/variable_parser.dart';
import 'package:source_gen/source_gen.dart';
import 'package:similo_annotations/annotations.dart';

class ConstGenerator extends GeneratorForAnnotation<SimiloBase> {
  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {

    final int type = annotation.peek(SimiloEnums.TYPE).intValue & SimiloEnums.CONST;
    if(type!=SimiloEnums.CONST){return "";}

    final element = e as ClassElement;
    final String className = ElementParser.parseNameFrom(e, annotation);
    final elementInstanceFields = VariableParser.getAllVariablesFrom(element);
    print(className + " fields: ");
    print(elementInstanceFields);

    return """
    
      final String test;
      const _\$FirstCompileTest({String test,}):this.test=test;
    
    """;

  }
}