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
  FTransitions := TTransitions.Create;
end;

destructor TPushdownAutomaton.Destroy;
begin
  FTransitions.Free;
  inherited Destroy;
end;

function TPushdownAutomaton.Accept(const Word: TWord): Boolean;
var
  Stack: TStack;
  State: TState;
  Symbol, Push: TSymbol;
  Transition: TTransition;
begin
  Stack := TStack.Create;
  try
    State := FInitialState;
    Stack.Push(FBase);

    for Symbol in Word do
    begin
      Transition := Transitions.Transition(State, Symbol, Stack.Peek);

      if not Assigned(Transition) then
        Exit(False);

      State := Transition.Target;
      Stack.Pop;

      for Push in Transition.Push do
      begin
        if not Push.Equals(Lambda)  then
          Stack.Push(Push);
      end;
    end;

    Result := Stack.IsEmpty;
  finally
    Stack.Free;
  end;
end;

procedure TPushdownAutomaton.Clear;
begin
  FSymbols := nil;
  FStates := nil;
  FAuxSymbols := nil;
  FTransitions.Clear;
  FInitialState := TState.Empty;
  FBase := TSymbol.Empty;
end;

end.

