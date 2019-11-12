unit Helper.ListBoxItem;

interface

uses
  FMX.ListBox, System.SysUtils;

type
  TListBoxItemHelper = class Helper for TListBoxItem
  public
    procedure Check(const Checked: Boolean);
    procedure Restore;
  end;

implementation

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
