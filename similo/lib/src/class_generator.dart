import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/const_generator.dart';
import 'package:similo/src/copy_with_generator.dart';
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
    final String className = annotation.peek(SimiloEnums.CLASSNAME)!=null ? annotation.peek(SimiloEnums.CLASSNAME).stringValue : "_\$" + e.name;
    String classContents = ConstGenerator().generateForAnnotatedElement(e, annotation, buildStep) + CopyWithGenerator().generateForAnnotatedElement(e, annotation, buildStep);
    return """
    class $className implements ${e.name}{
      $classContents
      noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
    }
    """;
  }
}