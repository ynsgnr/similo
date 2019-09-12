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

abstract class CustomVariable extends SimiloVariableBase {
  final String modifier;

  const CustomVariable(this.modifier);
}

class ScaleAnnotation extends SimiloCustom {
  const ScaleAnnotation();
}

class NonScallableAnnotation extends CustomVariable {
  final String modifier;

  const NonScallableAnnotation()
      : modifier = "",
        super("");
}
