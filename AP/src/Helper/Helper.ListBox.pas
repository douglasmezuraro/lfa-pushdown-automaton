unit Helper.ListBox;

interface

uses
  FMX.ListBox, Helper.ListBoxItem;

type
  TListBoxHelper = class Helper for TListBox
  public
    procedure Add(const Text: string; const IsChecked: Boolean);
  end;

implementation

procedure TListBoxHelper.Add(const Text: string; const IsChecked: Boolean);
var
  Item: TListBoxItem;
begin
  Item := TListBoxItem.Create(Self);
  Item.Text := Text;
  Item.Check(IsChecked);

  AddObject(Item);
end;

end.
