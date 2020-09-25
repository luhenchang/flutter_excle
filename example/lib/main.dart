import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_excle/exclefile/excle_cell_bean.dart';
import 'package:flutter_excle/exclefile/excle_color.dart';
import 'package:flutter_excle/exclefile/excle_writablecellformat.dart';
import 'package:flutter_excle/exclefile/excle_writablefont.dart';
import 'package:flutter_excle/exclefile/excle_writer_sheet.dart';
import 'package:flutter_excle/flutter_excle.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    requestPermission();
  }
  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    await PermissionHandler().requestPermissions([PermissionGroup.location,PermissionGroup.storage]);
    // 申请结果
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    PermissionStatus permissionTow = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted||permissionTow == PermissionStatus.granted) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }

  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {} on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: InkWell(
              onTap:(){
                createAndSharedExcle();
              },
          child: Text('Running on: $_platformVersion\n'),
        )),
      ),
    );
  }

  Future<void> createAndSharedExcle() async {
    var headfont = WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD,
        c: ExcleColour.WHITE);
    WritableCellFormat headerWritableCellFormat = WritableCellFormat(headfont)
        .setExAlignment(ExAlignment.CENTRE)
        .setVerticalExAlignment(VerticalExAlignment.CENTRE)
        .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
        colour: ExcleColour.GREEN)
        .setBackground(ExcleColour.DARK_PURPLE);

    var headfont2 = WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD,
        c: ExcleColour.RED);
    WritableCellFormat headerWritableCellFormat2 = WritableCellFormat(headfont2)
        .setExAlignment(ExAlignment.CENTRE)
        .setVerticalExAlignment(VerticalExAlignment.CENTRE)
        .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
        colour: ExcleColour.GREEN)
        .setBackground(ExcleColour.DARK_PURPLE);

    var titlefont = WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD,
        c: ExcleColour.WHITE);
    WritableCellFormat titleWritableCellFormat = WritableCellFormat(titlefont)
        .setExAlignment(ExAlignment.CENTRE)
        .setVerticalExAlignment(VerticalExAlignment.CENTRE)
        .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
        colour: ExcleColour.GREEN)
        .setBackground(ExcleColour.LIGHT_ORANGE);

    WritableCellFormat otherHeaderWritableCellFormat =
    WritableCellFormat(headfont)
        .setExAlignment(ExAlignment.CENTRE)
        .setVerticalExAlignment(VerticalExAlignment.CENTRE)
        .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
        colour: ExcleColour.RED)
        .setBackground(ExcleColour.ROSE);

    var bodyfont = WritableFont(WritableFont.TIMES, 8, WritableFont.NO_BOLD,
        c: ExcleColour.BLACK);
    WritableCellFormat bodyWritableCellFormat = WritableCellFormat(bodyfont)
        .setExAlignment(ExAlignment.CENTRE)
        .setVerticalExAlignment(VerticalExAlignment.CENTRE)
        .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
        colour: ExcleColour.GRAY_50)
        .setBackground(ExcleColour.WHITE);

    List<String> titleList = [
      "姓名",
      "年龄",
      "性别",
      "成绩",
      "预算价值(元)",
      "其中:工资",
    ];
    List<List<CellEntity>> allList = new List();
    List<CellEntity> oneList = [
      CellEntity(
        "张治国",
        everyCellFormat: getOneCell3(),
      ),
      CellEntity(
        "22",
        everyCellFormat: getOneCell2(),
      ),
      CellEntity(
        "男",
        everyCellFormat: getOneCell(),
      ),
      CellEntity(
        "123",
        everyCellFormat: getOneCell2(),
      ),
      CellEntity(
        "天津大道武清区天津职业技术师范大学",
        everyCellFormat: getOneCell(),
      ),
      CellEntity(
        "嗯呢",
        everyCellFormat: getOneCell3(),
      ),
      CellEntity(
        "啦啦啦",
        everyCellFormat: getOneCell2(),
      ),
      CellEntity(
        "我啦",
        everyCellFormat: getOneCell(),
      )
    ];
    List<CellEntity> twoList = [
      CellEntity(
        "王国爽",
        everyCellFormat: getOneCell3(),
      ),
      CellEntity("19"),
      CellEntity("男"),
      CellEntity("133️", everyCellFormat: getOneCell3()),
      CellEntity("河南大道武清区"),
      CellEntity("嗯呢"),
      CellEntity("啦啦啦", everyCellFormat: getOneCell3()),
      CellEntity("我啦")
    ];
    List<CellEntity> threeList = [
      CellEntity(
        "江山河",
        everyCellFormat: getOneCell3(),
      ),
      CellEntity("21", everyCellFormat: getOneCell3()),
      CellEntity("女"),
      CellEntity("89"),
      CellEntity("甘肃江大核战区", everyCellFormat: getOneCell2()),
      CellEntity("嗯呢"),
      CellEntity("啦啦啦"),
      CellEntity("我啦", everyCellFormat: getOneCell())
    ];
    List<CellEntity> fourList = [
      CellEntity(
        "李大奖",
        everyCellFormat: getOneCell3(),
      ),
      CellEntity("13"),
      CellEntity("女"),
      CellEntity("121"),
      CellEntity("江西江区"),
      CellEntity("嗯呢"),
      CellEntity("啦啦啦"),
      CellEntity("我啦")
    ];
    List<CellEntity> fiveList = [
      CellEntity(
        "谭大祖",
        everyCellFormat: getOneCell3(),
      ),
      CellEntity("21"),
      CellEntity("女"),
      CellEntity("144"),
      CellEntity("甘肃内江罕见区"),
      CellEntity("嗯呢"),
      CellEntity("啦啦啦"),
      CellEntity("我啦")
    ];
    List<CellEntity> sixList = [
      CellEntity(
        "盒啦",
        everyCellFormat: getOneCell2(),
      ),
      CellEntity("23"),
      CellEntity("女"),
      CellEntity("133"),
      CellEntity("甘肃江大核战区"),
      CellEntity("嗯呢"),
      CellEntity("啦啦啦"),
      CellEntity("我啦")
    ];
    List<CellEntity> sevenList = [
      CellEntity(
        "来河",
        everyCellFormat: getOneCell3(),
      ),
      CellEntity("21"),
      CellEntity("女", everyCellFormat: getOneCell2()),
      CellEntity("89"),
      CellEntity("浙江和昂州区", everyCellFormat: getOneCell3()),
      CellEntity("嗯呢"),
      CellEntity("啦啦啦"),
      CellEntity("我啦")
    ];
    allList.add(oneList);
    allList.add(twoList);
    allList.add(threeList);
    allList.add(fourList);
    allList.add(fiveList);
    allList.add(sixList);
    allList.add(sevenList);

    List titleCellList = new List<WritableSheet>();
    WritableSheet sheet1 = WritableSheet.Builder()
        .addCell(Label(0, 3, "单位估价", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(0, 3, 0, 4);

    WritableSheet sheet2 = WritableSheet.Builder()
        .addCell(Label(1, 3, "工程和费用名称", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(1, 3, 1, 4);
    WritableSheet sheet3 = WritableSheet.Builder()
        .addCell(Label(2, 3, "单位", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(2, 3, 2, 4);

    WritableSheet sheet4 = WritableSheet.Builder()
        .addCell(Label(3, 3, "数量", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(3, 3, 3, 4);

    //第二块
    WritableSheet sheet5 = WritableSheet.Builder()
        .addCell(Label(4, 3, "预算价值", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(4, 3, 5, 3);

    WritableSheet sheet6 = WritableSheet.Builder()
        .addCell(Label(4, 4, "单价", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(4, 4, 4, 4);

    WritableSheet sheet7 = WritableSheet.Builder()
        .addCell(Label(5, 4, "总价", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(5, 4, 5, 4);

    //作为  一块
    WritableSheet sheet8 = WritableSheet.Builder()
        .addCell(Label(6, 3, "其中工资:", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(6, 3, 7, 3);

    WritableSheet sheet9 = WritableSheet.Builder()
        .addCell(Label(6, 4, "单位估价费", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(6, 4, 6, 4);

    WritableSheet sheet10 = WritableSheet.Builder()
        .addCell(Label(7, 4, "合计", getOneCell2()))
        .setRowView(3, 350)
        .mergeCells(7, 4, 7, 4);

    titleCellList.add(sheet1);
    titleCellList.add(sheet2);
    titleCellList.add(sheet3);
    titleCellList.add(sheet4);
    titleCellList.add(sheet5);
    titleCellList.add(sheet6);
    titleCellList.add(sheet7);
    titleCellList.add(sheet8);
    titleCellList.add(sheet9);
    titleCellList.add(sheet10);

    await ExclePlugin()
        .setHAndByFormatOfCell(allList,
        titleList: titleList,
        hderCellFormat: titleWritableCellFormat,
        byCellFormat: bodyWritableCellFormat)
        .setOtherHeader(
        hderCellFormat: headerWritableCellFormat,
        headTiltle: "天津市渤海新能,2020年业扩福建大整合")
        .setOtherHeader(
        hderCellFormat: otherHeaderWritableCellFormat,
        headTiltle: "2020年9月24日")
        .setOtherHeader(
        hderCellFormat: headerWritableCellFormat2,
        headTiltle: "天津职业技术示范大学不行的画就撤职")
        .setTitleCell(titleCellList)
        .setSheetName(sheetName: "ExcleFlutter库")
        .setExcleFileName("Flutter_Excle插件开发")
        .createExcle();
  }
}
WritableCellFormat getOneCell() {
  var bodyfont = WritableFont(WritableFont.TIMES, 4, WritableFont.NO_BOLD,
      c: ExcleColour.WHITE);
  return WritableCellFormat(bodyfont)
      .setExAlignment(ExAlignment.CENTRE)
      .setVerticalExAlignment(VerticalExAlignment.CENTRE)
      .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
      colour: ExcleColour.GRAY_50)
      .setBackground(ExcleColour.PINK2);
}

WritableCellFormat getOneCell2() {
  var bodyfont = WritableFont(WritableFont.TIMES, 8, WritableFont.NO_BOLD,
      c: ExcleColour.WHITE);
  return WritableCellFormat(bodyfont)
      .setExAlignment(ExAlignment.CENTRE)
      .setVerticalExAlignment(VerticalExAlignment.CENTRE)
      .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
      colour: ExcleColour.GRAY_50)
      .setBackground(ExcleColour.ORANGE);
}

WritableCellFormat getOneCell3() {
  var bodyfont = WritableFont(WritableFont.TIMES, 8, WritableFont.NO_BOLD,
      c: ExcleColour.BLACK);
  return WritableCellFormat(bodyfont)
      .setExAlignment(ExAlignment.CENTRE)
      .setVerticalExAlignment(VerticalExAlignment.CENTRE)
      .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
      colour: ExcleColour.GRAY_50)
      .setBackground(ExcleColour.ROSE);
}
