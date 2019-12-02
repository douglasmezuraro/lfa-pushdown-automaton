unit View.Main;

interface

uses
  FMX.ActnList, FMX.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Forms, FMX.Grid, FMX.Grid.Style,
  FMX.Layouts, FMX.ListBox, FMX.ScrollBox, FMX.StdCtrls, FMX.TabControl, FMX.Types, Helper.Edit,
  Helper.StringGrid, Impl.Dialogs, FMX.Platform,
  Impl.PushdownAutomaton, Impl.Transition, Impl.Transitions, Impl.Types, System.Actions,
  System.Classes, System.Rtti, System.SysUtils, System.UITypes;

type
  TMain = class sealed(TForm)
    ActionClear: TAction;
    ActionList: TActionList;
    ButtonClear: TButton;
    ColumnPop: TStringColumn;
    ColumnPush: TStringColumn;
    ColumnSource: TStringColumn;
    ColumnSymbol: TStringColumn;
    ColumnTarget: TStringColumn;
    EditAuxSymbols: TEdit;
    EditBase: TEdit;
    EditInitialState: TEdit;
    EditStates: TEdit;
    EditSymbols: TEdit;
    GridInput: TStringGrid;
    LabelAuxSymbols: TLabel;
    LabelBase: TLabel;
    LabelInitialState: TLabel;
    LabelStates: TLabel;
    LabelSymbols: TLabel;
    LabelTransitions: TLabel;
    PanelButtons: TPanel;
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    TabItemOutput: TTabItem;
    GridOutput: TStringGrid;
    ColumnInput: TStringColumn;
    ColumnResult: TStringColumn;
    ButtonCheck: TButton;
    ActionCheck: TAction;
    ButtonPasteLambda: TButton;
    ActionCopyLambda: TAction;
    procedure ActionClearExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ActionCheckExecute(Sender: TObject);
    procedure TabControlViewChange(Sender: TObject);
    procedure ActionCopyLambdaExecute(Sender: TObject);
  strict private
    FAutomaton: TPushdownAutomaton;
    function GetAuxSymbols: TArray<TSymbol>;
    function GetBase: TSymbol;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TTransitions;
  private
    procedure Check;
    procedure Clear;
    procedure Setup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property Symbols: TArray<TSymbol> read GetSymbols;
    property States: TArray<TState> read GetStates;
    property InitialState: TState read GetInitialState;
    property Transitions: TTransitions read GetTransitions;
    property Base: TSymbol read GetBase;
    property AuxSymbols: TArray<TSymbol> read GetAuxSymbols;
  end;

implementation

{$R *.fmx}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutomaton := TPushdownAutomaton.Create;
end;

destructor TMain.Destroy;
begin
  FAutomaton.Free;
  inherited Destroy;
end;

procedure TMain.Check;
begin
  Setup;
  try
    GridOutput.ForEach(
      procedure
      begin
        GridOutput.Value[ColumnResult] := Result[FAutomaton.Accept(GridOutput.Value[ColumnInput])];
      end);
  except
    on Exception: EArgumentException do
      TDialogs.Warning(Exception.Message);
  end;
end;

procedure TMain.Clear;
begin
  FAutomaton.Clear;
  EditSymbols.Clear;
  EditStates.Clear;
  EditInitialState.Clear;
  EditBase.Clear;
  EditAuxSymbols.Clear;
  GridInput.Clear;
  GridOutput.Clear;
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
begin
  Check;
end;

procedure TMain.ActionClearExecute(Sender: TObject);
begin
  Clear;
end;

procedure TMain.ActionCopyLambdaExecute(Sender: TObject);
begin
  IFMXClipboardService(TPlatformServices.Current.GetPlatformService(IFMXClipboardService)).SetClipboard(Lambda);
end;

procedure TMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if GridInput.IsFocused then
    GridInput.Notify(Key, Shift);

  if GridOutput.IsFocused then
    GridOutput.Notify(Key, Shift);
end;

procedure TMain.FormShow(Sender: TObject);
begin
  ButtonCheck.Visible := False;
  TabControlView.ActiveTab := TabItemInput;
end;

function TMain.GetAuxSymbols: TArray<TSymbol>;
begin
  Result := EditAuxSymbols.Text.Replace(' ', '').Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetBase: TSymbol;
begin
  Result := EditBase.Text.Replace(' ', '');
end;

function TMain.GetInitialState: TState;
begin
  Result := EditInitialState.Text.Replace(' ', '');
end;

function TMain.GetStates: TArray<TState>;
begin
  Result := EditStates.Text.Replace(' ', '').Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetSymbols: TArray<TSymbol>;
begin
  Result := EditSymbols.Text.Replace(' ', '').Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetTransitions: TTransitions;
begin
  FAutomaton.Transitions.Clear;

  GridInput.ForEach(
    procedure
    var
      Transition: TTransition;
    begin
      Transition        := TTransition.Create;
      Transition.Source := GridInput.Value[ColumnSource];
      Transition.Target := GridInput.Value[ColumnTarget];
      Transition.Symbol := GridInput.Value[ColumnSymbol];
      Transition.Push   := GridInput.Value[ColumnPush];
      Transition.Pop    := GridInput.Value[ColumnPop];

      FAutomaton.Transitions.Add(Transition);
    end);

  Result := FAutomaton.Transitions;
end;

procedure TMain.Setup;
begin
  FAutomaton.Clear;
  FAutomaton.Symbols      := Symbols;
  FAutomaton.States       := States;
  FAutomaton.InitialState := InitialState;
  FAutomaton.AuxSymbols   := AuxSymbols;
  FAutomaton.Base         := Base;
  FAutomaton.Transitions  := Transitions;
end;

procedure TMain.TabControlViewChange(Sender: TObject);
begin
  ButtonCheck.Visible := (Sender as TTabControl).ActiveTab <> TabItemInput;
end;

end.

