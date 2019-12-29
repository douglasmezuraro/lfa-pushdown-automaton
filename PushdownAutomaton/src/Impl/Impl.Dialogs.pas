unit Impl.Dialogs;

interface

uses
  FMX.Dialogs, FMX.DialogService, System.SysUtils, System.UITypes;

type
  TDialogs = class sealed
  strict private
    const HelpCtx: Byte = 0;
  private
    class function OpenDialog(const Dialog: TOpenDialog; const Extension: string; out FileName: string): Boolean;
  public
    class function Confirmation(const Message: string): Boolean; overload;
    class function Confirmation(const Message: string; const Args: array of const): Boolean; overload;
    class procedure Error(const Message: string); overload;
    class procedure Error(const Message: string; const Args: array of const); overload;
    class procedure Information(const Message: string); overload;
    class procedure Information(const Message: string; const Args: array of const); overload;
    class procedure Warning(const Message: string); overload;
    class procedure Warning(const Message: string; const Args: array of const); overload;
    class function OpenFile(const Extension: string; out FileName: string): Boolean;
    class function SaveFile(const Extension: string; out FileName: string): Boolean;
  end;

implementation

class function TDialogs.Confirmation(const Message: string; const Args: array of const): Boolean;
begin
  Result := Confirmation(Format(Message, Args));
end;

class function TDialogs.Confirmation(const Message: string): Boolean;
var
  LResult: Boolean;
begin
  TDialogService.MessageDialog(Message, TMsgDlgType.mtConfirmation, FMX.Dialogs.mbYesNo, TMsgDlgBtn.mbNo, HelpCtx,
    procedure(const AResult: TModalResult)
    begin
      LResult := IsPositiveResult(AResult);
    end);

  Result := LResult;
end;

class procedure TDialogs.Error(const Message: string; const Args: array of const);
begin
  Error(Format(Message, Args));
end;

class procedure TDialogs.Error(const Message: string);
begin
  TDialogService.MessageDialog(Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class procedure TDialogs.Information(const Message: string; const Args: array of const);
begin
  Information(Format(Message, Args));
end;

class procedure TDialogs.Information(const Message: string);
begin
  TDialogService.MessageDialog(Message, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class procedure TDialogs.Warning(const Message: string; const Args: array of const);
begin
  Warning(Format(Message, Args));
end;

class procedure TDialogs.Warning(const Message: string);
begin
  TDialogService.MessageDialog(Message, TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class function TDialogs.OpenDialog(const Dialog: TOpenDialog; const Extension: string; out FileName: string): Boolean;
begin
  Result := False;

  if not Assigned(Dialog) then
    Exit;

  Dialog.Filter := '|*.' + Extension;
  try
    if Dialog.Execute then
    begin
      FileName := Dialog.FileName;

      if not FileName.EndsWith('.' + Extension) then
        FileName := FileName + '.' + Extension;

      Result := True;
    end;
  finally
    Dialog.Free;
  end;
end;

class function TDialogs.OpenFile(const Extension: string; out FileName: string): Boolean;
begin
  Result := OpenDialog(TOpenDialog.Create(nil), Extension, FileName);
end;

class function TDialogs.SaveFile(const Extension: string; out FileName: string): Boolean;
begin
  Result := OpenDialog(TSaveDialog.Create(nil), Extension, FileName);
end;

end.

