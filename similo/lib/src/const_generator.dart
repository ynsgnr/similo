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

    final className = ElementParser.parseNameFrom(e, annotation);
    final elementInstanceFields = VariableParser.getAllVariablesFrom(e);
    final constSuper = ElementParser.getConstSuperFrom(e);
    final elements = elementInstanceFields.map((element)=>element[1]);
    if(elements.isEmpty){
      return "const $className();";
    }
    final elementsFinal = elements.map((element)=>"final $element;").join("\n");
    final elementsComma = elements.map((element)=>"this.$element,").join("\n");

    //TODO check if values initilized in base class and if initilized use :
    //TODO check if super has const constructor
    //TODO deal with hidden variabls

    //Overrites already set values

    return """
      $elementsFinal
      const $className({
        $elementsComma});
    """;

  }
}