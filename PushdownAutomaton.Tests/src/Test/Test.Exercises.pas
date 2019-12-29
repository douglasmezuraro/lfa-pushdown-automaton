unit Test.Exercises;

interface

uses
  TestFramework, Impl.PushdownAutomaton, Impl.Transition, Impl.Types, System.SysUtils;

type
  TExercisesTest = class sealed(TTestCase)
  strict private
    FAutomaton: TPushdownAutomaton;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    /// <summary>
    ///   L1 = {(a^n)(b^n)/n>=0}
    /// </summary>
    procedure ExerciseOne;

    /// <summary>
    ///   L2 = {(a^n)(b^m)(c^n)/n>0;m>0}
    /// </summary>
    procedure ExerciseTwo;

    /// <summary>
    ///   L3 = {(a^n)(n^2n)/n>0}
    /// </summary>
    procedure ExerciseTree;

    /// <summary>
    ///   L4 = {(a^2n)(b^n)/n>=0}
    /// </summary>
    procedure ExerciseFour;

    /// <summary>
    ///   L5 = {(a^n)(b^m)(c^m)(d^n)/n>=0;m>=0}
    /// </summary>
    procedure ExerciseFive;

    /// <summary>
    ///   L6 = {Wε(a,b)*/|w|a=|w|b}
    /// </summary>
    procedure ExerciseSix;

    /// <summary>
    ///   L7 = {(a^n)(b^3m)(c^m)(d^2n)/n>=0;m>=0}
    /// </summary>
    procedure ExerciseSeven;

    /// <summary>
    ///   L8 = {(a^i)(b^j)(c^k)/i=j+k;j>=0;k>=0}
    /// </summary>
    procedure ExerciseEight;

    /// <summary>
    ///   L9 = {(a^i)(b^j)(c^k)/k=i+j;i>=0;j>=0}
    /// </summary>
    procedure ExerciseNine;

    /// <summary>
    ///   L10 = {(a^i)(b^j)(c^k)/j=i+k;j>=0;k>=0}
    /// </summary>
    procedure ExerciseTen;

    /// <summary>
    ///   L11 = {(a^n)(b^n)(c^m)(d^m)/n>=0;m>=0}
    /// </summary>
    procedure ExerciseEleven;

    /// <summary>
    ///   L12 = {(a^n)(b^(2n+1))/n>0}
    /// </summary>
    procedure ExerciseTwelve;

    /// <summary>
    ///   L13 = {(a^n)(b^(2n+2))/n>0}
    /// </summmary>
    procedure ExerciseThirteen;

    /// <summary>
    ///   L14 = {(a^n)(b^(n/2))/n>0;n é par}
    /// </summary>
    procedure ExerciseFourteen;

    /// <summary>
    ///   L15 = {(a^n)(b^(n/3))/n>0;n é múltiplo de 3}
    /// </summary>
    procedure ExerciseFifteen;

    /// <summary>
    ///   L16 = {Wε{a,b}*/|W|a é ímpar;|W|b é ímpar}
    /// </summary>
    procedure ExerciseSixteen;

    /// <summary>
    ///   L17 = {Wε{a,b}*/|W|a é par;|W|b é par}
    /// </summary>
    procedure ExerciseSeventeen;
  end;

implementation

procedure TExercisesTest.SetUp;
begin
  FAutomaton := TPushdownAutomaton.Create;
end;

procedure TExercisesTest.TearDown;
begin
  FAutomaton.Free;
end;

procedure TExercisesTest.ExerciseOne;
const
  AcceptedWords: TArray<TWord> = ['*', 'ab', 'aabb', 'aaabbb', 'aaaabbbb', 'aaaaabbbbb'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'ba', 'bbaa', 'aab', 'aaabb', 'abb', 'aabbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseTwo;
const
  AcceptedWords: TArray<TWord> = ['abc', 'abbc', 'abbbc', 'aabcc', 'aabbcc', 'aaabccc', 'aaabbccc'];
  RejectedWords: TArray<TWord> = ['*', 'a', 'b', 'c', 'ab', 'ac', 'bc', 'abcc', 'aabc', 'aabccc'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', 'X'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', 'X'))
                        .Add(TTransition.Create('q2', 'q3', 'c', 'X', '*'))
                        .Add(TTransition.Create('q3', 'q3', 'c', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseTree;
const
  AcceptedWords: TArray<TWord> = ['abb', 'aabbbb', 'aaabbbbbb', 'aaaabbbbbbbb', 'aaaaabbbbbbbbbb'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'ab', 'aabb', 'aaabbb', 'aab', 'aaaabb', 'aaaaaabbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'Z', 'XX'))
                        .Add(TTransition.Create('q0', 'q0', 'a', 'X', 'XXX'))
                        .Add(TTransition.Create('q0', 'q1', 'b', 'X', '*'))
                        .Add(TTransition.Create('q1', 'q1', 'b', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseFour;
const
  AcceptedWords: TArray<TWord> = ['*', 'aab', 'aaaabb', 'aaaaaabbb', 'aaaaaaaabbbb', 'aaaaaaaaaabbbbb'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'ab', 'aabb', 'aaabbb', 'abb', 'aabbbb', 'aaabbbbbb', 'aaaabbbbbbbb', 'aaaaabbbbbbbbbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q2', 'a', 'X', 'X'))
                        .Add(TTransition.Create('q2', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q2', 'q3', 'b', 'X', '*'))
                        .Add(TTransition.Create('q3', 'q3', 'b', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseFive;
const
  AcceptedWords: TArray<TWord> = ['*', 'ad', 'bc', 'aadd', 'bbcc', 'aaaddd', 'bbbccc', 'abcd', 'aabbccdd', 'aaabbccddd', 'aaabbbcccddd', 'aaaabbbcccdddd'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'c', 'd', 'ab', 'ac', 'bd', 'cd', 'aabcd', 'abcdd', 'abbcd', 'abccd', 'aabbcdd', 'aabccdd'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c', 'd'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q0', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q0', 'q0', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q0', 'q1', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q0', 'q1', 'b', 'Z', 'X'))
                        .Add(TTransition.Create('q0', 'q3', 'd', 'X', '*'))
                        .Add(TTransition.Create('q1', 'q1', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'c', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'c', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q3', 'd', 'X', '*'))
                        .Add(TTransition.Create('q3', 'q3', 'd', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseSix;
const
  AcceptedWords: TArray<TWord> = ['*', 'ab', 'ba', 'aabb', 'bbaa', 'abab', 'baba', 'abbaab', 'baabba', 'aabbabba'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'aab', 'bba', 'aba', 'bab', 'aaaa', 'bb', 'aa', 'abababa'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q0', 'q2', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q0', 'q2', 'b', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q3', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q2', 'q4', 'a', 'X', '*'))
                        .Add(TTransition.Create('q3', 'q1', 'a', '*', 'X'))
                        .Add(TTransition.Create('q3', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q3', 'q2', 'b', '*', 'X'))
                        .Add(TTransition.Create('q3', 'q3', 'b', 'X', '*'))
                        .Add(TTransition.Create('q4', 'q1', 'a', '*', 'X'))
                        .Add(TTransition.Create('q4', 'q2', 'b', '*', 'X'))
                        .Add(TTransition.Create('q4', 'q2', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q4', 'q4', 'a', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseSeven;
const
  AcceptedWords: TArray<TWord> = ['*', 'add', 'aadddd', 'aaadddddd', 'bbbc', 'bbbbbbcc', 'bbbbbbbbbccc', 'abbbcdd', 'aabbbbbbccdddd', 'aaabbbbbbbbbcccdddddd'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'c', 'd', 'abcd', 'aabbccdd', 'abcdd', 'aabcdddd', 'abbbcd', 'aabbbbbbccdd'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c', 'd'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4', 'q5'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XX'))
                        .Add(TTransition.Create('q0', 'q3', 'b', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XXX'))
                        .Add(TTransition.Create('q1', 'q1', 'd', 'X', '*'))
                        .Add(TTransition.Create('q1', 'q3', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q2', 'q2', 'd', 'X', '*'))
                        .Add(TTransition.Create('q3', 'q4', 'b', 'X', 'X'))
                        .Add(TTransition.Create('q4', 'q5', 'b', 'X', 'X'))
                        .Add(TTransition.Create('q5', 'q3', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q5', 'q6', 'c', 'X', '*'))
                        .Add(TTransition.Create('q6', 'q2', 'd', 'X', '*'))
                        .Add(TTransition.Create('q6', 'q6', 'c', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseEight;
const
  AcceptedWords: TArray<TWord> = ['*', 'ab', 'ac', 'aabc', 'aabb', 'aacc', 'aaabbc', 'aaabcc', 'aaaabbcc', 'aaaaabbbcc', 'aaaaaabbbccc'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'c', 'abc', 'aabbcc', 'aaabbbccc', 'abbcc', 'abbbccc', 'aaabc', 'aaaabc', 'abcc', 'abbc'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q1', 'q3', 'c', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q3', 'c', 'X', '*'))
                        .Add(TTransition.Create('q3', 'q3', 'c', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseNine;
const
  AcceptedWords: TArray<TWord> = ['*', 'ac', 'bc', 'abcc', 'aacc', 'bbcc', 'aabccc', 'abbccc', 'aabbcccc', 'aaabbccccc', 'aaabbbcccccc'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'c', 'abc', 'aabcc', 'abbcc', 'aabbccc', 'aaabbcccc', 'aabbbcccc'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q0', 'q2', 'b', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q3', 'c', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q2', 'q2', 'c', 'X', '*'))
                        .Add(TTransition.Create('q3', 'q3', 'c', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseTen;
const
  AcceptedWords: TArray<TWord> = ['*', 'ab', 'bc', 'abbc', 'aaabbbbbcc', 'aaabbb', 'aabbbbbbcccc'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'c', 'ac', 'abc', 'aabbcc', 'aabc', 'abcc'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q0', 'q3', 'b', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q3', 'b', '*', 'X'))
                        .Add(TTransition.Create('q3', 'q3', 'b', 'X', 'XX'))
                        .Add(TTransition.Create('q3', 'q4', 'c', 'X', '*'))
                        .Add(TTransition.Create('q4', 'q4', 'c', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseEleven;
const
  AcceptedWords: TArray<TWord> = ['*', 'ab', 'aabb', 'aaabbb', 'cd', 'ccdd', 'cccddd', 'abcd', 'aabbccdd', 'abccdd', 'abcccddd', 'aabbcd', 'aaaabbbbcd'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'c', 'd', 'ac', 'ad', 'bc', 'bd', 'abb', 'aab', 'cdd', 'ccd', 'aabccd', 'abbcdd'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c', 'd'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', '*', 'Z', '*'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q0', 'q3', 'c', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q3', 'c', '*', 'X'))
                        .Add(TTransition.Create('q3', 'q3', 'c', 'X', 'XX'))
                        .Add(TTransition.Create('q3', 'q4', 'd', 'X', '*'))
                        .Add(TTransition.Create('q4', 'q4', 'd', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseTwelve;
const
  AcceptedWords: TArray<TWord> = ['abbb', 'aabbbbb', 'aaabbbbbbb', 'aaaabbbbbbbbb', 'aaaaabbbbbbbbbbb'];
  RejectedWords: TArray<TWord> = ['*', 'a', 'b', 'ab', 'aab', 'aabb', 'aaab', 'aaabb', 'aaabbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XXX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseThirteen;
const
  AcceptedWords: TArray<TWord> = ['abbbb', 'aabbbbbb', 'aaabbbbbbbb', 'aaaabbbbbbbbbb', 'aaaaabbbbbbbbbbbb'];
  RejectedWords: TArray<TWord> = ['*', 'a', 'b', 'ab', 'aab', 'aabb', 'abbb', 'aabbbbb', 'aaabbbbbbb', 'aaaabbbbbbbbb', 'aaaaabbbbbbbbbbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXXX'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XXX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseFourteen;
const
  AcceptedWords: TArray<TWord> = ['aab', 'aaaabb', 'aaaaaabbb', 'aaaaaaaabbbb', 'aaaaaaaaaabbbbb', 'aaaaaaaaaaaabbbbbb'];
  RejectedWords: TArray<TWord> = ['*', 'a', 'b', 'ab', 'aabb', 'aaabbb', 'aaaabbb', 'aaaabbbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q0', 'q1', 'a', 'X', 'X'))
                        .Add(TTransition.Create('q1', 'q0', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'X', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'X', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseFifteen;
const
  AcceptedWords: TArray<TWord> = ['aaab', 'aaaaaabb', 'aaaaaaaaabbb', 'aaaaaaaaaaaabbbb', 'aaaaaaaaaaaaaaabbbbb', 'aaaaaaaaaaaaaaaaaabbbbbb'];
  RejectedWords: TArray<TWord> = ['a', 'b', 'aab', 'aabb', 'aaabbb', 'aaaabbb', 'aaaabbbb', 'aaaaabbbb', 'aaaaabbbbb', 'aaaaaabbbbb', 'aaaaaabbbbbb', 'aaaaaaabbbbbb', 'aaaaaaabbbbbbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'))
                        .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'))
                        .Add(TTransition.Create('q1', 'q2', 'b', 'XXX', '*'))
                        .Add(TTransition.Create('q2', 'q2', 'b', 'XXX', '*'));

  for Word in AcceptedWords do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in RejectedWords do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseSixteen;
begin
  Exit;
end;

procedure TExercisesTest.ExerciseSeventeen;
begin
  Exit;
end;

initialization
  RegisterTest(TExercisesTest.Suite);

end.

