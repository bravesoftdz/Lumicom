unit UnitSineGenerator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AudioIO, StdCtrls, ComCtrls, Buttons;

type
  TFormSineGenerator = class(TForm)
    TbFreq: TTrackBar;
    BtSound: TButton;
    TbVol: TTrackBar;
    procedure BtSoundClick(Sender: TObject);
    function AudioOut1FillBuffer(Buffer: PAnsiChar;
      var Size: Integer): Boolean;
    procedure TbFreqChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSineGenerator: TFormSineGenerator;
    TotalBuffers : Integer;
    Freq         : Integer;
implementation

uses UnitMainForm;

{$R *.dfm}

procedure TFormSineGenerator.BtSoundClick(Sender: TObject);
begin
  if BtSound.Caption = 'Start' then
  begin
    AudioOut.Start(AudioOut);
    BtSound.Caption := 'Stop';
  end else
  begin
    AudioOut.StopGraceFully;
    BtSound.Caption := 'Start';
  end;
end;

function TFormSineGenerator.AudioOut1FillBuffer(Buffer: PAnsiChar;
  var Size: Integer): Boolean;
{
  Whenever the component needs another buffer, this routine is called,
  N is the number of BYTES required, B the the address of the buffer.
}
Var
  NW, i, ts : Integer;
  P : ^SmallInt;

begin
  { See if we want to quit.  Process TotalBuffers except if TotalBuffer
    is <= 0, then process forever. }
   If (AudioOut.QueuedBuffers >=  TotalBuffers) and (TotalBuffers > 0) Then
     Begin
       { Stop processing by just returning FALSE }
       Result := FALSE;
       Exit;
     End;;

   { First step, cast the buffer as the proper data size, if this output
     was 8 bits, then the cast would be to ^Byte.  N now represents the
     total number of 16 bit words to process. }
   P := Pointer(Buffer);
   NW := Size div 2;

   { Now create a sine wave, because the buffer may not align with the end
     of a full sine cycle, we must compute it using the total number of
     points processed.  FilledBuffers give the total number of buffer WE
     have filled, so we know the number of point WE processed }

   ts := NW*AudioOut.FilledBuffers;
   { Note: Freq is set from the TrackBar }
   For i := 0 to NW-1 Do
     Begin
      P^ := Round((FormSineGenerator.TbVol.Position/100)*(8192*Sin((ts+i)/AudioOut.FrameRate*
        3.14159*2*Freq)));
      Inc(P);
     End;

   { True will continue Processing }
   Result := True;

end;

procedure TFormSineGenerator.TbFreqChange(Sender: TObject);
  var cp: String;
begin
  cp := 'Generator tonów, f = ';
   Freq := 20 + (TbFreq.Position * TbFreq.Position);
   if Freq < 1000 then Self.Caption := cp + IntToStr(Freq) + ' Hz';
   if Freq > 1000 then Self.Caption := cp + CurrToStr(Freq/1000) + ' kHz';
end;

procedure TFormSineGenerator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    AudioOut.StopGraceFully;
    BtSound.Caption := 'Start';
end;

procedure TFormSineGenerator.FormCreate(Sender: TObject);
begin

  TbFreqChange(Sender);
  Self.ClientHeight := 80;
  Application.ProcessMessages;
  Self.Constraints.MaxHeight := Self.Height;
  Self.Constraints.MinHeight := Self.Height;
  Self.Constraints.MinWidth := 320;
end;

procedure TFormSineGenerator.FormResize(Sender: TObject);
begin
  TbFreq.Width := Self.ClientWidth - TbFreq.Left - 8;
  TbVol.Width := Self.ClientWidth - TbVol.Left - 8;

end;

end.
