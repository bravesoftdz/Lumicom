unit UnitAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Credits;

type
  TFormAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    ScrollingCredits1: TScrollingCredits;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

uses UnitMainForm, UnitChannel, UnitAudioSettings, UnitSettings, UnitStats,
  UnitMixerAudio, UnitSineGenerator, UnitInfo, UnitProfiles, UnitWinamp;

{$R *.dfm}

procedure TFormAbout.FormCreate(Sender: TObject);
  var n: Integer;
begin
   MainForm.Left := Screen.Width div 2 - MainForm.Width div 2;
  MainForm.Top := Screen.Height div 2 - MainForm.Height div 2;
  FormChannel.Left := Screen.Width div 2 - FormChannel.Width div 2;
  FormChannel.Top := Screen.Height div 2 - FormChannel.Height div 2;
  FormAudioSettings.Left := Screen.Width div 2 - FormAudioSettings.Width div 2;
  FormAudioSettings.Top := Screen.Height div 2 - FormAudioSettings.Height div 2;
  FormSettings.Left := Screen.Width div 2 - FormSettings.Width div 2;
  FormSettings.Top := Screen.Height div 2 - FormSettings.Height div 2;
  FormStats.Left := Screen.Width div 2 - FormStats.Width div 2;
  FormStats.Top := Screen.Height div 2 - FormStats.Height div 2;
  FormMixer.Left := Screen.Width div 2 - FormMixer.Width div 2;
  FormMixer.Top := Screen.Height div 2 - FormMixer.Height div 2;
  FormSineGenerator.Left := Screen.Width div 2 - FormSineGenerator.Width div 2;
  FormSineGenerator.Top := Screen.Height div 2 - FormSineGenerator.Height div 2;
  FormAbout.Left := Screen.Width div 2 - FormAbout.Width div 2;
  FormAbout.Top := Screen.Height div 2 - FormAbout.Height div 2;


  MainForm.WczytajUstawienia;
  MainForm.Przeladuj;
  MainForm.DarkColorLevel;
  FormProfiles.FindProfiles;
  MainForm.LoadWinampAssociations;

  GenTimerThread := TGenTimerThread.Create(False); //rozpocznij dzialanie generatora
  GenTimerThread.Priority := tpHigher;


  if UnitMixerAudio.Mixer.MixerCount > 0 then
  begin
    for n := 0 to UnitMixerAudio.Mixer.MixerCount-1 do //utworz liste kart
    begin
      UnitMixerAudio.Mixer.MixerId := n;
      FormMixer.CbScard.Items.Add(UnitMixerAudio.Mixer.MixerCaps.szPname);
      if UnitMixerAudio.DefsCard = UnitMixerAudio.Mixer.MixerCaps.szPname then
        FormMixer.CbScard.ItemIndex := n;
    end;
    if FormMixer.CbScard.ItemIndex = -1 then FormMixer.CbScard.ItemIndex := 0;
    FormMixer.CbScardChange(Self);
    Application.ProcessMessages;
    for n := 0 to FormMixer.CbSource.Items.Count-1 do
      if FormMixer.CbSource.Items.Strings[n] = UnitMixerAudio.DefsSource then
        FormMixer.CbSource.ItemIndex := n;
      Application.ProcessMessages;
    if UnitMixerAudio.DefsVolume <> -1 then FormMixer.TbVol.Position := DefsVolume;
  end;
end;

end.
