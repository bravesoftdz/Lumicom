unit UnitMixerAudio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AMixer, Buttons, ExtCtrls;

type
  TFormMixer = class(TForm)
    GroupBox1: TGroupBox;
    CbScard: TComboBox;
    GroupBox2: TGroupBox;
    CbSource: TComboBox;
    GroupBox3: TGroupBox;
    TbVol: TTrackBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure CbScardChange(Sender: TObject);
    procedure CbSourceChange(Sender: TObject);
    procedure TbVolChange(Sender: TObject);
    procedure MixerControlChange(Sender: TObject; MixerH, ID: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMixer: TFormMixer;
  Mixer: TAudioMixer;
  VolChangingDelay: Byte;
  DefsCard: String;
  DefsSource: String;
  DefsVolume: Integer = -1;
  

implementation

uses UnitMainForm, UnitSineGenerator;

{$R *.dfm}

procedure TFormMixer.FormCreate(Sender: TObject);
begin
  Mixer := TAudioMixer.Create(Self);
  Mixer.OnControlChange := MixerControlChange;
  Mixer.OnLineChange := MixerControlChange;
  if Mixer.MixerCount = 0 then // Jesli nie znaleziono kart muzycznych
  begin
    GroupBox1.Enabled := False;
    GroupBox2.Enabled := False;
    GroupBox3.Enabled := False;
  end else
  begin
    GroupBox1.Enabled := True;
    GroupBox2.Enabled := True;
    GroupBox3.Enabled := True;
  end; //Mixer.MixerCount > 0

end;

procedure TFormMixer.CbScardChange(Sender: TObject);
  var n: Integer;
      mute: Boolean;
begin
  if VolChanging = False then
  begin
    VolChanging := True;
    unitMainForm.AudioIn.StopAtOnce;

    Mixer.MixerId := CbScard.ItemIndex;

    CbSource.Items.Clear;
    for n := 0 to Mixer.Destinations[1].Connections.Count-1 do
    begin
      CbSource.Items.Add(Mixer.Destinations[1].Connections[n].Data.szName);
      Mixer.GetMute(1, n, mute);
      if mute = True then CbSource.ItemIndex := n; //ustaw domyslne wejscie
    end;
    if CbSource.ItemIndex =-1 then CbSource.ItemIndex := 0;
    Application.ProcessMessages;
    CbSourceChange(Sender);

    unitMainForm.AudioIn.WaveDevice := CbScard.ItemIndex;
    unitMainForm.AudioIn.Start(unitMainForm.AudioIn);


    VolChanging := False;
  end;
end;

procedure TFormMixer.CbSourceChange(Sender: TObject);
var L,R,M:Integer;
    VD,MD:Boolean;
    Stereo:Boolean;
    IsSelect:Boolean;
begin
  Mixer.GetVolume (1,CbSource.ItemIndex, L, R, M, Stereo, VD, MD, IsSelect);
  //if VolChanging = False then
  begin
    //VolChanging := True;
    TbVol.Position := L;
   // Application.ProcessMessages;
    //VolChanging := False;
  end;
end;

procedure TFormMixer.TbVolChange(Sender: TObject);
begin
  if VolChanging = False then
  begin
    VolChanging := True;
    Application.ProcessMessages;
    Mixer.SetVolume(1,CbSource.ItemIndex, TbVol.Position, TbVol.Position, 1);
    VolChanging := False;
  end;
end;

procedure TFormMixer.MixerControlChange(Sender: TObject; MixerH,  ID: Integer);

begin
  if VolChanging = False then
  begin
    VolChanging := True;

     CbScardChange(Self);

    VolChanging := False;
  end;
end;

procedure TFormMixer.SpeedButton1Click(Sender: TObject);
begin
  WinExec('rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,2',SW_SHOWNORMAL);
end;

procedure TFormMixer.SpeedButton2Click(Sender: TObject);
begin
  FormSineGenerator.Show;
end;

end.
