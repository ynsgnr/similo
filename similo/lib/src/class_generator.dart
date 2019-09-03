import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'package:similo_annotations/annotations.dart';

class ClassDefiner extends GeneratorForAnnotation<SimiloBase> {
  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    if (e is! ClassElement) {
      final name = e.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the Const annotation from `$name`.',
          element: e);
    }
    final element = e as ClassElement;
    return """
    class _\$${element.name} implements ${element.name}{
    """;
  }
}

class ClassEncloser extends GeneratorForAnnotation<SimiloBase> {
  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    return """
    } 
    """;
  }
}