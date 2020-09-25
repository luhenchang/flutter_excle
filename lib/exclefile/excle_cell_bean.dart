import 'excle_writablecellformat.dart';

class CellEntity{
  String content="";
  WritableCellFormat everyCellFormat;
  CellEntity(this.content,{this.everyCellFormat}):assert(content!=null,"content must not null");
}