unit Impl.PushdownAutomaton;

interface

uses
  Impl.Stack, Impl.Transition, Impl.Transitions, Impl.Types, System.SysUtils;

type
  TPushdownAutomaton = class sealed
  strict private
    FSymbols: TArray<TState>;
    FStates: TArray<TState>;
    FTransitions: TTransitions;
    FInitialState: TState;
    FBase: TSymbol;
    FAuxSymbols: TArray<TState>;
    FStack: TStack;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Accept(const Word: TWord): Boolean;
  public
    property Symbols: TArray<TSymbol> read FSymbols write FSymbols;
    property States: TArray<TState> read FStates write FStates;
    property InitialState: TState read FInitialState write FInitialState;
    property AuxSymbols: TArray<TSymbol> read FAuxSymbols write FAuxSymbols;
    property Base: TSymbol read FBase write FBase;
    property Transitions: TTransitions read FTransitions write FTransitions;
  end;

implementation

constructor TPushdownAutomaton.Create;
begin
  FStack := TStack.Create;
  FTransitions := TTransitions.Create;
end;

destructor TPushdownAutomaton.Destroy;
begin
  FTransitions.Free;
  FStack.Free;
  inherited Destroy;
end;

function TPushdownAutomaton.Accept(const Word: TWord): Boolean;
var
  State: TState;
  Symbol, Pop, Push: TSymbol;
  Transition: TTransition;
begin
  State := FInitialState;
  FStack.Clear.Push(FBase);

  for Symbol in Word do
  begin
    Transition := Transitions.Transition(State, Symbol, FStack.Peek);

    if not Assigned(Transition) then
      Exit(False);

    State := Transition.Target;

    for Pop in Transition.Pop do
    begin
      if Pop <> Lambda then
      begin
        if FStack.IsEmpty then
          Exit(False);

        FStack.Pop;
      end;
    end;

    for Push in Transition.Push do
    begin
      if Push <> Lambda  then
        FStack.Push(Push);
    end;
  end;

  Result := FStack.IsEmpty;
end;

procedure TPushdownAutomaton.Clear;
begin
  FSymbols := nil;
  FStates := nil;
  FAuxSymbols := nil;
  FStack.Clear;
  FTransitions.Clear;
  FInitialState := TState.Empty;
  FBase := TSymbol.Empty;
end;

end.

