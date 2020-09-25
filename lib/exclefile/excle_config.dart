import 'excle_color.dart';
import 'excle_writablecellformat.dart';
import 'excle_writablefont.dart';

class ExcleConfing {
  static var defultHeadfont =
      WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD);
  static var defultBodyfont = WritableFont(
      WritableFont.TIMES, 8, WritableFont.NO_BOLD,
      c: ExcleColour.BLACK);

  static WritableCellFormat getDefultHeaderCellFormat() {
    return WritableCellFormat(defultHeadfont)
        .setExAlignment(ExAlignment.CENTRE)
        .setVerticalExAlignment(VerticalExAlignment.CENTRE)
        .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
            colour: ExcleColour.GREEN)
        .setBackground(ExcleColour.LIGHT_TURQUOISE);
  }

  static WritableCellFormat getDefultBodyCellFormat() {
    return WritableCellFormat(defultBodyfont)
        .setExAlignment(ExAlignment.CENTRE)
        .setVerticalExAlignment(VerticalExAlignment.CENTRE)
        .setExBorder(ExBorder.ALL, ExBorderLineStyle.THIN,
            colour: ExcleColour.GRAY_50)
        .setBackground(ExcleColour.WHITE);
  }
}
