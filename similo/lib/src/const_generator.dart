import 'dart:async';
import 'dart:mirrors';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/variable_parser.dart';
import 'package:source_gen/source_gen.dart';

import 'package:similo_annotations/annotations.dart';

class ConstGenerator extends GeneratorForAnnotation<Const> {
  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    print(e.name);

    final element = e as ClassElement;

    final elementInstanceFields = VariableParser.getVariablesFrom(element);
    print(elementInstanceFields);
    VariableParser.getInheritedVariablesFrom(element);

    print("------");

    return """
    
      final String test;
      const _\$FirstCompileTest({String test,}):this.test=test;
    
    """;

  }
}