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

class ScaleAnnotation extends SimiloCustom {
  const ScaleAnnotation();
}

class NonScallableAnnotation extends SimiloVariableBase {
  const NonScallableAnnotation();
}
