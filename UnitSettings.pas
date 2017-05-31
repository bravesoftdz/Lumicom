unit UnitSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Spin;

type
  TFormSettings = class(TForm)
    CbAlphaBlend: TCheckBox;
    CbAutoVol: TCheckBox;
    CbStayOnTop: TCheckBox;
    TbDarkLevel: TTrackBar;
    Label1: TLabel;
    TbAlphaBlendLevel: TTrackBar;
    CbScardRmb: TCheckBox;
    CbShowDot: TCheckBox;
    TimerWinamp: TTimer;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure CbStayOnTopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FormSettings: TFormSettings;

implementation

uses UnitMainForm, UnitWinamp;

{$R *.dfm}

procedure TFormSettings.CbStayOnTopClick(Sender: TObject);
begin
  TbAlphaBlendLevel.Enabled := CbAlphaBlend.Checked;

  if CbStayOnTop.Checked then With MainForm do
    {SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0) else
    With MainForm do
    SetWindowPos(Handle, HWND_TOP, Left, Top, Width, Height, 0); }
  UnitMainForm.AutoVol := CbAutoVol.Checked;
  MainForm.AlphaBlend := CbAlphaBlend.Checked;
  MainForm.AlphaBlendValue := TbAlphaBlendLevel.Position;

  if UnitMainForm.DarkLevel <> TbDarkLevel.Position then
  begin
    UnitMainForm.DarkLevel := TbDarkLevel.Position;
    MainForm.DarkColorLevel;
  end;

  UnitMainForm.ShowSpectDot := CbShowDot.Checked;
end;

procedure TFormSettings.FormShow(Sender: TObject);
begin
   if MainForm.FormStyle = fsStayOnTop then CbStayOnTop.Checked := True else
    CbStayOnTop.Checked := False;
  CbAutoVol.Checked := UnitMainForm.AutoVol;
  CbAlphaBlend.Checked := MainForm.AlphaBlend;
  TbAlphaBlendLevel.Position := MainForm.AlphaBlendValue;
  TbDarkLevel.Position := UnitMainForm.DarkLevel;
  CbShowDot.Checked := UnitMainForm.ShowSpectDot;


end;


procedure TFormSettings.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked then VisDelay := False else VisDelay := True;
end;

end.
