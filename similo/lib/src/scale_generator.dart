import 'package:similo/src/custom_modifier_generator.dart';
import 'package:similo_annotations/annotations.dart';

class ScaleGen extends CustomModifier {
  ScaleGen():super({
    "TextStyle": (String variableName)=>"""$variableName.copyWith(
        fontSize: screenUtil.setSp(this.$variableName.fontSize),
      )""",
    "EdgeInsets": (String variableName)=>"""EdgeInsets.only(
        left: screenUtil.setWidth($variableName.left),
        right: screenUtil.setWidth($variableName.right),
        top: screenUtil.setHeight($variableName.top),
        bottom: screenUtil.setHeight($variableName.bottom),
      )""",
  },annotationName:SimiloBase.SCALECLASS);
}