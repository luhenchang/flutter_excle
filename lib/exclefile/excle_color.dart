import 'dart:core';

import 'dart:core';

class ExcleColour {
  static ExcleColour UNKNOWN = new ExcleColour(0x7fee, "unknown", 0, 0, 0);
  static ExcleColour BLACK = new ExcleColour(0x7fff, "black", 0, 0, 0);
  static ExcleColour WHITE = new ExcleColour(0x9, "white", 0xff, 0xff, 0xff);
  static ExcleColour DEFAULT_BACKGROUND1 =
      new ExcleColour(0x0, "default background", 0xff, 0xff, 0xff);
  static ExcleColour DEFAULT_BACKGROUND =
      new ExcleColour(0xc0, "default background", 0xff, 0xff, 0xff);
  static ExcleColour PALETTE_BLACK = new ExcleColour(0x8, "black", 0x1, 0, 0);
  static ExcleColour RED = new ExcleColour(0xa, "red", 0xff, 0, 0);
  static ExcleColour BRIGHT_GREEN =
      new ExcleColour(0xb, "bright green", 0, 0xff, 0);
  static ExcleColour BLUE = new ExcleColour(0xc, "blue", 0, 0, 0xff);
  static ExcleColour YELLOW = new ExcleColour(0xd, "yellow", 0xff, 0xff, 0);
  static ExcleColour PINK = new ExcleColour(0xe, "pink", 0xff, 0, 0xff);
  static ExcleColour TURQUOISE =
      new ExcleColour(0xf, "turquoise", 0, 0xff, 0xff);
  static ExcleColour DARK_RED = new ExcleColour(0x10, "dark red", 0x80, 0, 0);
  static ExcleColour GREEN = new ExcleColour(0x11, "green", 0, 0x80, 0);
  static ExcleColour DARK_BLUE = new ExcleColour(0x12, "dark blue", 0, 0, 0x80);
  static ExcleColour DARK_YELLOW =
      new ExcleColour(0x13, "dark yellow", 0x80, 0x80, 0);
  static ExcleColour VIOLET = new ExcleColour(0x14, "violet", 0x80, 0x80, 0);
  static ExcleColour TEAL = new ExcleColour(0x15, "teal", 0, 0x80, 0x80);
  static ExcleColour GREY_25_PERCENT =
      new ExcleColour(0x16, "grey 25%", 0xc0, 0xc0, 0xc0);
  static ExcleColour GREY_50_PERCENT =
      new ExcleColour(0x17, "grey 50%", 0x80, 0x80, 0x80);
  static ExcleColour PERIWINKLE =
      new ExcleColour(0x18, "periwinkle%", 0x99, 0x99, 0xff);
  static ExcleColour PLUM2 = new ExcleColour(0x19, "plum", 0x99, 0x33, 0x66);
  static ExcleColour IVORY = new ExcleColour(0x1a, "ivory", 0xff, 0xff, 0xcc);
  static ExcleColour LIGHT_TURQUOISE2 =
      new ExcleColour(0x1b, "light turquoise", 0xcc, 0xff, 0xff);
  static ExcleColour DARK_PURPLE =
      new ExcleColour(0x1c, "dark purple", 0x66, 0x0, 0x66);
  static ExcleColour CORAL = new ExcleColour(0x1d, "coral", 0xff, 0x80, 0x80);
  static ExcleColour OCEAN_BLUE =
      new ExcleColour(0x1e, "ocean blue", 0x0, 0x66, 0xcc);
  static ExcleColour ICE_BLUE =
      new ExcleColour(0x1f, "ice blue", 0xcc, 0xcc, 0xff);
  static ExcleColour DARK_BLUE2 =
      new ExcleColour(0x20, "dark blue", 0, 0, 0x80);
  static ExcleColour PINK2 = new ExcleColour(0x21, "pink", 0xff, 0, 0xff);
  static ExcleColour YELLOW2 = new ExcleColour(0x22, "yellow", 0xff, 0xff, 0x0);
  static ExcleColour TURQOISE2 =
      new ExcleColour(0x23, "turqoise", 0x0, 0xff, 0xff);
  static ExcleColour VIOLET2 = new ExcleColour(0x24, "violet", 0x80, 0x0, 0x80);
  static ExcleColour DARK_RED2 =
      new ExcleColour(0x25, "dark red", 0x80, 0x0, 0x0);
  static ExcleColour TEAL2 = new ExcleColour(0x26, "teal", 0x0, 0x80, 0x80);
  static ExcleColour BLUE2 = new ExcleColour(0x27, "blue", 0x0, 0x0, 0xff);
  static ExcleColour SKY_BLUE =
      new ExcleColour(0x28, "sky blue", 0, 0xcc, 0xff);
  static ExcleColour LIGHT_TURQUOISE =
      new ExcleColour(0x29, "light turquoise", 0xcc, 0xff, 0xff);
  static ExcleColour LIGHT_GREEN =
      new ExcleColour(0x2a, "light green", 0xcc, 0xff, 0xcc);
  static ExcleColour VERY_LIGHT_YELLOW =
      new ExcleColour(0x2b, "very light yellow", 0xff, 0xff, 0x99);
  static ExcleColour PALE_BLUE =
      new ExcleColour(0x2c, "pale blue", 0x99, 0xcc, 0xff);
  static ExcleColour ROSE = new ExcleColour(0x2d, "rose", 0xff, 0x99, 0xcc);
  static ExcleColour LAVENDER =
      new ExcleColour(0x2e, "lavender", 0xcc, 0x99, 0xff);
  static ExcleColour TAN = new ExcleColour(0x2f, "tan", 0xff, 0xcc, 0x99);
  static ExcleColour LIGHT_BLUE =
      new ExcleColour(0x30, "light blue", 0x33, 0x66, 0xff);
  static ExcleColour AQUA = new ExcleColour(0x31, "aqua", 0x33, 0xcc, 0xcc);
  static ExcleColour LIME = new ExcleColour(0x32, "lime", 0x99, 0xcc, 0);
  static ExcleColour GOLD = new ExcleColour(0x33, "gold", 0xff, 0xcc, 0);
  static ExcleColour LIGHT_ORANGE =
      new ExcleColour(0x34, "light orange", 0xff, 0x99, 0);
  static ExcleColour ORANGE = new ExcleColour(0x35, "orange", 0xff, 0x66, 0);
  static ExcleColour BLUE_GREY =
      new ExcleColour(0x36, "blue grey", 0x66, 0x66, 0xcc);
  static ExcleColour GREY_40_PERCENT =
      new ExcleColour(0x37, "grey 40%", 0x96, 0x96, 0x96);
  static ExcleColour DARK_TEAL =
      new ExcleColour(0x38, "dark teal", 0, 0x33, 0x66);
  static ExcleColour SEA_GREEN =
      new ExcleColour(0x39, "sea green", 0x33, 0x99, 0x66);
  static ExcleColour DARK_GREEN =
      new ExcleColour(0x3a, "dark green", 0, 0x33, 0);
  static ExcleColour OLIVE_GREEN =
      new ExcleColour(0x3b, "olive green", 0x33, 0x33, 0);
  static ExcleColour BROWN = new ExcleColour(0x3c, "brown", 0x99, 0x33, 0);
  static ExcleColour PLUM = new ExcleColour(0x3d, "plum", 0x99, 0x33, 0x66);
  static ExcleColour INDIGO = new ExcleColour(0x3e, "indigo", 0x33, 0x33, 0x99);
  static ExcleColour GREY_80_PERCENT =
      new ExcleColour(0x3f, "grey 80%", 0x33, 0x33, 0x33);
  static ExcleColour AUTOMATIC =
      new ExcleColour(0x40, "automatic", 0xff, 0xff, 0xff);
  static ExcleColour GRAY_80 = GREY_80_PERCENT;
  static ExcleColour GRAY_50 = GREY_50_PERCENT;
  static ExcleColour GRAY_25 = GREY_25_PERCENT;

  var l;

  var j;

  var i;

  var k;

  String s;

  ExcleColour( this.i, this.s, this.j, this.k, this.l);
}
