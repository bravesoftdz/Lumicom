program Lumicom;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm},
  FFTReal in 'Forms\fftreal.pas',
  AMixer in 'Forms\AMixer.pas',
  UAFDefs in 'Forms\UAFDefs.pas',
  AudioIO in 'Forms\AudioIO.pas',
  UnitSettings in 'UnitSettings.pas' {FormSettings},
  UnitStats in 'UnitStats.pas' {FormStats},
  UnitMixerAudio in 'UnitMixerAudio.pas' {FormMixer},
  UnitSineGenerator in 'UnitSineGenerator.pas' {FormSineGenerator},
  UnitAudioSettings in 'UnitAudioSettings.pas' {FormAudioSettings},
  UnitChannel in 'UnitChannel.pas' {FormChannel},
  UnitWinamp in 'UnitWinamp.pas' {FormWinamp},
  UnitProfiles in 'UnitProfiles.pas' {FormProfiles},
  UnitOscyloskop in 'UnitOscyloskop.pas' {FormOscyloskoop},
  UnitAbout in 'UnitAbout.pas' {FormAbout},
  UnitWinampAssociations in 'UnitWinampAssociations.pas' {FormWinampAssociations};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormAudioSettings, FormAudioSettings);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.CreateForm(TFormStats, FormStats);
  Application.CreateForm(TFormMixer, FormMixer);
  Application.CreateForm(TFormSineGenerator, FormSineGenerator);
  Application.CreateForm(TFormChannel, FormChannel);
  Application.CreateForm(TFormWinamp, FormWinamp);
  Application.CreateForm(TFormProfiles, FormProfiles);
  Application.CreateForm(TFormOscyloskoop, FormOscyloskoop);
  Application.CreateForm(TFormWinampAssociations, FormWinampAssociations);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;
end.
