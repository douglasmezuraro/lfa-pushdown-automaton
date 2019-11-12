unit View.Main;

interface

uses
  System.SysUtils, System.StrUtils, System.UITypes, System.Classes, System.Rtti, System.Actions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.StdCtrls, FMX.ScrollBox, FMX.Controls.Presentation,
  FMX.Edit, FMX.TabControl, FMX.ActnList, FMX.Layouts, FMX.ListBox, FMX.Grid, FMX.Grid.Style,
  Helper.FMX, Impl.AP, Impl.AP.Validator, Impl.Types, Impl.Transitions, Impl.Dialogs;

type
  TMain = class sealed(TForm)
    ActionBuildAP: TAction;
    ActionCheck: TAction;
    ActionClear: TAction;
    ActionList1: TActionList;
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
    procedure ActionBuildAPExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionCheckExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    FAP: TAP;
    function GetAuxSymbols: TArray<TSymbol>;
    function GetBase: TSymbol;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TTransitions;
    function GetWord: TWord;
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
  FAP := Impl.AP.TAP.Create;
end;

destructor TMain.Destroy;
begin
  FAP.Free;
  inherited Destroy;
end;

procedure TMain.ActionBuildAPExecute(Sender: TObject);
var
  Validator: TAPValidator;
  Msg: string;
begin
  EditWord.Text := TWord.Empty;
  ListWords.Items.Clear;

  FAP.Clear;
  FAP.Symbols      := Symbols;
  FAP.States       := States;
  FAP.InitialState := InitialState;
  FAP.AuxSymbols   := AuxSymbols;
  FAP.Base         := Base;
  FAP.Transitions  := Transitions;

  Validator := TAPValidator.Create(FAP);
  try
    if Validator.Validate(Msg) then
    begin
      TabControlView.Next;
      Exit;
    end;

    TDialogs.Warning(Msg);
  finally
    Validator.Free;
  end;
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
var
  Item: TListBoxItem;
begin
  Item := TListBoxItem.Create(ListWords);
  try
    Item.Check(FAP.Accept(Word));
    Item.Text := IfThen(Word.IsEmpty, Impl.AP.TAP.Empty, Word);

    ListWords.AddObject(Item);
  except
    on E: Exception do
    begin
      TDialogs.Warning(E.Message);
    end;
  end;
end;

procedure TMain.ActionClearExecute(Sender: TObject);
begin
  FAP.Clear;
  EditSymbols.Text := string.Empty;
  EditStates.Text := string.Empty;
  EditInitialState.Text := string.Empty;
  EditBase.Text := string.Empty;
  EditAuxSymbols.Text := string.Empty;
  EditWord.Text := string.Empty;
  ListWords.Items.Clear;
end;

procedure TMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if not (ssCtrl in Shift) then
    Exit;

  case Key of
    vkInsert: Grid.Insert;
    vkDelete: Grid.Delete;
  end;
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
  FAP.Transitions.Clear;

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

      FAP.Transitions.Add(Transition);
    end);

  Result := FAP.Transitions;
end;

function TMain.GetWord: TWord;
begin
  Result := EditWord.Text.Replace(' ', '');
end;

end.

