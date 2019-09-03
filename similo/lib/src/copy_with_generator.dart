import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:similo/src/variable_parser.dart';
import 'package:source_gen/source_gen.dart';

import 'package:similo_annotations/annotations.dart';

class CopyWithGenerator extends GeneratorForAnnotation<SimiloBase> {
  @override
  String generateForAnnotatedElement(
      Element e, ConstantReader annotation, BuildStep buildStep) {
    
    print("CopyWith");
    int type = annotation.peek(SimiloEnums.TYPE).intValue;
    print(type);
    type = type & SimiloEnums.COPYWITH;
    print(type);
    if(type!=SimiloEnums.COPYWITH){return "";}


    return """
    
    //Lel
    
    """;

  }
}