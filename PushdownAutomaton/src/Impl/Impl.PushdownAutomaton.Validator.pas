unit Impl.PushdownAutomaton.Validator;

interface

uses
  Impl.List, Impl.PushdownAutomaton, Impl.Transition, Impl.Transitions, Impl.Types, System.SysUtils;

type
  TValidator = class sealed
  strict private
    FAuxSymbols: TList;
    FBase: TSymbol;
    FError: string;
    FInitialState: TState;
    FStates: TList;
    FSymbols: TList;
    FTransitions: TTransitions;
  private
    function ValidateAuxSymbols: Boolean;
    function ValidateBase: Boolean;
    function ValidateInitialState: Boolean;
    function ValidateStates: Boolean;
    function ValidateSymbols: Boolean;
    function ValidateTransitions: Boolean;
    procedure Setup(const Automaton: TPushdownAutomaton);
  public
    constructor Create;
    destructor Destroy; override;
    function Validate(const Automaton: TPushdownAutomaton): Boolean;
    property Error: string read FError;
  end;

implementation

constructor TValidator.Create;
begin
  FSymbols := TList.Create;
  FStates := TList.Create;
  FAuxSymbols := TList.Create;
  FInitialState := TState.Empty;
  FBase := TSymbol.Empty;
  FError := string.Empty;
end;

destructor TValidator.Destroy;
begin
  FSymbols.Free;
  FStates.Free;
  FAuxSymbols.Free;
  inherited Destroy;
end;

procedure TValidator.Setup(const Automaton: TPushdownAutomaton);
begin
  FSymbols.Add(Automaton.Symbols);
  FStates.Add(Automaton.States);
  FAuxSymbols.Add(Automaton.AuxSymbols);
  FInitialState := Automaton.InitialState;
  FBase := Automaton.Base;
  FTransitions := Automaton.Transitions;
end;

function TValidator.Validate(const Automaton: TPushdownAutomaton): Boolean;
begin
  Setup(Automaton);

  if not ValidateSymbols then
    Exit(False);

  if not ValidateStates then
    Exit(False);

  if not ValidateInitialState then
    Exit(False);

  if not ValidateAuxSymbols then
    Exit(False);

  if not ValidateBase then
    Exit(False);

  Result := ValidateTransitions;
end;

function TValidator.ValidateAuxSymbols: Boolean;
var
  Symbol: TSymbol;
begin
  Result := False;

  if FSymbols.IsEmpty then
  begin
    FError := 'The aux symbols is not defined.';
    Exit;
  end;

  if FSymbols.HasDuplicated(Symbol) then
  begin
    FError := Format('The aux symbol %s is duplicated.', [Symbol.QuotedString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateBase: Boolean;
begin
  Result := False;

  if FBase.IsEmpty then
  begin
    FError := 'The base is not defined.';
    Exit;
  end;

  if not FAuxSymbols.Contains(FBase) then
  begin
    FError := Format('The base %s is not in aux symbols %s.', [FBase.QuotedString, FAuxSymbols.ToString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateInitialState: Boolean;
begin
  Result := False;

  if FInitialState.IsEmpty then
  begin
    FError := 'The initial state is not defined.';
    Exit;
  end;

  if not FStates.Contains(FInitialState) then
  begin
    FError := Format('The state %s is not in states list %s.', [FInitialState.QuotedString, FStates.ToString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateStates: Boolean;
var
  State: TState;
begin
  Result := False;

  if FStates.IsEmpty then
  begin
    FError := 'The states is not defined.';
    Exit;
  end;

  if FStates.HasDuplicated(State) then
  begin
    FError := Format('The state %s is duplicated.', [State.QuotedString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateSymbols: Boolean;
var
  Symbol: TSymbol;
begin
  Result := False;

  if FSymbols.IsEmpty then
  begin
    FError := 'The symbols is not defined.';
    Exit;
  end;

  if FSymbols.HasDuplicated(Symbol) then
  begin
    FError := Format('The symbol %s is duplicated.', [Symbol.QuotedString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateTransitions: Boolean;
var
  Transition: TTransition;
  Symbol: TSymbol;
begin
  Result := False;

  if FTransitions.IsEmpty then
  begin
    FError := 'The transitions has been not defined.';
    Exit;
  end;

  for Transition in FTransitions.ToArray do
  begin
    if not FStates.Contains(Transition.Source) then
    begin
      FError := Format('The source state %s is not in states list %s.', [Transition.Source.QuotedString, FStates.ToString]);
      Exit;
    end;

    if not FSymbols.Contains(Transition.Symbol) then
    begin
      FError := Format('The symbol %s is not in symbols list %s.', [Transition.Symbol.QuotedString, FSymbols.ToString]);
      Exit;
    end;

    for Symbol in Transition.Pop do
    begin
      if not FAuxSymbols.Contains(Symbol) then
      begin
        FError := Format('The pop symbol %s is not in aux symbols list %s.', [Symbol.QuotedString, FAuxSymbols.ToString]);
        Exit;
      end;
    end;

    if not FStates.Contains(Transition.Target) then
    begin
      FError := Format('The target state %s is not in states list %s.', [Transition.Target.QuotedString, FStates.ToString]);
      Exit;
    end;

    for Symbol in Transition.Push do
    begin
      if not FAuxSymbols.Contains(Symbol) then
      begin
        FError := Format('The push symbol %s is not in aux symbols list %s.', [Symbol.QuotedString, FAuxSymbols.ToString]);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

end.

