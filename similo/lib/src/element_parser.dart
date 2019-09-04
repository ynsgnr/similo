import 'package:similo_annotations/annotations.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';

class ElementParser {
  static parseNameFrom(Element e, ConstantReader annotation) {
    return annotation.peek(SimiloEnums.CLASSNAME) != null
        ? annotation.peek(SimiloEnums.CLASSNAME).stringValue
        : "_\$" + e.name;
  }
}
