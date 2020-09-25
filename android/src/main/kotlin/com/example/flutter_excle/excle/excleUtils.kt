@file:Suppress("INACCESSIBLE_TYPE", "CAST_NEVER_SUCCEEDS")

package com.example.flutter_excle.excle

import android.content.Context
import jxl.Workbook
import jxl.WorkbookSettings
import jxl.format.*
import jxl.format.Alignment
import jxl.format.Alignment.GENERAL
import jxl.format.Alignment.LEFT
import jxl.format.Border
import jxl.format.BorderLineStyle
import jxl.format.Colour
import jxl.format.VerticalAlignment
import jxl.write.*
import jxl.write.WritableFont.FontName
import java.io.File
import java.io.FileInputStream
import java.io.IOException
import java.io.InputStream

/**
 *
 *excel工具类
 *@auther Create By fei wang on 2020/9/22
 */
object ExcelUtil {
    private const val UTF8_ENCODING = "UTF-8"
    private var arial10format: WritableCellFormat? = null
    private var bodyformart: WritableCellFormat? = null
    private var headerSize = 0
    private fun format(headerMap: Map<String, Any?>, bodyMap: Map<String, Any?>) {
        try {
            val arial10font = createWriteableFont(headerMap)
            arial10format = WritableCellFormat(arial10font)
            arial10format!!.alignment = setExcleAgnment(headerMap["Alignment_value"] as Int)
            arial10format!!.verticalAlignment = setVerticalAlignment(headerMap["VerticalExAlignment_value"] as Int)
            arial10format!!.setBorder(getBorder(headerMap["Border_string"] as String), getBorderLineStyle(headerMap["writerBorderLineStyle"] as Int), getBackground(headerMap["BorderColor_value"] as Int))
            arial10format!!.setBackground(getBackground(headerMap["Background_value"] as Int))

            val arial11font = createWriteableFont(bodyMap)
            bodyformart = WritableCellFormat(arial11font)
            bodyformart!!.alignment = setExcleAgnment(bodyMap["Alignment_value"] as Int)
            bodyformart!!.verticalAlignment = setVerticalAlignment(bodyMap["VerticalExAlignment_value"] as Int)
            bodyformart!!.setBorder(getBorder(bodyMap["Border_string"] as String), getBorderLineStyle(bodyMap["writerBorderLineStyle"] as Int), getBackground(bodyMap["BorderColor_value"] as Int))
            bodyformart!!.setBackground(getBackground(bodyMap["Background_value"] as Int))

        } catch (e: WriteException) {
            e.printStackTrace()
        }
    }


    fun initExcel(name: String?, sheetName: String?, fileName: String?, colName: Array<String?>, headerMap: Map<String, Any?>, bodyMap: Map<String, Any?>, otherHeadeMap: List<Map<String, Any?>>?,objList: List<Any>?,titlList:ArrayList<Map<String, Any?>>?) {
        format(headerMap, bodyMap)
        var workbook: WritableWorkbook? = null
        try {
            val file = File(fileName)
            if (!file.exists()) {
                file.delete()
                file.createNewFile()
            }
            //region 单元格部分参数设置
            workbook = Workbook.createWorkbook(file)
            //endregion
            //region 设置Sheet
            sheetName?.let {
                val sheet: WritableSheet = workbook.createSheet(sheetName, 0);
                if (otherHeadeMap != null && otherHeadeMap.isNotEmpty()) {
                    headerSize = otherHeadeMap.size
                    for (index in otherHeadeMap.indices) {
                        sheet.addCell(Label(0, index, otherHeadeMap[index]["headTiltle"].toString(), getCellFormart(otherHeadeMap[index] as Map<String, Any?>?))) // 合并单元格
                        sheet.setRowView(index, 850)
                        var rowsize=objList as ArrayList<*>
                        if (colName.isEmpty()){
                            sheet.mergeCells(0, index, rowsize.size, index) // 合并单元格
                        }else {
                            sheet.mergeCells(0, index, colName.size + 1, index) // 合并单元格
                        }
                    }

                }
                //region增加表头的标题
                if (titlList.isNullOrEmpty()) {
                    headerSize += colName.size
                    for (col in colName.indices) {
                        sheet.addCell(Label(col, otherHeadeMap!!.size + 1, colName[col], arial10format))
                        sheet.setRowView(otherHeadeMap.size + 1, 350)
                        sheet.mergeCells(0, otherHeadeMap.size + 1, 0, otherHeadeMap.size + 1) // 合并单元格
                    }
                }else{
                    var maxRow=1
                    for (index in titlList.indices) {
                        sheet.addCell(Label(titlList[index]["Label_c"] as Int,titlList[index]["Label_r"] as Int, titlList[index]["Label_cont"] as String?, getCellFormart(titlList[index]["title_cell_format"] as Map<String, Any?>?)))
                        sheet.setRowView(titlList[index]["setRowView_row"] as Int, titlList[index]["setRowView_height"] as Int)
                        sheet.mergeCells(titlList[index]["mergeCells_col1"] as Int, titlList[index]["mergeCells_row1"] as Int, titlList[index]["mergeCells_col2"] as Int, titlList[index]["mergeCells_row2"] as Int) // 合并单元格
                        var inss=(titlList[index]["mergeCells_row2"] as Int)-(titlList[index]["mergeCells_row1"] as Int)
                        if (maxRow<inss){
                            maxRow=inss
                        }
                    }
                    headerSize += (maxRow)
                }
                //endregion
                //endregion
                workbook.write()
            }

        } catch (e: Exception) {
            e.printStackTrace()
        } finally {
            if (workbook != null) {
                try {
                    workbook.close()
                } catch (e: Exception) {
                    // TODO Auto-generated catch block
                    e.printStackTrace()
                }
            }
        }
    }

    fun <T> writeObjListToExcel(objList: List<T>?, fileName: String?, c: Context?): File? {
        var file: File? = null
        var allCell: ArrayList<ArrayList<Map<String, Map<String, Any?>>>>? = ArrayList()
        allCell = objList as ArrayList<ArrayList<Map<String, Map<String, Any?>>>>
        if (allCell.isNotEmpty()) {
            var writebook: WritableWorkbook? = null
            var inputstream: InputStream? = null
            file = File(fileName)
            if (!file.exists()) {
                try {
                    file.delete()
                    file.createNewFile()
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }
            try {
                val setEncode = WorkbookSettings()
                setEncode.encoding = UTF8_ENCODING
                inputstream = FileInputStream(file)
                val workbook: Workbook = Workbook.getWorkbook(inputstream)
                writebook = Workbook.createWorkbook(File(fileName), workbook)
                var sheet: WritableSheet? = null
                try {
                    sheet = writebook.getSheet(0)
                } catch (e: IndexOutOfBoundsException) {
                    e.printStackTrace()
                }
                for (j in 1 until allCell.size + 1) {
                    var innnerArray: ArrayList<Map<String, Map<String, Any?>>> = allCell[j - 1]
                    var width = 0
                    for (i in innnerArray.indices) {
                        if (innnerArray[i]["content"].toString().length > width) {
                            width = innnerArray[i]["content"].toString().length
                        }
                    }
                    for (i in innnerArray.indices) {
                        //TODO j+1
                        sheet!!.addCell(Label(i, j + headerSize, innnerArray[i]["content"].toString(), getCellFormart(innnerArray[i]["contentCellFormat"])))
                        sheet.setColumnView(i, width * 2)
                    }
                    //设置行高
                    sheet!!.setRowView(j, 270)
                }
                sheet!!.setRowView(0, 270)
                writebook.write()
            } catch (e: Exception) {
                e.printStackTrace()
            } finally {
                if (writebook != null) {
                    try {
                        writebook.close()
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }
                }
                if (inputstream != null) {
                    try {
                        inputstream.close()
                    } catch (e: IOException) {
                        e.printStackTrace()
                    }
                }
            }
        }
        return file
    }

    private fun getCellFormart(bodyMap: Map<String, Any?>?): CellFormat? {
        val arial11font = createWriteableFont(bodyMap!!)
        val mbodyformart = WritableCellFormat(arial11font)
        mbodyformart.alignment = setExcleAgnment(bodyMap["Alignment_value"] as Int)
        mbodyformart.verticalAlignment = setVerticalAlignment(bodyMap["VerticalExAlignment_value"] as Int)
        mbodyformart.setBorder(getBorder(bodyMap["Border_string"] as String), getBorderLineStyle(bodyMap["writerBorderLineStyle"] as Int), getBackground(bodyMap["BorderColor_value"] as Int))
        mbodyformart.setBackground(getBackground(bodyMap["Background_value"] as Int))
        return mbodyformart

    }

    private fun getBackground(colour: Int): Colour? {
        when (colour) {
            0x7fee -> return Colour.UNKNOWN
            0x7fff -> return Colour.BLACK
            0x9 -> return Colour.WHITE
            0x0 -> return Colour.DEFAULT_BACKGROUND
            0xc0 -> return Colour.DEFAULT_BACKGROUND1
            0x8 -> return Colour.PALETTE_BLACK
            0xa -> return Colour.RED
            0xb -> return Colour.BRIGHT_GREEN
            0xc -> return Colour.BLUE
            0xe -> return Colour.PINK
            0xf -> return Colour.TURQUOISE
            0x10 -> return Colour.DARK_RED
            0x11 -> return Colour.GREEN
            0x12 -> return Colour.DARK_BLUE
            0x13 -> return Colour.DARK_YELLOW
            0x14 -> return Colour.VIOLET
            0x15 -> return Colour.TEAL
            0x16 -> return Colour.GREY_25_PERCENT
            0x17 -> return Colour.GREY_50_PERCENT
            0x18 -> return Colour.PERIWINKLE
            0x19 -> return Colour.PLUM2
            0x1a -> return Colour.IVORY
            0x1b -> return Colour.LIGHT_TURQUOISE2
            0x1c -> return Colour.DARK_PURPLE
            0x1d -> return Colour.CORAL
            0x1e -> return Colour.OCEAN_BLUE
            0x1f -> return Colour.ICE_BLUE
            0x20 -> return Colour.DARK_BLUE2
            0x21 -> return Colour.PINK2
            0x22 -> return Colour.YELLOW2
            0x23 -> return Colour.TURQOISE2
            0x24 -> return Colour.VIOLET2
            0x25 -> return Colour.DARK_RED2
            0x26 -> return Colour.TEAL2
            0x27 -> return Colour.BLUE2
            0x28 -> return Colour.SKY_BLUE
            0x29 -> return Colour.LIGHT_TURQUOISE
            0x2a -> return Colour.LIGHT_GREEN
            0x2b -> return Colour.VERY_LIGHT_YELLOW
            0x2c -> return Colour.PALE_BLUE
            0x2d -> return Colour.ROSE
            0x2e -> return Colour.LAVENDER
            0x2f -> return Colour.TAN
            0x30 -> return Colour.LIGHT_BLUE
            0x31 -> return Colour.AQUA
            0x32 -> return Colour.LIME
            0x33 -> return Colour.GOLD
            0x34 -> return Colour.LIGHT_ORANGE
            0x35 -> return Colour.ORANGE
            0x36 -> return Colour.BLUE_GREY
            0x37 -> return Colour.GREY_40_PERCENT
            0x38 -> return Colour.DARK_TEAL
            0x39 -> return Colour.SEA_GREEN
            0x3a -> return Colour.DARK_GREEN
            0x3b -> return Colour.OLIVE_GREEN
            0x3c -> return Colour.BROWN
            0x3d -> return Colour.PLUM
            0x3e -> return Colour.INDIGO
            0x3f -> return Colour.GREY_80_PERCENT
            0x40 -> return Colour.AUTOMATIC

        }
        return Colour.WHITE
    }

    private fun getBorderLineStyle(i: Int): BorderLineStyle? {
        when (i) {
            0 -> return BorderLineStyle.NONE
            1 -> return BorderLineStyle.THIN
            2 -> return BorderLineStyle.MEDIUM
            3 -> return BorderLineStyle.DASHED
            4 -> return BorderLineStyle.DOTTED
            5 -> return BorderLineStyle.THICK
            6 -> return BorderLineStyle.DOUBLE
            7 -> return BorderLineStyle.HAIR
            8 -> return BorderLineStyle.MEDIUM_DASHED
            9 -> return BorderLineStyle.DASH_DOT
            0xa -> return BorderLineStyle.MEDIUM_DASH_DOT
            0xb -> return BorderLineStyle.DASH_DOT_DOT
            0xc -> return BorderLineStyle.MEDIUM_DASH_DOT_DOT
            0xd -> return BorderLineStyle.SLANTED_DASH_DOT
        }
        return BorderLineStyle.THIN
    }

    private fun getBorder(borderSt: String): Border? {
        when (borderSt) {
            "none" -> return Border.NONE
            "all" -> return Border.ALL
            "top" -> return Border.TOP
            "bottom" -> return Border.BOTTOM
            "left" -> return Border.LEFT
            "right" -> return Border.RIGHT
        }
        return Border.NONE
    }

    private fun setVerticalAlignment(value: Int): VerticalAlignment? {
        when (value) {
            0 -> return VerticalAlignment.TOP
            1 -> return VerticalAlignment.CENTRE
            2 -> return VerticalAlignment.BOTTOM
            3 -> return VerticalAlignment.JUSTIFY

        }
        return VerticalAlignment.CENTRE
    }

    private fun createWriteableFont(headerMap: Map<String, Any?>): WritableFont {
        var fontName = headerMap["fontName"]
        var fontNameEnd: FontName = WritableFont.ARIAL
        when (fontName) {
            "Arial" -> {
                fontNameEnd = WritableFont.ARIAL
            }
            "Times New Roman" -> {
                fontNameEnd = WritableFont.TIMES
            }
            "Courier New" -> {
                fontNameEnd = WritableFont.COURIER
            }
            "Tahoma" -> {
                fontNameEnd = WritableFont.TAHOMA
            }
        }
        val fontSBold: Int = headerMap["fontSBold"] as Int
        var boldStyle = WritableFont.NO_BOLD
        if (fontSBold == 0x2bc) {
            boldStyle = WritableFont.BOLD
        }
        val fontColour = getBackground(headerMap["fontColor_value"] as Int)
        val fontSize: Int = headerMap["fontSize"] as Int
        val underlineStyle = headerMap["underLineStyle_value"] as Int
        val arial10font = WritableFont(fontNameEnd, fontSize, boldStyle, false, getUnderLineStyle(underlineStyle), fontColour)
        return arial10font
    }

    private fun getUnderLineStyle(underlineStyle: Int): UnderlineStyle? {
        when (underlineStyle) {
            0 -> return UnderlineStyle.NO_UNDERLINE
            1 -> return UnderlineStyle.SINGLE
            2 -> return UnderlineStyle.DOUBLE
            3 -> return UnderlineStyle.SINGLE_ACCOUNTING
            4 -> return UnderlineStyle.DOUBLE_ACCOUNTING
        }
        return UnderlineStyle.SINGLE
    }

    private fun setExcleAgnment(agnmentValue: Int): Alignment? {
        when (agnmentValue) {
            0 -> {
                return GENERAL

            }
            1 -> {
                return LEFT

            }
            2 -> {
                return Alignment.CENTRE

            }
            3 -> {
                return Alignment.RIGHT

            }
            4 -> {
                return Alignment.FILL

            }
            5 -> {
                return Alignment.JUSTIFY

            }
        }
        return Alignment.CENTRE
    }
}

