import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/variable_parser.dart';
import 'package:source_gen/source_gen.dart';

import 'package:similo_annotations/annotations.dart';

class CopyWithGenerator extends GeneratorForAnnotation<CopyWith> {
  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {

    return """
    
    //Lel
    
    """;

  }
}