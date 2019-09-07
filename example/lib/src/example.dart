
import 'package:similo_annotations/annotations.dart';

part 'example.g.dart';

@Const
abstract class Example{
  final String example;

  //Another way to add functions
  String testFunction(String toAdd){
    return this.example + toAdd;
  }
  
  const factory Example(ExampleValues v) = _$Example;
}

//One way to add functions
class ExampleFunctions extends _$Example{
  const ExampleFunctions(ExampleValues v):super(v);

  String functionInheritence(String toAdd){
    return this.example + toAdd;
  }

}