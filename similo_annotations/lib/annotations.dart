library similoannotations;

class SimiloBase {

  static const String COPYWITHCLASS = "CopyWithAnnotation";
  static const String CONSTCLASS = "ConstAnnotation";
  static const String CONSTNAMEDCLASS = "ConstNamed";

  const SimiloBase();
}

class ConstAnnotation extends SimiloBase {
  const ConstAnnotation();
}

class CopyWithAnnotation extends SimiloBase {
  const CopyWithAnnotation();
}

class ScaleAnnotation extends SimiloBase {
  const ScaleAnnotation();
}

const Const = ConstAnnotation();
const CopyWith = CopyWithAnnotation();
const Scale = ScaleAnnotation();

class ConstNamed extends ConstAnnotation {
  final String className;
  final String valuesName;

  //These should be same with variable names
  static const CLASSNAME = "className";
  static const VALUESNAME = "valuesName";

  const ConstNamed({String className, String valuesName})
      : this.className = className,
        this.valuesName = valuesName;
}
