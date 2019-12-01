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
  private
    function InternalAccept(const Word: TWord): Boolean;
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

uses
  Impl.Validator;

constructor TPushdownAutomaton.Create;
begin
  FTransitions := TTransitions.Create;
end;

destructor TPushdownAutomaton.Destroy;
begin
  FTransitions.Free;
  inherited Destroy;
end;

function TPushdownAutomaton.InternalAccept(const Word: TWord): Boolean;
var
  State: TState;
  Stack: TStack;
  Symbol, ToPush: TSymbol;
  Transition: TTransition;
begin
  Stack := TStack.Create;
  try
    State := InitialState;
    Stack.Push(FBase);

    for Symbol in Word do
    begin
      Transition := Transitions.Transition(State, Symbol, Stack.Peek);

      if not Assigned(Transition) then
        Exit(False);

      State := Transition.Target;
      Stack.Pop;

      for ToPush in Transition.Push do
        Stack.Push(ToPush);
    end;

    Result := Stack.IsEmpty;
  finally
    Stack.Free;
  end;
end;

function TPushdownAutomaton.Accept(const Word: TWord): Boolean;
var
  Validator: TValidator;
begin
  Validator := TValidator.Create;
  try
    if not Validator.Validate(Self) then
      raise EArgumentException.Create(Validator.Error);

    Result := InternalAccept(Word);
  finally
    Validator.Free;
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

