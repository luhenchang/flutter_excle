import 'dart:core';
import 'dart:core';

import 'excle_color.dart';
import 'excle_writablefont.dart';

class WritableCellFormat {
  WritableFont _exfont;
  ExcleColour _exBorderColor=ExcleColour.BLACK;
  ExcleColour get writerBorderColor=>_exBorderColor;
  WritableFont get writerfont => _exfont;
  ExAlignment _exAlignment = ExAlignment.GENERAL;
  ExAlignment get writerAlignment => _exAlignment;
  VerticalExAlignment verticalExAlignment = VerticalExAlignment.CENTRE;
  ExBorder _exBorder = ExBorder.LEFT;
  ExBorder get writerExBorder =>_exBorder;
  ExBorderLineStyle _exBorderLineStyle = ExBorderLineStyle.NONE;
  ExBorderLineStyle get writerBorderLineStyle=> _exBorderLineStyle;
  ExcleColour _backgroundColour = ExcleColour.WHITE;
  ExcleColour get wirterBackgroundColour=> _backgroundColour;

  WritableCellFormat(WritableFont font) {
    this._exfont = font;
  }
  WritableCellFormat setExAlignment(ExAlignment a) {
    this._exAlignment = a;
    return this;
  }

  /// Sets the vertical ExAlignment for this format
  ///
  /// @param va the vertical ExAlignment
  /// @exception WriteException
  WritableCellFormat setVerticalExAlignment(VerticalExAlignment va) {
    this.verticalExAlignment = va;
    return this;
  }

  /// Sets the specified ExBorder for this format
  ///
  /// @param b the ExBorder
  /// @param ls the ExBorder line style
  /// @exception jxl.write.WriteException
  WritableCellFormat setExBorder(ExBorder b, ExBorderLineStyle ls,{ExcleColour colour}) {
    this._exBorder = b;
    this._exBorderLineStyle = ls;
    if(colour!=null) {
      this._exBorderColor = colour;
    }
    return this;
  }

  /// Sets the background colour for this cell format
  ///
  /// @param c the bacground colour
  /// @exception jxl.write.WriteException
  WritableCellFormat setBackground(ExcleColour c) {
    this._backgroundColour = c;
    return this;
  }
}

class ExAlignment {
  /// The internal numerical repreentation of the ExAlignment
  int value = 0;

  /// The string description of this ExAlignment
  String string = "general";

  ExAlignment(this.value, this.string);

  /// The standard ExAlignment
  static ExAlignment GENERAL = new ExAlignment(0, "general");

  /// Data cells with this ExAlignment will appear at the left hand edge of the
  /// cell
  static ExAlignment LEFT = new ExAlignment(1, "left");

  /// Data in cells with this ExAlignment will be centred
  static ExAlignment CENTRE = new ExAlignment(2, "centre");

  /// Data in cells with this ExAlignment will be right aligned
  static ExAlignment RIGHT = new ExAlignment(3, "right");

  /// Data in cells with this ExAlignment will fill the cell
  static ExAlignment FILL = new ExAlignment(4, "fill");

  /// Data in cells with this ExAlignment will be justified
  static ExAlignment JUSTIFY = new ExAlignment(5, "justify");
}

class VerticalExAlignment {
  /// The internal binary value which gets written to the generated Excel file
  int value;

  /// The textual description
  String string;

  /// Constructor
  ///
  /// @param val
  VerticalExAlignment(int val, String s) {
    value = val;
    string = s;
  }

  /// Accessor for the binary value
  ///
  /// @return the internal binary value
  int getValue() {
    return value;
  }

  /// Gets the textual description
  String getDescription() {
    return string;
  }

  /// Gets the ExAlignment from the value
  ///
  /// @param val
  /// @return the ExAlignment with that value
  static VerticalExAlignment getExAlignment(int val) {
    return BOTTOM;
  }

  /// Cells with this specified vertical ExAlignment will have their data
  /// aligned at the top
  static VerticalExAlignment TOP = new VerticalExAlignment(0, "top");

  /// Cells with this specified vertical ExAlignment will have their data
  /// aligned centrally
  static VerticalExAlignment CENTRE = new VerticalExAlignment(1, "centre");

  /// Cells with this specified vertical ExAlignment will have their data
  /// aligned at the bottom
  static VerticalExAlignment BOTTOM = new VerticalExAlignment(2, "bottom");

  /// Cells with this specified vertical ExAlignment will have their data
  /// justified
  static VerticalExAlignment JUSTIFY = new VerticalExAlignment(3, "Justify");
}

class ExBorder {
  /// The string description
  String string;

  /// Constructor
  ExBorder(String s) {
    string = s;
  }

  /// Gets the description
  String getDescription() {
    return string;
  }

  static ExBorder NONE = new ExBorder("none");
  static ExBorder ALL = new ExBorder("all");
  static ExBorder TOP = new ExBorder("top");
  static ExBorder BOTTOM = new ExBorder("bottom");
  static ExBorder LEFT = new ExBorder("left");
  static ExBorder RIGHT = new ExBorder("right");
}

/// The ExBorder line style
class ExBorderLineStyle {
  /// The value
  int value;

  /// The string description
  String string;

  /// Constructor
  ExBorderLineStyle(int val, String s) {
    value = val;
    string = s;
  }

  /// Gets the value for this line style
  ///
  /// @return the value
  int getValue() {
    return value;
  }

  /// Gets the textual description
  String getDescription() {
    return string;
  }

  /// Gets the ExAlignment from the value
  ///
  /// @param val
  /// @return the ExAlignment with that value
  static ExBorderLineStyle getStyle(int val) {
    return NONE;
  }

  static ExBorderLineStyle NONE = new ExBorderLineStyle(0, "none");
  static ExBorderLineStyle THIN = new ExBorderLineStyle(1, "thin");
  static ExBorderLineStyle MEDIUM = new ExBorderLineStyle(2, "medium");
  static ExBorderLineStyle DASHED = new ExBorderLineStyle(3, "dashed");
  static ExBorderLineStyle DOTTED = new ExBorderLineStyle(4, "dotted");
  static ExBorderLineStyle THICK = new ExBorderLineStyle(5, "thick");
  static ExBorderLineStyle DOUBLE = new ExBorderLineStyle(6, "double");
  static ExBorderLineStyle HAIR = new ExBorderLineStyle(7, "hair");
  static ExBorderLineStyle MEDIUM_DASHED =
      new ExBorderLineStyle(8, "medium dashed");
  static ExBorderLineStyle DASH_DOT = new ExBorderLineStyle(9, "dash dot");
  static ExBorderLineStyle MEDIUM_DASH_DOT =
      new ExBorderLineStyle(0xa, "medium dash dot");
  static ExBorderLineStyle DASH_DOT_DOT =
      new ExBorderLineStyle(0xb, "Dash dot dot");
  static ExBorderLineStyle MEDIUM_DASH_DOT_DOT =
      new ExBorderLineStyle(0xc, "Medium dash dot dot");
  static ExBorderLineStyle SLANTED_DASH_DOT =
      new ExBorderLineStyle(0xd, "Slanted dash dot");
}

class UnderlineStyle {
  /// The internal numerical representation of the UnderlineStyle
  int value;

  /// The display string for the underline style.  Used when presenting the
  /// format information
  String string;

  ///  constructor
  ///
  /// @param val
  /// @param s the display string
  UnderlineStyle(int val, String s) {
    value = val;
    string = s;
  }

  /// Gets the value of this style.  This is the value that is written to
  /// the generated Excel file
  ///
  /// @return the binary value
  int getValue() {
    return value;
  }

  /// Gets the string description for display purposes
  ///
  /// @return the string description
  String getDescription() {
    return string;
  }

  /// Gets the UnderlineStyle from the value
  ///
  /// @param val
  /// @return the UnderlineStyle with that value
  static UnderlineStyle getStyle(int val) {
    return NO_UNDERLINE;
  }

// The underline styles
  static UnderlineStyle NO_UNDERLINE = new UnderlineStyle(0, "none");

  static UnderlineStyle SINGLE = new UnderlineStyle(1, "single");

  static UnderlineStyle DOUBLE = new UnderlineStyle(2, "double");

  static UnderlineStyle SINGLE_ACCOUNTING =
      new UnderlineStyle(0x21, "single accounting");

  static UnderlineStyle DOUBLE_ACCOUNTING =
      new UnderlineStyle(0x22, "double accounting");
}
