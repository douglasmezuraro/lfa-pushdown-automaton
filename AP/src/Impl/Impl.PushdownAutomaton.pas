unit Impl.PushdownAutomaton;

interface

uses
  System.SysUtils, Impl.Stack, Impl.Types, Impl.Transition, Impl.Transitions;

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
  State: TState;
  Stack: TStack;
  Symbol, SymbolToPush: TSymbol;
  Transition: TTransition;
begin
  Stack := TStack.Create;
  try
    State := InitialState;
    Stack.Push(FBase);

    for Symbol in Word do
    begin
      if not Transitions.HasTransition(State, Symbol, Stack.Peek) then
        Exit(False);

      Transition := Transitions.Transition(State, Symbol, Stack.Peek);

      State := Transition.Target;
      Stack.Pop;
      for SymbolToPush in Transition.Push.Split([',']) do
      begin
        Stack.Push(SymbolToPush);
      end;
    end;

    Result := Stack.IsEmpty;
  finally
    Stack.Free;
  end;
end;

procedure TPushdownAutomaton.Clear;
begin
  SetLength(FSymbols, 0);
  SetLength(FStates, 0);
  SetLength(FAuxSymbols, 0);
  FTransitions.Clear;
  FInitialState := TState.Empty;
  FBase := TSymbol.Empty;
end;

end.

