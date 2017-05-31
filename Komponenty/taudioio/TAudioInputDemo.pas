unit TAudioInputDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AudioIO, ExtCtrls, Buttons, ComCtrls, MMSYSTEM, FFTReal, Math;

type
  TForm1 = class(TForm)
    StartButton: TButton;
    Timer1: TTimer;
    StopButton: TButton;
    RunStatusLabel: TLabel;
    BufferStatusLabel: TLabel;
    TimeStatusLabel: TLabel;
    Panel1: TPanel;
    RecordSpeedButton: TSpeedButton;
    ProgressBar1: TProgressBar;
    MaxLabel: TLabel;
    AudioIn1: TAudioIn;
    Button1: TButton;
    Image1: TImage;
    Timer2: TTimer;
    TbVol: TTrackBar;
    Image2: TImage;
    procedure StartButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AudioIn1Stop(Sender: TObject);
    procedure UpdateStatus;
    procedure StopButtonClick(Sender: TObject);
    procedure RecordSpeedButtonClick(Sender: TObject);
    function AudioIn1BufferFilled(Buffer: PAnsiChar;
      var Size: Integer): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Min, Max : Integer;
    TempMax  : Integer;
  end;

const
  RecBuffSize = 4096;

var
  Form1: TForm1;
  AudioBuffer: array[0..RecBuffSize] of Integer;
  Audio_pflt: pflt_array;
  FFT_L,FFT_R: pflt_array;
  FFTOutput: pflt_array;
  FFT: TFFTReal;                        {obiekt FFT}
  FFT_Out: array[0..RecBuffSize div 2] of Double;
  Osc_Out: array[0..RecBuffSize div 2] of Double;
implementation



{$R *.DFM}

procedure TForm1.StartButtonClick(Sender: TObject);
begin
   If (Not AudioIn1.Start(AudioIn1)) Then ShowMessage(AudioIn1.ErrorMessage)
   Else
     Begin
        Min := 0;
        Max := 0;
        RecordSpeedButton.Down := TRUE;
     End;
end;

function TForm1.AudioIn1BufferFilled(Buffer: PAnsiChar; var Size: Integer): Boolean;
Var
  SP    : ^SmallInt;
  i, N,  v  : Integer;
  xMin, xMax : Integer;
  var a : Integer;
  VolDiv, c: Double;

  var DataP: Pointer; {wskaŸnik do tablicy zawieraj¹cej sygna³}
      TmpSI: SmallInt; {zmienna do przepisywania sygna³u na tablicê}
      LC: Word;
      dd: Ansichar;
begin
  N := Size Div 2;
  SP := Pointer(Buffer);
  xMin := SP^;
  xMax := xMin;



  For i := 0 to N-1 Do
     Begin
       v := SP^;
       Audio_pflt[i] := SP^;
       Inc(SP);
       If (xMin > v) Then xMin := v;
       If (xMax < v) Then xMax := v;
     End;

  If (Min > xMin) Then Min := xMin;
  If (Max < xMax) Then Max := xMax;

  TempMax := xMax;
  If (Abs(xMin) > xMax) Then TempMax := Abs(xMin);

  //for n := 0 to 2048 do
  //Audio_pflt[n] := AudioBuffer[n];


    FFT.do_fft(FFTOutput,Audio_pflt);  //obliczenie FFT
    for LC:=0 to (RecBuffSize div 2)-1 do //obliczenie ABS(FFT)
      FFT_L[LC]:=Sqrt( Sqr(FFTOutput^[ LC ]) + Sqr(FFTOutput^[ LC+(RecBuffSize div 2) ]) );


        VolDiv := 25+400*power(2-log10(100-TbVol.Position/10),3);
 //   VolR := 0; VolR := 0;
    //Audio_R, Audio_L - tablice zmiennych z probkami dla oscylatora (512 probek)
    for a := 0 to RecBuffSize div 2 do begin
      Osc_Out[a] := Audio_pflt[a] / VolDiv;

    end;



    VolDiv := 3000+110000*power(2-log10(100-TbVol.Position/10),3);  // ustalenie dzielnika glosnosci
    for a:=0 to RecBuffSize div 2 do
    begin // a (BUFOR_SIZE div 2)-1
     c := FFT_L[a] - 10;
      c := 3*(c/VolDiv)*(1+(a/10)); // liniowy
      if c < 0 then c := 0;
      FFT_Out[a] := c;
    end;



  Result := TRUE;
end;

Procedure TForm1.UpdateStatus;
begin
  With AudioIn1 Do
   If (AudioIn1.Active) Then
     Begin
       RunStatusLabel.Caption := 'Started';
       BufferStatusLabel.Caption := Format('Queued: %3d;  Processed: %3d',[QueuedBuffers, ProcessedBuffers]);
       TimeStatusLabel.Caption := Format('Seconds %.3n',[ElapsedTime]);
     End
   Else
     Begin
       RunStatusLabel.Caption := 'Stopped';
       BufferStatusLabel.Caption := '';
       TimeStatusLabel.Caption := '';
     End;

   { Update the progress bar }
   If (AudioIn1.Active) Then
     Begin
       ProgressBar1.Position := Round(100*TempMax/36768.0);
       If (Abs(Min) > Max) Then Max := Abs(Min);
       MaxLabel.Caption := Format('Max %5d;  Peak %5d',[Max,TempMax]);
     End
   Else
     Begin
       ProgressBar1.Position := 0;
       MaxLabel.Caption := '';
     End;

End;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  UpdateStatus;
end;

procedure TForm1.AudioIn1Stop(Sender: TObject);
begin
   RecordSpeedButton.Down := FALSE;
end;


procedure TForm1.StopButtonClick(Sender: TObject);
begin
  AudioIn1.StopAtOnce;
end;

procedure TForm1.RecordSpeedButtonClick(Sender: TObject);
begin
  If (RecordSpeedButton.Down) Then
     StartButtonClick(Sender)
  Else
     AudioIn1.StopAtOnce;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caNone;
AudioIn1.StopAtOnce;
Application.ProcessMessages;
//Sleep(300);
Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GetMem(Audio_pflt,RecBuffSize*sizeof_flt);
  //GetMem(Audio_R,RecBuffSize*sizeof_flt);
  GetMem(FFT_L,RecBuffSize*sizeof_flt);
  GetMem(FFT_R,RecBuffSize*sizeof_flt);
  GetMem(FFTOutput,RecBuffSize*sizeof_flt);
  FFT:=TFFTReal.Create(RecBuffSize);
end;

Procedure CzyscTablice(PTablica: pflt_array; PTablicaLen: Cardinal);
  var LC: Cardinal;
begin
  for LC:=0 to PTablicaLen-1 do PTablica^[LC]:=0;
end;
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
Timer2.Enabled := False;
  FFT.Free;
//  Dispose(Audio_L);
 // Dispose(Audio_R);
  Dispose(FFT_L);
  Dispose(FFT_R);
  Dispose(FFTOutput);
end;

procedure TForm1.Button1Click(Sender: TObject);
  Var s: String;
  n: Integer;
begin
//for n := 1 to 30 do
//  s := s + Inttostr(Tablica[n]) + #13;
 //Showmessage(s);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
  var y, tn: Integer;
  sd:   array of TPoint;
begin

Image2.Canvas.Brush.Color := clGreen;
Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);

Image1.Canvas.Pen.Color:=clLime;
      setLength(sd,Image1.Width + 2);

      // pierwszy punkt tablicy (lewy dolny rog)
      sd[0].X := 0;
      sd[0].Y := Image1.Height-1;
      // ostatni punkt tablicy (prawy dolny rog)
      sd[Image1.Width + 1].X := Image1.Width-1;
      sd[Image1.Width + 1].Y := Image1.Height-1;

      for tn := 0 to Image1.Width - 1 do
      begin
        sd[tn+1].X := tn;
        // 928 - wartosc dla 20kHz
        // 1023 - wartosc dla 22,05kHz
        sd[tn+1].Y := Image1.Height -
          Round((Image1.Height/30000)* FFT_Out[Round((tn/Image1.Width)*2048 )]);
        if sd[tn+1].Y < 0 then sd[tn+1].Y := 0;
      end;
      Image1.Canvas.Pen.Color := clLime;
      Image1.Canvas.Brush.Color := clGreen;
     // Brush.Style := bsDiagCross;
     // Brush.Bitmap := ImgDisplayTloAlfa;
      Image1.Canvas.Polygon(sd);




       Image2.Canvas.Pen.Color:=clYellow;
      y :=  Round(Osc_Out[0]);
      Image2.Canvas.MoveTo(0, Image2.Height div 2 + y); // rozpocznij od punktu Y
      for tn := 0 to Image2.Width do
      begin
        y := Round(Osc_Out[Round((tn/(Image2.Width))*(RecBuffSize div 2))] * (Image2.Height div 150));
        y := Round(y / 10);

        y := Image2.Height div 2 + y; // przesun do polowy
        if y < 0 then y := 0;
        if y > Image2.Height -1 then y := Image2.Height - 1;
        Image2.Canvas.LineTo(tn, y );
      end;

end;

end.
