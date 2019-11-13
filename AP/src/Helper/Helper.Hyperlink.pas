unit Helper.Hyperlink;

interface

uses
  FMX.StdCtrls, FMX.Types, System.UITypes;

type
  TLabelStyle = (lsLabel, lsHyperlink);

  THyperlink = class Helper for TLabel
  public
    procedure SetStyle(const Style: TLabelStyle);
  end;

implementation

procedure THyperlink.SetStyle(const Style: TLabelStyle);
begin
  StyledSettings := StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
  case Style of
    TLabelStyle.lsLabel:
      begin
        FontColor := TAlphaColorRec.Black;
        Font.Style := Font.Style - [TFontStyle.fsUnderline];
        Cursor := crDefault;
      end;
    TLabelStyle.lsHyperLink:
      begin
        FontColor := TAlphaColorRec.Blue;
        Font.Style := Font.Style + [TFontStyle.fsUnderline];
        Cursor := crHandPoint;
      end;
  end;
end;

end.
