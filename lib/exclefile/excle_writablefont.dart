
import 'excle_color.dart';
import 'excle_writablecellformat.dart';

class WritableFont {
  String fontName;

  /// Objects created with this font name will be rendered within Excel as ARIAL
  /// fonts
  static final FontName ARIAL = new FontName("Arial");

  /// Objects created with this font name will be rendered within Excel as TIMES
  /// fonts
  static final FontName TIMES = new FontName("Times New Roman");

  /// Objects created with this font name will be rendered within Excel as
  /// COURIER fonts
  static final FontName COURIER = new FontName("Courier New");

  /// Objects created with this font name will be rendered within Excel as
  /// TAHOMA fonts
  static final FontName TAHOMA = new FontName("Tahoma");

  /// Indicates that this font should not be presented as bold
  static final BoldStyle NO_BOLD = new BoldStyle(0x190);

  /// Indicates that this font should be presented in a BOLD style
  static final BoldStyle BOLD = new BoldStyle(0x2bc);

  int fontSize=10;
  int fontSBold=NO_BOLD.value;
  bool italic;
  ExcleColour fontColor = ExcleColour.BLACK;
  UnderlineStyle underLineStyle = UnderlineStyle.NO_UNDERLINE;
  /// Creates a font of the specified face, point size and bold style
  ///
  /// @param ps the point size
  /// @param bs the bold style
  /// @param fn the font name
  WritableFont(FontName fn, int ps, BoldStyle bs,
      {bool italic = false, UnderlineStyle us, ExcleColour c}) {
    this.fontName = fn.name;
    this.fontSize = ps;
    this.fontSBold = bs?.value;
    this.italic = italic;
    if (us != null) {
      this.underLineStyle = us;
    }
    if (c != null) {
      this.fontColor = c;
    }
  }
}

class FontName {
  /// The name
  String name;

  /// Constructor
  ///
  /// @param s the font name
  FontName(String s) {
    name = s;
  }
}

class BoldStyle {
  /// The value
  int value;

  /// Constructor
  ///
  /// @param val the value
  BoldStyle(int val) {
    value = val;
  }
}
