library similoannotations;

class SimiloBase {
  const SimiloBase();
}

class ConstAnnotation extends SimiloBase {
  const ConstAnnotation();
}

class CopyWithAnnotation extends SimiloBase {
  const CopyWithAnnotation();
}

class ScaleAnnotation extends SimiloBase{
  const ScaleAnnotation();
}

const Const = ConstAnnotation();
const CopyWith = CopyWithAnnotation();
const Scale = ScaleAnnotation();