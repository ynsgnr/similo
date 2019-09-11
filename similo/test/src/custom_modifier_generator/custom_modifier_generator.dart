import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/annotations.dart';
import 'package:source_gen_test/source_gen_test.dart';

import '../mocks/custom_string.dart';

@ShouldGenerate(r'''TestCustomGen customTest() {
  return copyWith(TestCustomGenValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@Const
abstract class TestCustomGen {
  final String base;
  final CustomString customString;

  @CopyWith
  TestCustomGen copyWith(TestCustomGenValues v);

  @SimiloCustom()
  TestCustomGen customTest();

  const factory TestCustomGen(TestCustomGenValues v) = _$TestCustomGen;
}