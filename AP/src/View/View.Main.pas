unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.Edit, Impl.Stack;

type
  TMain = class(TForm)
    EditValue: TEdit;
    MemoValues: TMemo;
    ButtonPush: TButton;
    ButtonPop: TButton;
    procedure ButtonPushClick(Sender: TObject);
    procedure ButtonPopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FStack: TStack;
    function GetValue: string;
    procedure SetValue(const Value: string);
    procedure SyncStack;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Value: string read GetValue write SetValue;
  end;

implementation

{$R *.fmx}

procedure TMain.ButtonPopClick(Sender: TObject);
begin
  Value := FStack.Pop;
  SyncStack;
end;

procedure TMain.ButtonPushClick(Sender: TObject);
begin
  FStack.Push(Value);
  SyncStack;
end;

constructor TMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStack := TStack.Create;
end;

destructor TMain.Destroy;
begin
  FStack.Free;
  inherited Destroy;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  FStack.Clear;
  Value := string.Empty;
  SyncStack;
end;

function TMain.GetValue: string;
begin
  Result := EditValue.Text;
end;

procedure TMain.SetValue(const Value: string);
begin
  EditValue.Text := Value;
end;

procedure TMain.SyncStack;
begin
  MemoValues.Lines.Clear;
  MemoValues.Lines.AddStrings(FStack.ToArray);
end;

end.
