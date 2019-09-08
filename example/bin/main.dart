
import '../lib/src/example.dart';

void main(){
  const Example t = const Example(ExampleValues(example: "test"));
  print(t.testFunction(" test "));
  print(t.exampleWithDefault);
}