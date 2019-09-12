import 'package:similo_annotations/src/similo_base.dart';

class ConstAnnotation extends SimiloBase {
  const ConstAnnotation();
}

class CopyWithAnnotation extends SimiloBase {
  const CopyWithAnnotation();
}

class SimiloCustom extends SimiloBase {
  const SimiloCustom();
}

abstract class CustomVariable extends SimiloVariableBase{
  String getModifier (String variableName);

  const CustomVariable();
}

class ScaleAnnotation extends SimiloCustom {
  const ScaleAnnotation();
}

class NonScallableAnnotation extends CustomVariable {
  const NonScallableAnnotation();

  @override
  String getModifier(String variableName) {
    return null;
  }
}
