
import 'excle_config.dart';
import 'excle_writablecellformat.dart';

class WritableSheet {
  Label label;
  int row;
  int height;
  int col1;
  int row1;
  int col2;
  int row2;
  static WritableSheet Builder(){
   return WritableSheet();
  }
  /// Adds a cell to this sheet
  /// The RowsExceededException may be caught if client code wishes to
  /// explicitly trap the case where too many rows have been written
  /// to the current sheet.  If this behaviour is not desired, it is
  /// sufficient simply to handle the WriteException, since this is a base
  /// class of RowsExceededException
  ///
  /// @param cell the cell to add
  /// @exception jxl.write..WriteException
  /// @exception jxl.write.biff.RowsExceededException
  /// 自定义表头标题部分
  WritableSheet addCell(Label cell) {
    assert(cell != null);
    this.label = cell;
    return this;
  }

  /// Merges the specified cells.  Any clashes or intersections between
  /// merged cells are resolved when the spreadsheet is written out
  ///
  /// @param col1 the column number of the top left cell
  /// @param row1 the row number of the top left cell
  /// @param col2 the column number of the bottom right cell
  /// @param row2 the row number of the bottom right cell
  /// @return the Range object representing the merged cells
  /// @exception jxl.write..WriteException
  /// @exception jxl.write.biff.RowsExceededException
  WritableSheet mergeCells(int col1, int row1, int col2, int row2) {
    this.col1 = col1;
    this.col2 = col2;
    this.row1 = row1;
    this.row2 = row2;
    return this;
  }

  /// Sets the height of the specified row, as well as its collapse status
  ///
  /// @param row the row to be formatted
  /// @param height the row height in characters
  /// @exception jxl.write.biff.RowsExceededException
  WritableSheet setRowView(int row, int height) {
    this.row = row;
    this.height = row;
    return this;
  }
}

class Label {
  int c;

  String cont;

  int r;

  WritableCellFormat st = ExcleConfing.getDefultBodyCellFormat();

  /// Creates a cell which, when added to the sheet, will be presented at the
  /// specified column and row co-ordinates and will present the specified text
  /// in the manner specified by the CellFormat parameter
  ///
  /// @param c the column
  /// @param cont the data
  /// @param r the row
  /// @param st the cell format
  Label(int c, int r, String cont, WritableCellFormat st)
      : assert(cont != null, "cont must not null") {
    this.c = c;
    this.r = r;
    this.cont = cont;
    if (st != null) {
      this.st = st;
    }
  }
}
