
import 'package:example/src/screen_util.dart';
import 'package:similo_annotations/similo_annotations.dart';

part 'example.g.dart';

@Const
abstract class Example{
  final String example;
  final String exampleWithDefault = "this is a default value";
  final String _hiddenValue = "hidden";

  @ScallableWith(Width)
  final double scaleThis;
  
  @NonScallable
  final double dontScaleThis;

  //You can use concreate functions!
  //They will be copied to new class too!
  String testFunction(String toAdd){
    return exampleWithDefault + toAdd;
  }

  String testHiddenFunction(String toAdd){
    return _hiddenValue + toAdd;
  }

  @CopyWith
  Example copyObject(ExampleValues v);

  @Scale
  Example scaleFun(ScreenUtil screenUtil);
  
  const factory Example(ExampleValues v) = _$Example;
}