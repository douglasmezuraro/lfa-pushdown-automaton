unit Helper.Edit;

interface

uses
  FMX.Edit, System.SysUtils;

type
  TEditHelper = class Helper for TEdit
  public
    procedure Clear;
  end;

implementation

procedure TEditHelper.Clear;
begin
  Text := string.Empty;
end;

end.

