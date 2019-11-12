unit Impl.AP;

interface

uses
  System.SysUtils, Impl.Stack, Impl.Types, Impl.Transitions;

type
  TAP = class sealed
  private
    FSymbols: TArray<TState>;
    FStates: TArray<TState>;
    FTransitions: TTransitions;
    FInitialState: TState;
    FBase: TSymbol;
    FAuxSymbols: TArray<TState>;
  public const
    Empty: TSymbol = 'ʎ';
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

{ TAP }

constructor TAP.Create;
begin
  FTransitions := TTransitions.Create;
end;

destructor TAP.Destroy;
begin
  FTransitions.Free;
  inherited Destroy;
end;

function TAP.Accept(const Word: TWord): Boolean;
var
  State: TState;
  Stack: TStack;
  Symbol: TSymbol;
  SymbolToPush: TSymbol;
  Transition: TTransition;
begin
  Stack := TStack.Create;
  try
    State := InitialState;
    Stack.Push(FBase);

    for Symbol in Word do
    begin
      if Transitions.HasTransition(State, Symbol, Stack.Peek) then
      begin
        Transition := Transitions.Transition(State, Symbol, Stack.Peek);
        State := Transition.Target;
        Stack.Pop;
        for SymbolToPush in Transition.Push.Split([',']) do
        begin
          Stack.Push(SymbolToPush);
        end;
      end
      else
        Exit(False);
    end;

    Result := Stack.IsEmpty;
  finally
    Stack.Free;
  end;
end;

procedure TAP.Clear;
begin
  SetLength(FSymbols, 0);
  SetLength(FStates, 0);
  SetLength(FAuxSymbols, 0);
  FTransitions.Clear;
  FInitialState := TState.Empty;
  FBase := TSymbol.Empty;
end;

end.

