program AudioInputDemo;

uses
  Forms,
  TAudioInputDemo in 'TAudioInputDemo.pas' {Form1},
  FFTReal in 'fftreal.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
