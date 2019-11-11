unit Impl.Dialogs;

interface

uses
  FMX.Dialogs, FMX.DialogService, System.SysUtils, System.UITypes;

type
  TDialogs = class sealed
  private
    const HelpCtx = 0;
  public
    class function Confirmation(const Message: string): Boolean; overload;
    class function Confirmation(const Message: string; const Args: array of const): Boolean; overload;
    class procedure Error(const Message: string); overload;
    class procedure Error(const Message: string; const Args: array of const); overload;
    class procedure Information(const Message: string); overload;
    class procedure Information(const Message: string; const Args: array of const); overload;
    class procedure Warning(const Message: string); overload;
    class procedure Warning(const Message: string; const Args: array of const); overload;
  end;

implementation

{ TDialogs }

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

class function TDialogs.Confirmation(const Message: string; const Args: array of const): Boolean;
begin
  Result := Confirmation(Format(Message, Args));
end;

class procedure TDialogs.Error(const Message: string; const Args: array of const);
begin
  Error(Format(Message, Args));
end;

class procedure TDialogs.Error(const Message: string);
begin
  TDialogService.MessageDialog(Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class procedure TDialogs.Information(const Message: string);
begin
  TDialogService.MessageDialog(Message, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class procedure TDialogs.Information(const Message: string; const Args: array of const);
begin
  Information(Format(Message, Args));
end;

class procedure TDialogs.Warning(const Message: string);
begin
  TDialogService.MessageDialog(Message, TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class procedure TDialogs.Warning(const Message: string; const Args: array of const);
begin
  Warning(Format(Message, Args));
end;

end.

