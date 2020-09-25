import 'dart:async';

import 'package:flutter/services.dart';

import 'exclefile/excle_cell_bean.dart';
import 'exclefile/excle_config.dart';
import 'exclefile/excle_writablecellformat.dart';
import 'exclefile/excle_writer_sheet.dart';

class ExclePlugin {
  Map map = new Map();
  List<Map> otherHeader = List();

  //通道
  static const MethodChannel _channel = const MethodChannel('flutter_excle');

  ExclePlugin setHAndByFormatOfCell(List<List<CellEntity>> allList,
      {List<String> titleList,
      WritableCellFormat hderCellFormat,
      WritableCellFormat byCellFormat}) {
    assert(allList != null && allList.isNotEmpty, "内容不能为null或者empty");
    if (titleList == null) {
      titleList = new List();
    }
    if (hderCellFormat == null) {
      hderCellFormat = ExcleConfing.getDefultHeaderCellFormat();
    }
    if (byCellFormat == null) {
      byCellFormat = ExcleConfing.getDefultBodyCellFormat();
    }
    map.clear();
    otherHeader.clear();
    //头部标题
    map["title_list"] = titleList;
    //region excle表标题头
    map["excle_name"] = "Excle头标题!！";
    //endregion

    //region 设置Excle的头布局内容
    Map headerCellFormat = new Map();
    headerCellFormat["fontName"] = hderCellFormat.writerfont.fontName;
    headerCellFormat["fontColor_value"] = hderCellFormat.writerfont.fontColor.i;
    headerCellFormat["fontSBold"] = hderCellFormat.writerfont.fontSBold;
    headerCellFormat["italic"] = hderCellFormat.writerfont.italic;
    headerCellFormat["fontSize"] = hderCellFormat.writerfont.fontSize;
    headerCellFormat["writerBorderLineStyle"] =
        hderCellFormat.writerBorderLineStyle.value;
    headerCellFormat["underLineStyle_value"] =
        hderCellFormat.writerfont.underLineStyle.value;
    headerCellFormat["Alignment_value"] = hderCellFormat.writerAlignment.value;
    headerCellFormat["VerticalExAlignment_value"] =
        hderCellFormat.verticalExAlignment.value;
    headerCellFormat["Border_string"] = hderCellFormat.writerExBorder.string;
    headerCellFormat["Background_value"] =
        hderCellFormat.wirterBackgroundColour.i;
    headerCellFormat["BorderColor_value"] = hderCellFormat.writerBorderColor.i;
    map["headerCellFormat"] = headerCellFormat;
    //endregion

    //region 设置Excle内容的
    Map bodyCellFormat = new Map();
    bodyCellFormat["fontName"] = byCellFormat.writerfont.fontName;
    bodyCellFormat["fontColor_value"] = byCellFormat.writerfont.fontColor.i;
    bodyCellFormat["fontSBold"] = byCellFormat.writerfont.fontSBold;
    bodyCellFormat["italic"] = byCellFormat.writerfont.italic;
    bodyCellFormat["fontSize"] = byCellFormat.writerfont.fontSize;
    bodyCellFormat["writerBorderLineStyle"] =
        byCellFormat.writerBorderLineStyle.value;
    bodyCellFormat["underLineStyle_value"] =
        byCellFormat.writerfont.underLineStyle.value;
    bodyCellFormat["Alignment_value"] = byCellFormat.writerAlignment.value;
    bodyCellFormat["VerticalExAlignment_value"] =
        byCellFormat.verticalExAlignment.value;
    bodyCellFormat["Border_string"] = byCellFormat.writerExBorder.string;
    bodyCellFormat["Background_value"] = byCellFormat.wirterBackgroundColour.i;
    bodyCellFormat["BorderColor_value"] = byCellFormat.writerBorderColor.i;
    map["bodyCellFormat"] = bodyCellFormat;
    //endregion

    //region Excle 表内容
    List contentList = new List<List<Map>>();
    allList.forEach((element) {
      List innerList = new List<Map>();
      element.forEach((inElet) {
        Map map = new Map();
        map["content"] = inElet.content;
        if (inElet.everyCellFormat == null) {
          inElet.everyCellFormat = byCellFormat;
        }
        //region 每一个单元格的内容格式         map["content"]=inElet.content; map["contentCellFormat"]=contentCellformat;
        Map contentCellformat = new Map();
        contentCellformat["fontName"] =
            inElet.everyCellFormat.writerfont.fontName;
        contentCellformat["fontColor_value"] =
            inElet.everyCellFormat.writerfont.fontColor.i;
        contentCellformat["fontSBold"] =
            inElet.everyCellFormat.writerfont.fontSBold;
        contentCellformat["italic"] = inElet.everyCellFormat.writerfont.italic;
        contentCellformat["fontSize"] =
            inElet.everyCellFormat.writerfont.fontSize;
        contentCellformat["writerBorderLineStyle"] =
            inElet.everyCellFormat.writerBorderLineStyle.value;
        contentCellformat["underLineStyle_value"] =
            inElet.everyCellFormat.writerfont.underLineStyle.value;
        contentCellformat["Alignment_value"] =
            inElet.everyCellFormat.writerAlignment.value;
        contentCellformat["VerticalExAlignment_value"] =
            inElet.everyCellFormat.verticalExAlignment.value;
        contentCellformat["Border_string"] =
            inElet.everyCellFormat.writerExBorder.string;
        contentCellformat["Background_value"] =
            inElet.everyCellFormat.wirterBackgroundColour.i;
        contentCellformat["BorderColor_value"] =
            inElet.everyCellFormat.writerBorderColor.i;
        map["contentCellFormat"] = contentCellformat;
        innerList.add(map);
        //endregion
      });
      contentList.add(innerList);
    });
    map["list_string"] = contentList;
    //endregion 内容
    return this;
  }

  Future<ExclePlugin> createExcle() async {
    if (otherHeader.isNotEmpty) {
      map["otherHeader"] = otherHeader;
    }
    final String excle = await _channel.invokeMethod('excle_info', map);
    return this;
  }

  ExclePlugin setExcleFileName(String fileName) {
    map["fileName"] = fileName;
    return this;
  }

  ExclePlugin setSheetName({String sheetName = "sheet1"}) {
    map["sheetName"] = sheetName;
    return this;
  }

  ExclePlugin setOtherHeader(
      {WritableCellFormat hderCellFormat, String headTiltle = ""}) {
    if (hderCellFormat != null) {
      Map headerCellFormat = new Map();
      headerCellFormat["fontName"] = hderCellFormat.writerfont.fontName;
      headerCellFormat["fontColor_value"] =
          hderCellFormat.writerfont.fontColor.i;
      headerCellFormat["fontSBold"] = hderCellFormat.writerfont.fontSBold;
      headerCellFormat["italic"] = hderCellFormat.writerfont.italic;
      headerCellFormat["fontSize"] = hderCellFormat.writerfont.fontSize;
      headerCellFormat["writerBorderLineStyle"] =
          hderCellFormat.writerBorderLineStyle.value;
      headerCellFormat["underLineStyle_value"] =
          hderCellFormat.writerfont.underLineStyle.value;
      headerCellFormat["Alignment_value"] =
          hderCellFormat.writerAlignment.value;
      headerCellFormat["VerticalExAlignment_value"] =
          hderCellFormat.verticalExAlignment.value;
      headerCellFormat["Border_string"] = hderCellFormat.writerExBorder.string;
      headerCellFormat["Background_value"] =
          hderCellFormat.wirterBackgroundColour.i;
      headerCellFormat["BorderColor_value"] =
          hderCellFormat.writerBorderColor.i;
      headerCellFormat["headTiltle"] = headTiltle;
      otherHeader.add(headerCellFormat);
    }
    return this;
  }

  //个性化标题的设置[单元格合并等]
  ExclePlugin setTitleCell(List<WritableSheet> titleCellList) {
    if (titleCellList != null) {
      List innerList = new List<Map>();
      for (int index = 0; index < titleCellList.length; index++) {
        Map map = new Map();
        //Label
        map["Label_c"] = titleCellList[index].label.c;
        map["Label_cont"] = titleCellList[index].label.cont;
        map["Label_r"] = titleCellList[index].label.r;
        //mergeCells
        map["mergeCells_col1"] = titleCellList[index].col1;
        map["mergeCells_row1"] = titleCellList[index].row1;
        map["mergeCells_col2"] = titleCellList[index].col2;
        map["mergeCells_row2"] = titleCellList[index].row2;
        //RowView
        map["setRowView_row"] = titleCellList[index].row;
        map["setRowView_height"] = titleCellList[index].height;

        WritableCellFormat everyTiltleCellFormat =
            titleCellList[index].label.st;
        Map contentCellformat = new Map();
        contentCellformat["fontName"] =
            everyTiltleCellFormat.writerfont.fontName;
        contentCellformat["fontColor_value"] =
            everyTiltleCellFormat.writerfont.fontColor.i;
        contentCellformat["fontSBold"] =
            everyTiltleCellFormat.writerfont.fontSBold;
        contentCellformat["italic"] = everyTiltleCellFormat.writerfont.italic;
        contentCellformat["fontSize"] =
            everyTiltleCellFormat.writerfont.fontSize;
        contentCellformat["writerBorderLineStyle"] =
            everyTiltleCellFormat.writerBorderLineStyle.value;
        contentCellformat["underLineStyle_value"] =
            everyTiltleCellFormat.writerfont.underLineStyle.value;
        contentCellformat["Alignment_value"] =
            everyTiltleCellFormat.writerAlignment.value;
        contentCellformat["VerticalExAlignment_value"] =
            everyTiltleCellFormat.verticalExAlignment.value;
        contentCellformat["Border_string"] =
            everyTiltleCellFormat.writerExBorder.string;
        contentCellformat["Background_value"] =
            everyTiltleCellFormat.wirterBackgroundColour.i;
        contentCellformat["BorderColor_value"] =
            everyTiltleCellFormat.writerBorderColor.i;
        map["title_cell_format"] = contentCellformat;
        innerList.add(map);
      }
      map["title_sheet"] = innerList;
    }
    return this;
  }
}
