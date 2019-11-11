unit Helper.FMX;

interface

uses
  System.SysUtils, FMX.ListBox;

type
  TListBoxItemHelper = class Helper for TListBoxItem
  public
    procedure Check(const Checked: Boolean);
    procedure Restore;
  end;

implementation

{ TListBoxItemHelper }

procedure TListBoxItemHelper.Check(const Checked: Boolean);
begin
  IsChecked := Checked;
  Tag := Checked.ToInteger;
end;

procedure TListBoxItemHelper.Restore;
begin
  IsChecked := Tag.ToBoolean;
end;

end.

