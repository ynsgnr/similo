import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/element_parser.dart';
import 'package:source_gen/source_gen.dart';
import 'package:similo/src/const_generator.dart';
import 'package:similo/src/copy_with_generator.dart';
import 'package:similo_annotations/annotations.dart';

class ClassDefiner extends GeneratorForAnnotation<SimiloBase> {
  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    if (e is! ClassElement) {
      final name = e.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the Const annotation from `$name`.', element: e);
    }

    final element = e as ClassElement;
    if (!element.isAbstract) {
      final name = e.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Make `$name` an abstract class.', element: e);
    }

    var extendedClass = ElementParser.getExtendedClass(e);
    if (extendedClass != "") extendedClass = "extends " + extendedClass;

    final String className = ElementParser.parseNameFrom(e, annotation);
    final String classContents =
        ConstGenerator().generateForAnnotatedElement(e, annotation, buildStep) +
            CopyWithGenerator()
                .generateForAnnotatedElement(e, annotation, buildStep);
    return """
    class $className $extendedClass implements ${e.name}{
      $classContents
      noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
    }
    """;
  }
}
