program AP;

uses
  System.StartUpCopy,
  FMX.Forms,
  Helper.FMX in '..\src\Helper\Helper.FMX.pas',
  Impl.AP in '..\src\Impl\Impl.AP.pas',
  Impl.Dialogs in '..\src\Impl\Impl.Dialogs.pas',
  Impl.List in '..\src\Impl\Impl.List.pas',
  Impl.Stack in '..\src\Impl\Impl.Stack.pas',
  Impl.Transitions in '..\src\Impl\Impl.Transitions.pas',
  Impl.Types in '..\src\Impl\Impl.Types.pas',
  View.Main in '..\src\View\View.Main.pas' {Main},
  Impl.AP.Validator in '..\src\Impl\Impl.AP.Validator.pas';

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;

  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := ByteBool(DebugHook);
  {$WARN SYMBOL_PLATFORM ON}
end.
