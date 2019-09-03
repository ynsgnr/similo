import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart';

class VariableParser {

  //Get variables only inside the class
  static List<List<String>> getVariablesFrom(ClassElement element){
    //TODO find a way to get variable type as string
    return element.fields.where((e) => !e.isStatic).map((e) =>[e.name, e.type.toString()]).toList();
  }
  
  //Get ingerited variables
  static List<List<String>> getInheritedVariablesFrom(ClassElement element){
    final List<List<String>> list = List<List<String>>();
    InheritanceManager(element.library).getMembersInheritedFromClasses(element)
    ..values.forEach((e){
      if(e.kind == ElementKind.GETTER && e.name!="hashCode" && e.returnType!="runtimeType"){
        list.add([e.name.toString(),e.returnType.toString()]);
      }
    });
    return list; 
  }

  static List<List<String>> getAllVariablesFrom(ClassElement element){
    return getVariablesFrom(element) + getInheritedVariablesFrom(element);
  }

}