import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';
import 'package:flutter_project_template/app/common/widgets/text_field.dart';
import 'package:get/get.dart';

const double _imgWH = 22.0; // 左侧图片宽高
const double _titleSpace = 100.0; // 左侧title默认宽
const double _cellHeight = 50.0; // 输入、选择样式一行的高度
const double _leftEdge = 15.0; // 内部Widget 左边距 15
const double _rightEdge = 10.0; // 内部Widget 左边距 10
const double _lineLeftEdge = 15.0; // 线 左间距 默认 15
const double _lineRightEdge = 0; // 线 右间距 默认  0
const double _lineHeight = 0.6; // 底部线高
const double _titleFontSize = 15.0;
const double _textFontSize = 15.0;

typedef CommonSetCellClickCallBack = void Function();

class CommonSetCell extends StatelessWidget {
  const CommonSetCell({
    Key? key,
    this.title = '',
    this.leftImgPath,
    this.leftWidget,
    this.text = '',
    this.hiddenArrow = false,
    this.rightWidget,
    this.clickCallBack,
    this.titleWidth = _titleSpace,
    this.titleStyle,
    this.textStyle,
    this.hiddenLine = false,
    this.lineLeftEdge = _lineLeftEdge,
    this.lineRightEdge = _lineRightEdge,
    this.bgColor,
    this.cellHeight = _cellHeight,
    this.leftImgWH = _imgWH,
    this.textAlign = TextAlign.right,
  }) : super(key: key);

  final String title;
  final String? leftImgPath; // 左侧图片路径 ，默认隐藏 ,设置leftImgPath则 leftWidget失效
  final Widget? leftWidget; // 左侧widget ，默认隐藏
  final String? text;
  final Widget? rightWidget; // 右侧widget ，默认隐藏
  final bool hiddenArrow; // 隐藏箭头，默认不隐藏
  final CommonSetCellClickCallBack? clickCallBack;
  final double titleWidth; // 标题宽度
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final bool hiddenLine; // 隐藏底部横线
  final double lineLeftEdge; // 底部横线左侧距离 默认_leftEdge
  final double lineRightEdge; // 底部横线右侧距离 默认0
  final Color? bgColor; // 背景颜色，默认白色
  final double cellHeight; // 底部横线右侧距离 默认_cellHeight
  final double leftImgWH; // 左侧图片宽高，默认_imgWH
  final TextAlign textAlign; // 默认靠右

  @override
  Widget build(BuildContext context) {
    // 默认颜色
    var bgColor = Colors.white;
    var titleColor = Get.isDarkMode ? AppColors.textDark : AppColors.text;
    var titleStyle = TextStyle(fontSize: _titleFontSize, color: titleColor);
    var textColor = Get.isDarkMode ? AppColors.textDark : AppColors.text;
    var textStyle = TextStyle(fontSize: _textFontSize, color: textColor);

    // 设置的颜色优先级高于暗黑模式
    bgColor = bgColor;
    titleStyle = titleStyle;
    textStyle = textStyle;

    return Material(
        // color: bgColor,
        child: InkWell(
      child: Container(
        constraints: BoxConstraints(
            minWidth: double.infinity, // 宽度尽可能大
            minHeight: cellHeight // 最小高度为50像素
            ),
        padding: const EdgeInsets.fromLTRB(_leftEdge, 0, _rightEdge, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          verticalDirection: VerticalDirection.up,
          children: [
            Visibility(
              visible: !hiddenLine,
              child: const Divider(),
            ),
            SizedBox(
              height: cellHeight,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    leftImgPath != null
                        ? Image.asset(
                            leftImgPath!,
                            width: leftImgWH,
                            height: leftImgWH,
                          )
                        : (leftWidget ?? Container()),
                    SizedBox(
                        width: (leftImgPath != null || leftWidget != null)
                            ? 10
                            : 0),
                    Offstage(
                      offstage: title.isEmpty ? true : false,
                      child: Container(
                        width: titleWidth,
                        child: Text(title),
                      ),
                    ),
                    Expanded(
                        child: CommonTextField(
                      text: text,
                      hintText: '',
                      enabled: false,
                      textStyle: textStyle,
                      textAlign: textAlign,
                      border: InputBorder.none,
                    )),
                    rightWidget ?? Container(),
                    Offstage(
                      offstage: hiddenArrow,
                      child: const Icon(Icons.arrow_forward_ios,
                          size: 18, color: Color(0xFFC8C8C8)),
                    ),
                  ]),
            ),
          ],
        ),
      ),
      onTap: () {
        if (clickCallBack != null) {
          clickCallBack!();
        }
      },
    ));
  }
}
