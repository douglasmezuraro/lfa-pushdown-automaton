unit View.Main;

interface

uses
  System.SysUtils, System.StrUtils, System.UITypes, System.Classes, System.Rtti, System.Actions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.StdCtrls, FMX.ScrollBox, FMX.Controls.Presentation,
  FMX.Edit, FMX.TabControl, FMX.ActnList, FMX.Layouts, FMX.ListBox, FMX.Grid, FMX.Grid.Style,
  Helper.Edit, Helper.StringGrid, Helper.ListBoxItem, Impl.PushdownAutomaton, Impl.Transition,
  Impl.Transitions, Impl.PushdownAutomaton.Validator, Impl.Types, Impl.Dialogs;

type
  TMain = class sealed(TForm)
    ActionBuild: TAction;
    ActionCheck: TAction;
    ActionClear: TAction;
    ActionList: TActionList;
    ButtonBuildAP: TButton;
    ButtonCheck: TButton;
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
    EditWord: TEdit;
    Grid: TStringGrid;
    LabelAuxSymbols: TLabel;
    LabelBase: TLabel;
    LabelInitialState: TLabel;
    LabelStates: TLabel;
    LabelSymbols: TLabel;
    LabelTransitions: TLabel;
    LabelWord: TLabel;
    LabelWords: TLabel;
    ListWords: TListBox;
    PanelButtons: TPanel;
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    TabItemOutput: TTabItem;
    procedure ActionBuildExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionCheckExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  strict private
    FAutomaton: TPushdownAutomaton;
    function GetAuxSymbols: TArray<TSymbol>;
    function GetBase: TSymbol;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TTransitions;
    function GetWord: TWord;
  private
    procedure Build;
    procedure Check;
    procedure Clear;
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
    property Word: TWord read GetWord;
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

procedure TMain.Build;
var
  Validator: TValidator;
begin
  EditWord.Clear;
  ListWords.Clear;

  Validator := TValidator.Create;
  try
    FAutomaton.Clear;
    FAutomaton.Symbols      := Symbols;
    FAutomaton.States       := States;
    FAutomaton.InitialState := InitialState;
    FAutomaton.AuxSymbols   := AuxSymbols;
    FAutomaton.Base         := Base;
    FAutomaton.Transitions  := Transitions;

    if Validator.Validate(FAutomaton) then
    begin
      TabControlView.Next;
      Exit;
    end;

    TDialogs.Warning(Validator.Error);
  finally
    Validator.Free;
  end;
end;

procedure TMain.Check;
var
  Item: TListBoxItem;
begin
  Item := TListBoxItem.Create(ListWords);
  try
    Item.Check(FAutomaton.Accept(Word));
    Item.Text := IfThen(Word.IsEmpty, Empty, Word);

    ListWords.AddObject(Item);
  except
    on E: Exception do
    begin
      TDialogs.Warning(E.Message);
    end;
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
  EditWord.Clear;
  ListWords.Clear;
  Grid.Clear;
end;

procedure TMain.ActionBuildExecute(Sender: TObject);
begin
  Build;
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
begin
  Check;
end;

procedure TMain.ActionClearExecute(Sender: TObject);
begin
  Clear;
end;

procedure TMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Grid.Notify(Key, Shift);
end;

procedure TMain.FormShow(Sender: TObject);
begin
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

  Grid.ForEach(
    procedure
    var
      Transition: TTransition;
    begin
      Transition        := TTransition.Create;
      Transition.Source := Grid.Value[ColumnSource];
      Transition.Target := Grid.Value[ColumnTarget];
      Transition.Symbol := Grid.Value[ColumnSymbol];
      Transition.Push   := Grid.Value[ColumnPush];
      Transition.Pop    := Grid.Value[ColumnPop];

      FAutomaton.Transitions.Add(Transition);
    end);

  Result := FAutomaton.Transitions;
end;

function TMain.GetWord: TWord;
begin
  Result := EditWord.Text.Replace(' ', '');
end;

end.

