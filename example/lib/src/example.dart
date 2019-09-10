
import 'package:similo_annotations/annotations.dart';

part 'example.g.dart';

@Const
abstract class Example{
  final String example;
  final String exampleWithDefault = "this is a default value";
  final String _hiddenValue = "hidden";

  //You can use concreate functions!
  //They will be copied to new class too!
  String testFunction(String toAdd){
    return example + toAdd;
  }

  String testHiddenFunction(String toAdd){
    return _hiddenValue + toAdd;
  }

  @CopyWith
  Example copyObject(ExampleValues v);
  
  const factory Example(ExampleValues v) = _$Example;
}