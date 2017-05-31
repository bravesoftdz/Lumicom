unit UnitStats;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gauges, ExtCtrls, Math, AudioIO;

type
  TFormStats = class(TForm)
    Label1: TLabel;
    TimerRefresh: TTimer;
    LbZeroTime: TLabel;
    Label2: TLabel;
    LbTimeProgress: TLabel;
    Label3: TLabel;
    LbVolInMax: TLabel;
    GaAudioInMaxLv: TGauge;
    Label4: TLabel;
    GaAudioLvMax: TGauge;
    LbMax: TLabel;
    GaFftMax: TGauge;
    Label5: TLabel;
    LbFftMax: TLabel;
    Label7: TLabel;
    GaFftSr: TGauge;
    Label8: TLabel;
    GaFftSrMax: TGauge;
    LbFftSrMax: TLabel;
    LbFftSr: TLabel;
    Label6: TLabel;
    LbAmplify: TLabel;
    BtAbout: TButton;
    Gauge1: TGauge;
    Label9: TLabel;
    Gauge2: TGauge;
    Label10: TLabel;
    procedure TimerRefreshTimer(Sender: TObject);
    procedure BtAboutClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStats: TFormStats;

implementation

uses UnitMainForm, UnitAbout;

{$R *.dfm}

procedure TFormStats.TimerRefreshTimer(Sender: TObject);
begin
  if FormStats.Visible = True then
  begin
    LbTimeProgress.Caption := TimeToStr(GetTime - StartTime);

    GaAudioLvMax.Progress :=  Round(OscMaxLv);
    LbMax.Caption := CurrToStr(OscMaxLv);

    GaAudioInMaxLv.Progress := ABS(AudioInMaxLv);
    if AudioInMaxLv > 32000 then GaAudioInMaxLv.ForeColor := clRed else
      GaAudioInMaxLv.ForeColor := clLime;

     // Poziom sygna³u wejœciowego
    LbVolInMax.Caption := IntToStr(AudioInMaxLv);

    GaFftMax.Progress := FftMaxLv;
    LbFftMax.Caption := IntToStr(FftMaxLv);



    GaFftSr.Progress := Round(FftSr);
    LbFftSr.Caption := IntToStr(Round(FftSr));

    GaFftSrMax.Progress := Round(FftSrMax);
    LbFftSrMax.Caption := IntToStr(Round(FftSrMax));


    LbAmplify.Caption := IntToStr(Round((aAmplify-1)*100)) + '%';

    Label9.Caption := 'Czas przerwy: ' + Inttostr(CzasPrzerwy);
    Gauge1.Progress := CzasPrzerwy;

  end;
end;



procedure TFormStats.BtAboutClick(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

end.
