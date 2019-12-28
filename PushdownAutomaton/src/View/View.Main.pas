unit View.Main;

interface

uses
  FMX.ActnList, FMX.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Forms, FMX.Grid, FMX.Grid.Style,
  FMX.Layouts, FMX.ListBox, FMX.ScrollBox, FMX.StdCtrls, FMX.TabControl, FMX.Types, Helper.Edit,
  Helper.StringGrid, Impl.Dialogs, FMX.Platform, Impl.PushdownAutomaton, Impl.Transition, Impl.Transitions,
  Impl.Types, System.Actions, System.Classes, System.Rtti, System.SysUtils, System.UITypes, Impl.Validator,
  System.StrUtils, FMX.Menus, FMX.Dialogs, REST.Json, Helper.Json;

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
    MenuBar: TMenuBar;
    MenuItemFile: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemSave: TMenuItem;
    ActionOpen: TAction;
    ActionSave: TAction;
    procedure ActionClearExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ActionCheckExecute(Sender: TObject);
    procedure TabControlViewChange(Sender: TObject);
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
  strict private
    FAutomaton: TPushdownAutomaton;
    function GetAuxSymbols: TArray<TSymbol>;
    procedure SetAuxSymbols(const Symbols: TArray<TSymbol>);
    function GetBase: TSymbol;
    procedure SetBase(const Base: TSymbol);
    function GetInitialState: TState;
    procedure SetInitialState(const State: TState);
    function GetStates: TArray<TState>;
    procedure SetStates(const States: TArray<TState>);
    function GetSymbols: TArray<TSymbol>;
    procedure SetSymbols(const Symbols: TArray<TSymbol>);
    function GetTransitions: TTransitions;
    procedure SetTransitions(const Transitions: TTransitions);
  private
    function Validate: TValidationResult;
    procedure Check;
    procedure Clear;
    procedure OpenFile;
    procedure SaveFile;
    procedure ViewToModel;
    procedure ModelToView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property Symbols: TArray<TSymbol> read GetSymbols write SetSymbols;
    property States: TArray<TState> read GetStates write SetStates;
    property InitialState: TState read GetInitialState write SetInitialState;
    property Transitions: TTransitions read GetTransitions write SetTransitions;
    property Base: TSymbol read GetBase write SetBase;
    property AuxSymbols: TArray<TSymbol> read GetAuxSymbols write SetAuxSymbols;
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
  ViewToModel;

  if not Validate.Key then
  begin
    TDialogs.Warning(Validate.Value);
    Exit;
  end;

  GridOutput.ForEach(procedure
                     begin
                       GridOutput.Value[ColumnResult] := ResultMessage[FAutomaton.Accept(GridOutput.Value[ColumnInput])];
                     end);
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

procedure TMain.ActionOpenExecute(Sender: TObject);
begin
  OpenFile;
end;

procedure TMain.ActionSaveExecute(Sender: TObject);
begin
  SaveFile;
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
      Transition := TTransition.Create;
      Transition.Source := GridInput.Value[ColumnSource];
      Transition.Target := GridInput.Value[ColumnTarget];
      Transition.Symbol := GridInput.Value[ColumnSymbol];
      Transition.Push := GridInput.Value[ColumnPush];
      Transition.Pop := GridInput.Value[ColumnPop];

      FAutomaton.Transitions.Add(Transition);
    end);

  Result := FAutomaton.Transitions;
end;

procedure TMain.ModelToView;
begin
  Symbols := FAutomaton.Symbols;
  States := FAutomaton.States;
  InitialState := FAutomaton.InitialState;
  AuxSymbols := FAutomaton.AuxSymbols;
  Base := FAutomaton.Base;
  Transitions := FAutomaton.Transitions;
end;

procedure TMain.OpenFile;
var
  FileName: string;
begin
  if TDialogs.OpenFile('json', FileName) then
  begin
    if Assigned(FAutomaton) then
      FAutomaton.Free;

    FAutomaton := TJson.OpenFromFile<TPushdownAutomaton>(FileName);
    ModelToView;
  end;
end;

procedure TMain.SaveFile;
var
  FileName: string;
begin
  if TDialogs.SaveFile('json', FileName) then
  begin
    ViewToModel;
    TJson.SaveToFile<TPushdownAutomaton>(FAutomaton, FileName);
  end;
end;

procedure TMain.SetAuxSymbols(const Symbols: TArray<TSymbol>);
begin
  EditAuxSymbols.Text := string.Join(', ', Symbols);
end;

procedure TMain.SetBase(const Base: TSymbol);
begin
  EditBase.Text := Base;
end;

procedure TMain.SetInitialState(const State: TState);
begin
  EditInitialState.Text := State;
end;

procedure TMain.SetStates(const States: TArray<TState>);
begin
  EditStates.Text := string.Join(', ', States);
end;

procedure TMain.SetSymbols(const Symbols: TArray<TSymbol>);
begin
  EditSymbols.Text := string.Join(', ', Symbols);
end;

procedure TMain.SetTransitions(const Transitions: TTransitions);
var
  Transition: TTransition;
begin
  GridInput.Clear;
  for Transition in Transitions.Values do
  begin
    GridInput.Insert;
    GridInput.Value[ColumnSource] := Transition.Source;
    GridInput.Value[ColumnTarget] := Transition.Target;
    GridInput.Value[ColumnSymbol] := Transition.Symbol;
    GridInput.Value[ColumnPush] := Transition.Push;
    GridInput.Value[ColumnPop] := Transition.Pop;
  end;
end;

procedure TMain.ViewToModel;
begin
  FAutomaton.Clear;
  FAutomaton.Symbols := Symbols;
  FAutomaton.States := States;
  FAutomaton.InitialState := InitialState;
  FAutomaton.AuxSymbols := AuxSymbols;
  FAutomaton.Base := Base;
  FAutomaton.Transitions := Transitions;
end;

procedure TMain.TabControlViewChange(Sender: TObject);
begin
  ButtonCheck.Visible := (Sender as TTabControl).ActiveTab <> TabItemInput;
end;

function TMain.Validate: TValidationResult;
var
  Validator: TValidator;
begin
  Validator := TValidator.Create;
  try
    Result := Validator.Validate(FAutomaton);
  finally
    Validator.Free;
  end;
end;

end.

