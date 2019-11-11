unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.Edit, Impl.AP,
  FMX.TabControl, System.Actions, FMX.ActnList, Impl.Types, Impl.Transitions,
  FMX.Layouts, FMX.ListBox, Impl.Dialogs, Helper.FMX, System.StrUtils,
  System.Rtti, FMX.Grid.Style, FMX.Grid;

type
  TMain = class sealed(TForm)
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    TabItemOutput: TTabItem;
    PanelButtons: TPanel;
    ButtonBuildAP: TButton;
    ActionList: TActionList;
    ActionBuildAP: TAction;
    ButtonClear: TButton;
    ActionClear: TAction;
    EditSymbols: TEdit;
    LabelSymbols: TLabel;
    EditStates: TEdit;
    LabelStates: TLabel;
    LabelInitialState: TLabel;
    EditInitialState: TEdit;
    LabelBase: TLabel;
    EditBase: TEdit;
    LabelAuxSymbols: TLabel;
    EditAuxSymbols: TEdit;
    LabelWord: TLabel;
    EditWord: TEdit;
    ButtonCheck: TButton;
    ActionCheck: TAction;
    LabelWords: TLabel;
    ListWords: TListBox;
    LabelTransitions: TLabel;
    MemoTransitions: TMemo;
    ButtonFoo: TButton;
    procedure ActionBuildAPExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionCheckExecute(Sender: TObject);
    procedure ButtonFooClick(Sender: TObject);
  private
    FAP: TAP;
    FTransitions: TTransitions;
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

procedure TMain.ActionBuildAPExecute(Sender: TObject);
begin
  EditWord.Text := TWord.Empty;
  ListWords.Items.Clear;
  try
    FAP := FAP.AddSymbols(Symbols)
              .AddStates(States)
              .AddInitialState(InitialState)
              .AddBase(Base)
              .AddAuxSymbols(AuxSymbols)
              .AddTransitions(Transitions);

    TabControlView.Next;
  except
    on E: Exception do
    begin
      TDialogs.Warning(E.Message);
    end;
  end;
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
var
  Item: TListBoxItem;
begin
  Item := TListBoxItem.Create(ListWords);
  try
    Item.Check(FAP.Accept(Word));
    Item.Text := IfThen(Word.IsEmpty, Impl.AP.TAP.EmptySymbol, Word);

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
  FTransitions.Clear;
  FAP.Clear;
  EditSymbols.Text := string.Empty;
  EditStates.Text := string.Empty;
  EditInitialState.Text := string.Empty;
  EditBase.Text := string.Empty;
  EditAuxSymbols.Text := string.Empty;
  EditWord.Text := string.Empty;
  ListWords.Items.Clear;
end;

procedure TMain.ButtonFooClick(Sender: TObject);
var
  a: TTransitions;
begin
  a := Transitions;
end;

constructor TMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAP := Impl.AP.TAP.Create;
  FTransitions := TTransitions.Create;
end;

destructor TMain.Destroy;
begin
  FTransitions.Free;
  FAP.Free;
  inherited Destroy;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  TabControlView.ActiveTab := TabItemInput;
end;

function TMain.GetAuxSymbols: TArray<TSymbol>;
begin
  Result := EditAuxSymbols.Text.Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetBase: TSymbol;
begin
  Result := EditBase.Text;
end;

function TMain.GetInitialState: TState;
begin
  Result := EditInitialState.Text;
end;

function TMain.GetStates: TArray<TState>;
begin
  Result := EditStates.Text.Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetSymbols: TArray<TSymbol>;
begin
  Result := EditSymbols.Text.Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetTransitions: TTransitions;
var
  Line: string;
begin
  FTransitions.Clear;

  for Line in MemoTransitions.Lines.ToStringArray do
    FTransitions.Add(Line);

  Result := FTransitions;
end;

function TMain.GetWord: TWord;
begin
  Result := EditWord.Text;
end;

end.
