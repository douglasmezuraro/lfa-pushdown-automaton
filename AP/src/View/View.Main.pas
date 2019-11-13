unit View.Main;

interface

uses
  FMX.ActnList, FMX.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Forms, FMX.Grid, FMX.Grid.Style,
  FMX.Layouts, FMX.ListBox, FMX.ScrollBox, FMX.StdCtrls, FMX.TabControl, FMX.Types, Helper.Edit,
  Helper.Hyperlink, Helper.ListBox, Helper.ListBoxItem, Helper.StringGrid, Impl.Dialogs,
  Impl.PushdownAutomaton, Impl.Transition, Impl.Transitions, Impl.Types, System.Actions,
  System.Classes, System.Rtti, System.StrUtils, System.SysUtils, System.UITypes, Winapi.UrlMon;

type
  TMain = class sealed(TForm)
    ActionCheck: TAction;
    ActionClear: TAction;
    ActionList: TActionList;
    ActionOpenURL: TAction;
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
    GroupBoxAbout: TGroupBox;
    GroupBoxShortcuts: TGroupBox;
    LabelAuxSymbols: TLabel;
    LabelBase: TLabel;
    LabelInitialState: TLabel;
    LabelShortcutDelete: TLabel;
    LabelShortcutInsert: TLabel;
    LabelStates: TLabel;
    LabelSymbols: TLabel;
    LabelTransitions: TLabel;
    LabelURL: TLabel;
    LabelWord: TLabel;
    LabelLog: TLabel;
    ListLog: TListBox;
    PanelButtons: TPanel;
    TabControlView: TTabControl;
    TabItemAbout: TTabItem;
    TabItemInput: TTabItem;
    TabItemOutput: TTabItem;
    procedure ActionCheckExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionOpenURLExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure LabelURLMouseLeave(Sender: TObject);
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
    procedure Check;
    procedure Clear;
    procedure OpenURL(const URL: string);
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

procedure TMain.Check;
begin
  try
    FAutomaton.Clear;
    FAutomaton.Symbols      := Symbols;
    FAutomaton.States       := States;
    FAutomaton.InitialState := InitialState;
    FAutomaton.AuxSymbols   := AuxSymbols;
    FAutomaton.Base         := Base;
    FAutomaton.Transitions  := Transitions;

    ListLog.Add(Word, FAutomaton.Accept(Word));
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
  EditWord.Clear;
  ListLog.Clear;
  Grid.Clear;
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
begin
  Check;
end;

procedure TMain.ActionClearExecute(Sender: TObject);
begin
  Clear;
end;

procedure TMain.ActionOpenURLExecute(Sender: TObject);
begin
  OpenURL(((Sender as TAction).ActionComponent as TLabel).Text);
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
  Result := IfThen(EditWord.Text.Trim.IsEmpty, Empty, EditWord.Text.Replace(' ', ''));
end;

procedure TMain.LabelURLMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).SetStyle(TLabelStyle.lsLabel);
end;

procedure TMain.OpenURL(const URL: string);
begin
  HlinkNavigateString(nil, PWideChar(URL));
end;

end.

