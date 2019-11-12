unit Impl.AP.Validator;

interface

uses
  System.SysUtils, Impl.AP, Impl.Types, Impl.List, Impl.Transitions;

type
  TAPValidator = class sealed
  strict private
    FError: string;
    FSymbols: TList;
    FStates: TList;
    FTransitions: TTransitions;
    FInitialState: TState;
    FBase: TSymbol;
    FAuxSymbols: TList;
  private
    function ValidateSymbols: Boolean;
    function ValidateStates: Boolean;
    function ValidateInitialState: Boolean;
    function ValidateAuxSymbols: Boolean;
    function ValidateBase: Boolean;
    function ValidateTransitions: Boolean;
  public
    constructor Create(const AP: TAP);
    destructor Destroy; override;
    function Validate(out Error: string): Boolean;
  end;

implementation

{ TAPValidator }

constructor TAPValidator.Create(const AP: TAP);
begin
  FSymbols      := TList.Create(AP.Symbols);
  FStates       := TList.Create(AP.States);
  FInitialState := AP.InitialState;
  FAuxSymbols   := TList.Create(AP.AuxSymbols);
  FBase         := AP.Base;
  FTransitions  := AP.Transitions;
end;

destructor TAPValidator.Destroy;
begin
  FSymbols.Free;
  FStates.Free;
  FAuxSymbols.Free;
  inherited Destroy;
end;

function TAPValidator.Validate(out Error: string): Boolean;
begin
  Result := True;
  try
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

    if not ValidateTransitions then
      Exit(False);
  finally
    if not Result then
      Error := FError;
  end;
end;

function TAPValidator.ValidateAuxSymbols: Boolean;
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

function TAPValidator.ValidateBase: Boolean;
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

function TAPValidator.ValidateInitialState: Boolean;
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

function TAPValidator.ValidateStates: Boolean;
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

function TAPValidator.ValidateSymbols: Boolean;
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

function TAPValidator.ValidateTransitions: Boolean;
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
