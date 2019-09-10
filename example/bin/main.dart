
import '../lib/src/example.dart';

void main(){
  const Example t = const Example(ExampleValues(example: "test"));
  print(t.testFunction(" test "));
  print(t.exampleWithDefault);
  Example t2 = t.copyObject(ExampleValues(exampleWithDefault: "second test"));
  print(t2.example);
  print(t2.exampleWithDefault);
  Example t3 = t.copyObject(ExampleValues(example: "second test"));
  print(t3.example);
  print(t3.exampleWithDefault);
}