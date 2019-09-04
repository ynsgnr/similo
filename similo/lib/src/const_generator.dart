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
    final int type =
        annotation.peek(SimiloEnums.TYPE).intValue & SimiloEnums.CONST;
    if (type != SimiloEnums.CONST) {
      return "";
    }
    if (!ElementParser.checkIfInheritedCost(e)) {
      final name = e.name;
      throw InvalidGenerationSourceError(
          'Generator cannot target `$name` which Inherited non const class.',
          todo:
              'Add const constructor or @Cost() to inherited classes of $name.',
          element: e);
    }
    
    final className = ElementParser.parseNameFrom(e, annotation);

    final elements =
        VariableParser.getVariablesFrom(e).map((element) => element[1]);
    final elementsInherited = VariableParser.getInheritedVariablesFrom(e)
        .map((element) => element[1]);
    final elementsSuper =
        elementsInherited.map((element){
          //Remove underscore from inherited values
          //we assume it is set on the constructor
          final name = element[0]=="_" ? element.substring(1) : element;
          return "${name}:${name},";
          }).join("\n");

    if (elements.isEmpty && elementsInherited.isEmpty) {
      return "const $className();";
    } else if (elements.isEmpty) {
      return """const $className():
        super(
            $elementsSuper
        );""";
    }

    List<String> hiddenVariables = List<String>();
    final elementsFinal =
        elements.map((element) => "final $element;").join("\n");
    final elementsComma =
        elements.map((element){
          if (element[0]=="_"){
            hiddenVariables.add("this.$element = ${element.substring(1)},");
            return "${element.substring(1)},";
          }
          return "this.$element,";
        }).join("\n");
    String hidden;
    if(elementsSuper.isEmpty && hiddenVariables.isEmpty){
      hidden="";
    }
    else if(elementsSuper.isEmpty){
      hidden = hiddenVariables.join("\n");
      hidden = hidden.substring(0,hidden.length-1)+";";//Remove comma at the end
    }else{
      hidden = hiddenVariables.join("\n");
    }
    final elementsSuperComma = 
        elementsInherited.map((element)=>"$element,").join("\n");
    final elementsSuperWrapped = elementsSuper.isEmpty ? "" : "super($elementsSuper);";
    final doubleDot = elementsSuper.isEmpty && hiddenVariables.isEmpty ? ";" : ":";

    //TODO deal with get set of hidden variables
    
    return """
      $elementsFinal
      const $className({
        $elementsComma
        $elementsSuperComma
      })$doubleDot
          $hidden$elementsSuperWrapped
    """;
  }
}
