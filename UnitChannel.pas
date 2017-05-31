unit UnitChannel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Spin, Gauges, Math,
  Credits;

type
  TFormChannel = class(TForm)
    GbGen: TGroupBox;
    Label2: TLabel;
    LbGenfreq: TLabel;
    Label7: TLabel;
    SeGenMin: TSpinEdit;
    SeGenMax: TSpinEdit;
    GbRandom: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    LbRandomCount: TLabel;
    SeRandomMax: TSpinEdit;
    SeRandomMin: TSpinEdit;
    GbMain: TGroupBox;
    LbMode1: TLabel;
    LbMode2: TLabel;
    LbMode3: TLabel;
    LbMode4: TLabel;
    TbMode: TTrackBar;
    CbRanOff: TCheckBox;
    CbRanOn: TCheckBox;
    CbRanGen: TCheckBox;
    CbRanAudio: TCheckBox;
    GbAudio: TGroupBox;
    Gauge2: TGauge;
    Bevel5: TBevel;
    PnGen: TPanel;
    BtGenMin: TButton;
    BtGenMax: TButton;
    PnRandom: TPanel;
    BtRandomMin: TButton;
    BtRandomMax: TButton;
    Image1: TImage;
    ColorDialog1: TColorDialog;
    CbGenShapeUp: TComboBox;
    BtAudio: TSpeedButton;
    BtGen: TSpeedButton;
    BtRan: TSpeedButton;
    LbMode0: TLabel;
    LbMode5: TLabel;
    Bevel9: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel6: TBevel;
    Label8: TLabel;
    TbGenDuty: TTrackBar;
    TbGenShape: TTrackBar;
    Label19: TLabel;
    Bevel15: TBevel;
    LbGenDuty: TLabel;
    LbGenShape: TLabel;
    StatusBar: TStatusBar;
    CbGenShapeDown: TComboBox;
    Label26: TLabel;
    Label27: TLabel;
    Bevel16: TBevel;
    Label30: TLabel;
    Label31: TLabel;
    LbGenFreqChange: TLabel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Label29: TLabel;
    CbGenStyle: TComboBox;
    Label34: TLabel;
    TbOutPower: TTrackBar;
    Bevel3: TBevel;
    Bevel20: TBevel;
    Bevel21: TBevel;
    EdCaption: TEdit;
    Label36: TLabel;
    CbOutCh: TComboBox;
    Label37: TLabel;
    PnColor: TPanel;
    CbMajorPWM: TCheckBox;
    ComboBox1: TComboBox;
    CbNegative: TCheckBox;
    CbStrob: TCheckBox;
    CbGenNegative: TCheckBox;
    Bevel11: TBevel;
    SpeedButton1: TSpeedButton;
    GaLevel: TGauge;
    TbGenFreqChStep: TTrackBar;
    LbGenFreqChStep: TLabel;
    PnGenFreqPos: TPanel;
    ImgChart: TPaintBox;
    Bevel8: TBevel;
    CbAnalyze: TComboBox;
    Label14: TLabel;
    Label15: TLabel;
    CbRefP: TComboBox;
    Label9: TLabel;
    CbAudioShape: TComboBox;
    CbPulseMode: TCheckBox;
    SeAudioPulseTime: TSpinEdit;
    Label17: TLabel;
    Label16: TLabel;
    SeAudioPulseBreak: TSpinEdit;
    Label4: TLabel;
    Label3: TLabel;
    CbAudioDiffMode: TCheckBox;
    CbAudioPWM: TCheckBox;
    Label1: TLabel;
    PnAudioFreq: TPanel;
    BtAudioFreqMin: TButton;
    BtAudioFreqMax: TButton;
    SeAudioFreqMax: TSpinEdit;
    Label24: TLabel;
    SeAudioFreqMin: TSpinEdit;
    Label25: TLabel;
    Label18: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    SeAudioSchmitMin: TSpinEdit;
    Label20: TLabel;
    SeAudioSchmitMax: TSpinEdit;
    Label28: TLabel;
    Label6: TLabel;
    TbAmplify: TTrackBar;
    LbAmplVal: TLabel;
    Bevel2: TBevel;
    TbAudioDelay: TTrackBar;
    Label21: TLabel;
    LbAudioDelayVal: TLabel;
    Bevel4: TBevel;
    Bevel10: TBevel;
    Bevel12: TBevel;
  procedure Odswiez;
    procedure BtAudioFreqMinMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtAudioFreqMinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtAudioFreqMinMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OdswiezCb;
    procedure SeAudioFreqMinChange(Sender: TObject);
    procedure PnColorClick(Sender: TObject);
    procedure TbModeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TbOutPowerChange(Sender: TObject);
    procedure EdCaptionChange(Sender: TObject);
    procedure BtGenClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Generator(n: Byte);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

  TGenTimerThread = class(TThread)
  protected
    procedure Execute; override;
    procedure ChangeLbCaption;
  end;

var
  FormChannel: TFormChannel;
   ChNr:   Byte; //numer aktualnie edytowanego kanalu
  GenTimerThread: TGenTimerThread;
  BtActive: TObject;
  ClickPos: TPoint;
//  AudioIN : TAudioI;
//  AudioIO : TAudioIO;

  Odswiezanie:   Boolean;
  ModeLabel: array[0..5] of TLabel;


  GenSiP:           array[1..24] of Double;
  FreqChangeIndex:  array[1..24] of Integer;
  FreqChangeUp:     array[1..24] of Boolean; //kierunek zmian czestotliwosci
  NewFreq:          array[1..24] of Currency;
  GenBmp:           TBitmap;
  ThLabel:          TLabel;   //procedury wykorzystywane podczas odwolywania sie
  ThCaption:        TCaption; //do obiektow VCL z watkow
implementation

uses UnitMainForm, AudioIO;

{$R *.dfm}

{ TFormChannel }

procedure TFormChannel.Odswiez;
begin
  Odswiezanie := True;

  EdCaption.Text := Kanal[ChNr].Caption;

  TbMode.Position := Kanal[ChNr].Mode;
  TbOutPower.Position := 255 - Kanal[ChNr].OutPower;
  PnColor.Color := Kanal[ChNr].ColorLight;
  EdCaption.Text := Kanal[ChNr].Caption;
  CbOutCh.ItemIndex := Kanal[ChNr].OutChannel - 1;
  CbMajorPWM.Checked := Kanal[ChNr].MajorPWM;
  CbNegative.Checked := Kanal[ChNr].Negative;
  CbStrob.Checked := Kanal[ChNr].StrobMode;

  CbAnalyze.ItemIndex := Kanal[ChNr].Audio.Analyze;
  CbRefP.ItemIndex := Kanal[ChNr].Audio.RefPoint;
  SeAudioFreqMin.Value := Kanal[ChNr].Audio.FreqMin;
  SeAudioFreqMax.Value := Kanal[ChNr].Audio.FreqMax;
  TbAmplify.Position := Kanal[ChNr].Audio.Amplify;
  TbAudioDelay.Position := Kanal[ChNr].Audio.Delay;
  CbPulseMode.Checked := Kanal[ChNr].Audio.Pulse;
  SeAudioPulseTime.Value :=  Kanal[ChNr].Audio.PulseTime;
  SeAudioPulseBreak.Value := Kanal[ChNr].Audio.PulseBreak;
  SeAudioSchmitMin.Value := Kanal[ChNr].Audio.SchmitMin;
  SeAudioSchmitMax.Value := Kanal[ChNr].Audio.SchmitMax;
  CbAudioPWM.Checked := Kanal[ChNr].Audio.PWM;
  CbAudioDiffMode.Checked := Kanal[ChNr].Audio.DiffMode;

  SeRandomMin.Value := Kanal[ChNr].xRandom.FreqMin;
  SeRandomMax.Value := Kanal[ChNr].xRandom.FreqMax;
  CbRanAudio.Checked := Kanal[ChNr].xRandom.mAudio;
  CbRanGen.Checked := Kanal[ChNr].xRandom.mGen;
  CbRanOn.Checked := Kanal[ChNr].xRandom.mOn;
  CbRanOff.Checked := Kanal[ChNr].xRandom.mOff;

  SeGenMin.Value := Kanal[ChNr].Gen.FreqMin;
  SeGenMax.Value := Kanal[ChNr].Gen.FreqMax;
  CbGenStyle.ItemIndex := Kanal[ChNr].Gen.Style;
  CbGenShapeUp.ItemIndex := Kanal[ChNr].Gen.ShapeUp;
  CbGenShapeDown.ItemIndex := Kanal[ChNr].Gen.ShapeDown;
 // SeGenFreqChMin.Value := Kanal[ChNr].Gen.FreqChngMin;
 // SeGenFreqChMax.Value := Kanal[ChNr].Gen.FreqChngMax;
  TbGenDuty.Position := Kanal[ChNr].Gen.Duty;
  TbGenShape.Position := Kanal[ChNr].Gen.Shape;
  TbGenFreqChStep.Position := Kanal[ChNr].Gen.FreqChangeStep;
  LbGenFreqChStep.Caption := IntToStr(Kanal[ChNr].Gen.FreqChangeStep);
  CbGenNegative.Checked := Kanal[ChNr].Gen.Negative;


 // SeAudioFreqMin.MaxValue := 200000;
  SeAudioFreqMinChange(SeAudioFreqMin);
//  SeAudioFreqMax.MinValue := 20;
  SeAudioFreqMinChange(SeAudioFreqMax);
//  SeRandomMin.MaxValue := 600;
  SeAudioFreqMinChange(SeRandomMin);
// SeRandomMax.MinValue := 1;
  SeAudioFreqMinChange(SeRandomMax);
//  SeGenMin.MaxValue := 10000;
  SeAudioFreqMinChange(SeGenMin);
//  SeGenMax.MinValue := 1;
  SeAudioFreqMinChange(SeGenMax);

  Application.ProcessMessages;
  OdswiezCb;
  TbModeChange(Self);
  Odswiezanie := False;

  TbOutPowerChange(Self);
end;



procedure TFormChannel.BtAudioFreqMinMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BtActive := Sender;
  ClickPos :=Point(X, Y);
end;

procedure TFormChannel.BtAudioFreqMinMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
    var l: Integer;
        bt: Tbutton;
        PnParr: TPanel; //parrent
        c: Currency;
begin
  bt := TButton(Sender);
  l := 0;
  PnParr := nil;
  if bt <> nil then l := bt.Left+(X-ClickPos.X);
  if bt <> nil then if l < 0 then l := 0;
  if bt <> nil then PnParr :=TPanel(bt.Parent);

  if BtActive = BtAudioFreqMin then
  begin
    if l + bt.Width > BtAudioFreqMax.Left then l := BtAudioFreqMax.Left - bt.Width;
    c := power(bt.Left,2) / power(PnParr.Width - bt.Width - BtAudioFreqMax.Width, 2);
    SeAudioFreqMin.Value := 20 + Round(c*19980);
  end;

  if BtActive = BtAudioFreqMax then
  begin
    if l > PnParr.Width - bt.Width then l := PnParr.Width - bt.Width;
    if l < BtAudioFreqMin.Left + BtAudioFreqMin.Width then
      l := BtAudioFreqMin.Left + BtAudioFreqMin.Width;

      c := power(bt.Left - BtAudioFreqMin.Width,2) /
      power(PnParr.Width - bt.Width - BtAudioFreqMin.Width, 2);
    SeAudioFreqMax.Value := 20 + Round(c*19980);
  end;


  if BtActive = BtRandomMin then
  begin
    if l + bt.Width > BtRandomMax.Left then l := BtRandomMax.Left - bt.Width;
    c := power(bt.Left,2) / power(PnParr.Width - bt.Width - BtRandomMax.Width, 2);
    SeRandomMin.Value := Round(c*600);
  end;

  if BtActive =BtRandomMax then
  begin
    if l > PnParr.Width - bt.Width then l := PnParr.Width - bt.Width;
    if l < BtRandomMin.Left + BtRandomMin.Width then
      l := BtRandomMin.Left + BtRandomMin.Width;

      c := power(bt.Left - BtRandomMin.Width,2) /
      power(PnParr.Width - bt.Width - BtRandomMin.Width, 2);
    SeRandomMax.Value := Round(c*600);
  end;



  if BtActive =BtGenMin then
  begin
    if l + bt.Width > BtGenMax.Left then l := BtGenMax.Left - bt.Width;
    c := power(bt.Left,2) / power(PnParr.Width - bt.Width - BtGenMax.Width, 2);
    SeGenMin.Value := Round(c*10000);
  end;

  if BtActive =BtGenMax then
  begin
    if l > PnParr.Width - bt.Width then l := PnParr.Width - bt.Width;
    if l < BtGenMin.Left + BtGenMin.Width then
      l := BtGenMin.Left + BtGenMin.Width;

      c := power(bt.Left - BtGenMin.Width,2) /
      power(PnParr.Width - bt.Width - BtGenMin.Width, 2);
    SeGenMax.Value := Round(c*10000);
  end;

  if BtActive <> nil then
  TButton(Sender).Left := l;
end;

procedure TFormChannel.BtAudioFreqMinMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BtActive := nil;
end;

procedure TFormChannel.SeAudioFreqMinChange(Sender: TObject);
  var c: Double;

begin
  //if Odswiezanie = False then
  if (TSpinEdit(Sender).Value >= TSpinEdit(Sender).MinValue) and
    (TSpinEdit(Sender).Value <= TSpinEdit(Sender).MaxValue) then
  begin

  if Sender = SeAudioFreqMin then
  begin
    if Odswiezanie = False then
      if SeAudioFreqMin.Value > SeAudioFreqMax.Value then
        SeAudioFreqMin.Value := SeAudioFreqMax.Value;
    c := sqrt(TSpinEdit(Sender).Value - 20) / sqrt(19980);
    BtAudioFreqMin.Left := Round(c * (PnAudioFreq.Width -
      BtAudioFreqMin.Width - BtAudioFreqMax.Width));
  end;

  if Sender = SeAudioFreqMax then
  begin
    if Odswiezanie = False then
      if SeAudioFreqMin.Value > SeAudioFreqMax.Value then
        SeAudioFreqMax.Value := SeAudioFreqMin.Value;
    c := sqrt(TSpinEdit(Sender).Value - 20) / sqrt(19980);
    BtAudioFreqMax.Left := BtAudioFreqMin.Width + Round(c *
      (PnAudioFreq.Width - BtAudioFreqMin.Width - BtAudioFreqMax.Width));
  end;


  if Sender = SeAudioSchmitMin then
  begin
    if Odswiezanie = False then
      if SeAudioSchmitMin.Value > SeAudioSchmitMax.Value then
        SeAudioSchmitMin.Value := SeAudioSchmitMax.Value;
  end;

  if Sender = SeAudioSchmitMax then
  begin
    if Odswiezanie = False then
      if SeAudioSchmitMin.Value > SeAudioSchmitMax.Value then
        SeAudioSchmitMax.Value := SeAudioSchmitMin.Value;
  end;


  if Sender = SeRandomMin then
  begin
    if Odswiezanie = False then
      if SeRandomMin.Value > SeRandomMax.Value then
        SeRandomMin.Value := SeRandomMax.Value;
    c := sqrt(TSpinEdit(Sender).Value - 1) / sqrt(599);
    BtRandomMin.Left := Round(c * (PnRandom.Width -
      BtRandomMin.Width - BtRandomMax.Width));
  end;

  if Sender = SeRandomMax then
  begin
   if SeRandomMin.Value > SeRandomMax.Value then
     SeRandomMax.Value := SeRandomMin.Value;
     c := sqrt(TSpinEdit(Sender).Value - 1) / sqrt(599);
     BtRandomMax.Left := BtRandomMin.Width + Round(c *
     (PnRandom.Width - BtRandomMin.Width - BtRandomMax.Width));
  end;


  if Sender = SeGenMin then
  begin
   if SeGenMin.Value > SeGenMax.Value then
     SeGenMin.Value := SeGenMax.Value;
     c := sqrt(TSpinEdit(Sender).Value - 1) / sqrt(9999);
     BtGenMin.Left := Round(c * (PnGen.Width -
       BtGenMin.Width - BtGenMax.Width));
  end;

  if Sender = SeGenMax then
  begin
    if Odswiezanie = False then
      if SeGenMin.Value > SeGenMax.Value then
        SeGenMax.Value := SeGenMin.Value;
    c := sqrt(TSpinEdit(Sender).Value - 1) / sqrt(9999);
    BtGenMax.Left := BtGenMin.Width + Round(c *
      (PnGen.Width - BtGenMin.Width - BtGenMax.Width));
  end;

  TSpinEdit(Sender).Color := clWhite;

 if Odswiezanie = False then
 begin
  if SeAudioFreqMin.Color <> clRed then
    Kanal[ChNr].Audio.FreqMin := SeAudioFreqMin.Value;
  if SeAudioFreqMax.Color <> clRed then
    Kanal[ChNr].Audio.FreqMax := SeAudioFreqMax.Value;

  if SeRandomMin.Color <> clRed then
    Kanal[ChNr].xRandom.FreqMin := SeRandomMin.Value;
  if SeRandomMax.Color <> clRed then
    Kanal[ChNr].xRandom.FreqMax := SeRandomMax.Value;


 // if SeGenFreqChMin.Color <> clRed then
 //   Kanal[ChNr].Gen.FreqChngMin := SeGenFreqChMin.Value;
 // if SeGenFreqChMax.Color <> clRed then
 //   Kanal[ChNr].Gen.FreqChngMax := SeGenFreqChMax.Value;


  if SeGenMin.Color <> clRed then Kanal[ChNr].Gen.FreqMin := SeGenMin.Value;

  if SeGenMax.Color <> clRed then Kanal[ChNr].Gen.FreqMax := SeGenMax.Value;

  if SeAudioSchmitMin.Color <> clRed then
    Kanal[ChNr].Audio.SchmitMin := SeAudioSchmitMin.Value;
  if SeAudioSchmitMax.Color <> clRed then
    Kanal[ChNr].Audio.SchmitMax := SeAudioSchmitMax.Value;

  if SeAudioPulseTime.Color <> clRed then
    Kanal[ChNr].Audio.PulseTime := SeAudioPulseTime.Value;
  if SeAudioPulseBreak.Color <> clRed then
    Kanal[ChNr].Audio.PulseBreak := SeAudioPulseBreak.Value;


    Kanal[ChNr].Audio.SmplMin := Round((Kanal[ChNr].Audio.FreqMin /
      (unitMainForm.AudioIn.FrameRate/2)) * (BuffSize) -1);
    Kanal[ChNr].Audio.SmplMax := Round((Kanal[ChNr].Audio.FreqMax /
      (unitMainForm.AudioIn.FrameRate/2)) * (BuffSize) -1);

    end;  //odswiezanie = false

  end else
    TSpinEdit(Sender).Color := clRed;


end;

procedure TFormChannel.PnColorClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    PnColor.Color := ColorDialog1.Color;
    Kanal[ChNr].ColorLight := ColorDialog1.Color;
    MainForm.DarkColorLevel;
  end;
end;

procedure TFormChannel.TbModeChange(Sender: TObject);
  var n: Integer;
begin
//  if not Odswiezanie then
  begin
    for n := 0 to 5 do
      ModeLabel[n].Font.Style := ModeLabel[n].Font.Style - [fsBold];
    ModeLabel[TbMode.Position].Font.Style := [fsBold];
    Kanal[ChNr].Mode := TbMode.Position;
  end;

  if Kanal[ChNr].Mode = 0 then BtRan.Down := True;
  if Kanal[ChNr].Mode = 1 then BtGen.Down := True;
  if Kanal[ChNr].Mode = 2 then BtAudio.Down := True;
  BtGenClick(Self);
end;

procedure TFormChannel.FormCreate(Sender: TObject);
  var n: Integer;
begin
  GenBmp := TBitmap.Create;
  GenBmp.Width := ImgChart.Width;
  GenBmp.Height := ImgChart.Height;

  ModeLabel[0] := LbMode0;
  ModeLabel[1] := LbMode1;
  ModeLabel[2] := LbMode2;
  ModeLabel[3] := LbMode3;
  ModeLabel[4] := LbMode4;
  ModeLabel[5] := LbMode5;

  for n := 1 to 24 do
    SetLength(Kanal[n].pArray, ImgChart.Width);
end;

procedure TFormChannel.TbOutPowerChange(Sender: TObject);
begin
  if Odswiezanie = False then
  begin
    OdswiezCb;
    Kanal[ChNr].OutPower := 255 - TbOutPower.Position;
    Kanal[ChNr].Audio.Amplify := TbAmplify.Position;
    Kanal[ChNr].Audio.Delay := TbAudioDelay.Position;
    Kanal[ChNr].Audio.Analyze := CbAnalyze.ItemIndex;
    Kanal[ChNr].Audio.RefPoint := CbRefP.ItemIndex;
    Kanal[ChNr].Audio.Pulse := CbPulseMode.Checked;
    //Kanal[ChNr].Audio.PulseTime := SeAudioPulseTime.Value;
    Kanal[ChNr].Audio.PWM := CbAudioPwm.Checked;
    Kanal[ChNr].Audio.DiffMode := CbAudioDiffMode.Checked;

    Kanal[ChNr].xRandom.mAudio := CbRanAudio.Checked;
    Kanal[ChNr].xRandom.mGen := CbRanGen.Checked;
    Kanal[ChNr].xRandom.mOn := CbRanOn.Checked;
    Kanal[ChNr].xRandom.mOff := CbRanOff.Checked;

    Kanal[ChNr].Gen.Style := CbGenStyle.ItemIndex;
    Kanal[ChNr].Gen.ShapeUp := CbGenShapeUp.ItemIndex;
    Kanal[ChNr].Gen.ShapeDown := CbGenShapeDown.ItemIndex;
    Kanal[ChNr].Gen.Shape := TbGenShape.Position;
    Kanal[ChNr].Gen.Duty := TbGenDuty.Position;
    Kanal[ChNr].Gen.Negative := CbGenNegative.Checked;
    Kanal[ChNr].Gen.FreqChangeStep := TbGenFreqChStep.Position;

    LbGenDuty.Caption := CurrToStr(50 - Kanal[ChNr].Gen.Duty/2) + '%';
    LbGenShape.Caption := IntToStr(Kanal[ChNr].Gen.Shape
         div 2) + ' : '+ IntToStr((200 - Kanal[ChNr].Gen.Shape) div 2);

    if (Kanal[ChNr].Gen.Style = 2) or (Kanal[ChNr].Gen.Style = 3) then
    begin
      LbGenFreqChange.Caption := 'Czas zmiany: ';
      LbGenFreqChStep.Caption := FormatFloat('0.0', 1+
        Power(Kanal[ChNr].Gen.FreqChangeStep, 2)/100) + ' s';
    end;
    if Kanal[ChNr].Gen.Style = 1 then //wahadlo
    begin
      LbGenFreqChange.Caption := 'OpóŸnienie wahañ: ';
      LbGenFreqChStep.Caption := IntToStr(Kanal[ChNr].Gen.FreqChangeStep);
    end;

    if (Kanal[ChNr].Gen.Style = 0)  or (Kanal[ChNr].Gen.Style = 4) then
    begin
      TbGenFreqChStep.Enabled := False;
      LbGenFreqChange.Enabled := False;
      LbGenFreqChStep.Enabled := False;
    end else
    begin
      TbGenFreqChStep.Enabled := True;
      LbGenFreqChange.Enabled := True;
      LbGenFreqChStep.Enabled := True;
    end;

    Kanal[ChNr].StrobMode := CbStrob.Checked;
    Kanal[ChNr].Negative := CbNegative.Checked;
    Kanal[ChNr].MajorPWM := CbMajorPwm.Checked;
    Kanal[ChNr].OutChannel := CbOutCh.ItemIndex + 1;

    LbAmplVal.Caption := IntToStr(Kanal[ChNr].Audio.Amplify+50)+'%';
    LbAudioDelayVal.Caption := IntToStr(Kanal[ChNr].Audio.Delay);
  end;
end;

procedure TFormChannel.EdCaptionChange(Sender: TObject);
begin
  if Odswiezanie = False then
  begin
    Kanal[ChNr].Caption := EdCaption.Text;
    Kanal[ChNr].Panel.Caption := EdCaption.Text;
  end;
end;

procedure TFormChannel.OdswiezCb;
begin
  CbMajorPwm.Enabled := not CbStrob.Checked;
  if CbStrob.Checked then CbMajorPwm.Checked := False;


  if CbMajorPwm.Checked then
  begin
    CbAudioPwm.Enabled := True;
    //CbGenShapeUp.Enabled := True;
  // CbGenShapeDown.Enabled := True;
    TbOutPower.Enabled := True;
  end else
  begin
   // CbGenShapeUp.Enabled := False;
    //CbGenShapeDown.Enabled := False;
    CbAudioPwm.Checked := False;
    TbOutPower.Enabled := False;
  end;
  Application.ProcessMessages;

  CbPulseMode.Enabled :=       not CbAudioPwm.Checked;
  SeAudioPulseTime.Enabled :=  not CbAudioPwm.Checked;
  SeAudioPulseBreak.Enabled := not CbAudioPwm.Checked;
  SeAudioSchmitMin.Enabled :=  not CbAudioPwm.Checked;
  SeAudioSchmitMax.Enabled :=  not CbAudioPwm.Checked;
  Label16.Enabled :=           not CbAudioPwm.Checked;
  Label3.Enabled :=           not CbAudioPwm.Checked;
  Label17.Enabled :=           not CbAudioPwm.Checked;
  Label4.Enabled :=           not CbAudioPwm.Checked;
  Label18.Enabled :=           not CbAudioPwm.Checked;
 // Label27.Enabled :=           not CbAudioPwm.Checked;
  Label19.Enabled :=           not CbAudioPwm.Checked;
  Label20.Enabled :=           not CbAudioPwm.Checked;
  Label28.Enabled :=           not CbAudioPwm.Checked;



end;
//==============================================================================
procedure TFormChannel.BtGenClick(Sender: TObject);
  var gbTop: Integer;
begin
  Application.ProcessMessages;
  gbTop := ImgChart.Top + ImgChart.Height + 8;

  if BtRan.Down then
  begin
    GbAudio.Visible := False;
    GbGen.Visible := False;
    GbRandom.Visible := True;
    GbRandom.Top := gbTop;
    GbRandom.Left := 8;
    FormChannel.ClientHeight := gbTop + GbRandom.Height + StatusBar.Height + 8;
  end;
  if BtGen.Down then
  begin
    GbAudio.Visible := False;
    GbRandom.Visible := False;
    GbGen.Visible := True;
    GbGen.Top := gbTop;
    GbGen.Left := 8;
    FormChannel.ClientHeight := gbTop + GbGen.Height + StatusBar.Height + 8;
  end;
  if BtAudio.Down then
  begin
    GbGen.Visible := False;
    GbRandom.Visible := False;
    GbAudio.Visible := True;
    GbAudio.Top := gbTop;
    GbAudio.Left := 8;
    FormChannel.ClientHeight := gbTop + GbAudio.Height + StatusBar.Height + 8;
  end;

  FormChannel.ClientWidth := 337;
end;

//==============================================================================


{ TGenTimerThread }
procedure TGenTimerThread.ChangeLbCaption;
begin
  if TLabel(ThLabel).Caption <> ThCaption then
    TLabel(ThLabel).Caption := ThCaption;
end;

//==============================================================================
procedure TGenTimerThread.Execute;
  const yy = 989835453;
  var   n: Byte;
begin
  inherited;
  while yy <> 829472 do
  begin  //petla glowna
    for n := 1 to 24 do
      if (not UnitMainForm.Pause) and (kanal[n].Mode = 1) then FormChannel.Generator(n);
    if ZamykanieProgramu then Break;
    sleep(10);
  end; //while yy <> 829472 do, Pause = False (nieskonczona petla)
end;
//==============================================================================
procedure TFormChannel.Generator(n: Byte);
var
       d: Double;
      ss: String;
       scU, scD, scT, scB: Currency; // steps count
       si: Integer; //step index
       siP: Double; //proporcionalny wskaznik postepu
       sf: Currency; //aktualna czestotliwoasc
begin


      si := Kanal[n].Gen.StepIndex;
      sf := Kanal[n].Gen.CurrFreq;
      if sf < Kanal[n].Gen.FreqMin then sf := Kanal[n].Gen.FreqMin;
      if sf > Kanal[n].Gen.FreqMax then sf := Kanal[n].Gen.FreqMax;
    //---------------------------------

    if Kanal[n].Gen.Style = 0 then //stala
      NewFreq[n] := (Kanal[n].Gen.FreqMin + Kanal[n].Gen.FreqMax) / 2;

    if Kanal[n].Gen.Style = 1 then //wahadlo
    begin
      if sf >= Kanal[n].Gen.FreqMax then FreqChangeUp[n] := False;
      if sf <= Kanal[n].Gen.FreqMin then FreqChangeUp[n] := True;
      d := sf / (30 + Power((Kanal[n].Gen.FreqChangeStep),1.9)) ;
      if FreqChangeUp[n] then sf := sf + d else sf := sf - d ;
    end;

    if Kanal[n].Gen.Style = 2 then //skokowy staly
    begin
      dec(FreqChangeIndex[n]);
       if FreqChangeIndex[n] <= 0 then
      begin
        NewFreq[n] := Kanal[n].Gen.FreqMin +
          Random(Kanal[n].Gen.FreqMax-Kanal[n].Gen.FreqMin);
        FreqChangeIndex[n] := Round(100 + Power(Kanal[n].Gen.FreqChangeStep, 2));
       end;
    end;

    if Kanal[n].Gen.Style = 3 then //losowy
    begin
      dec(FreqChangeIndex[n]);
       if FreqChangeIndex[n] <= 0 then
      begin
        NewFreq[n] := Kanal[n].Gen.FreqMin +
          Random(Kanal[n].Gen.FreqMax-Kanal[n].Gen.FreqMin);
        FreqChangeIndex[n] := 100 + Random(Round(Power(Kanal[n].Gen.FreqChangeStep, 2)));
       end;
    end;


    if (Kanal[n].Gen.Style = 0) or (Kanal[n].Gen.Style = 2) or
      (Kanal[n].Gen.Style = 3) then
      if Round(sf) <> Round(NewFreq[n]) then
        if sf < NewFreq[n] then
          sf := sf + ABS(NewFreq[n]-sf) / (70 + FreqChangeIndex[n]/80)  else
          sf := sf - ABS(NewFreq[n]-sf) / (70 + FreqChangeIndex[n]/80);



     //  Label23.Caption :=  currtostr(10 * (FreqChangeIndex/1000));

    if (Kanal[n].Gen.Style <> 2) and (Kanal[n].Gen.Style <> 3) then
      FreqChangeIndex[n] := 0;
 //  LAbel23.Caption :=

    if sf < 1 then sf := 1;

    //---------------- pozycjonowanie wskaznika ---------------------------
    if (FormChannel.Visible) and (n = ChNr) then
    PnGenFreqPos.Left := BtGenMin.Width - PnGenFreqPos.Width div 2 +
      Round(( sqrt(sf/10000)) * (PnGen.Width - 2 * BtGenMin.Width
        - PnGenFreqPos.Width div 2 ));

     //  sqrt(TSpinEdit(Sender).Value - 20) / sqrt(19980);

   //-------------------------------------------
    siP := Kanal[n].Gen.Progress;
    scT := (100000 / (sf*2)); //polowa okresu
    scT := scT - scT * (TbGenDuty.Position/100); // polowa ilosci impulsow przypadajacych na przebieg
    scB := (100000 /sf) - 2*scT; //ilosc impulsow przypadajacych naprzerwe

    scU := scT + scT * ((100 - FormChannel.TbGenShape.Position)/100); //liczba krokow narastajacych
    scD := scT - scT * ((100 - FormChannel.TbGenShape.Position)/100); //liczba krokow opadajacych

    if scU < 2 then scU := 2;
    if scD < 2 then scD := 2;

    si := Round(GenSiP[n] * scT);  //odtworz pozycje na podstawie wskaznika postepu



   // Label23.Caption := currtostr(scU) + '   ' + currtostr(scD) + '  '
    //  + currtostr(si);


     
    // ================== zlicznie cykli jednego okresu przebiegu ==============
    if Kanal[n].Gen.StepUpDown then
    begin // zliczanie w gore
      Inc(si);
      if si >= scU then
      begin
        Kanal[n].Gen.StepUpDown := False; //zliczaj w dol
        si := 0;
      end;
    end else
    begin //zliczanie w dol
      Inc(si);
      if si >= scD then
      begin
        inc(Kanal[n].Gen.StepBreakIndex);
        if Kanal[n].Gen.StepBreakIndex >= scB then
        begin
          Kanal[n].Gen.StepUpDown := True; //zliczaj w gore
          si := 0;
          Kanal[n].Gen.StepBreakIndex := 0;

          if Kanal[n].Gen.Style = 4 then //chaos
            sf := Kanal[n].Gen.FreqMin +
              Random(Kanal[n].Gen.FreqMax-Kanal[n].Gen.FreqMin);
        end  else si := Round(scD);
      end;
    end;

 //   if odd(si) then pncolor.Color := clNavy else pncolor.Color := clGreen;




    if si < 0 then si := 0;
    GenSiP[n] := si/scT; //zapamietanie wartosci w skali narastajacej

    if Kanal[n].Gen.StepUpDown then //jesli zlicza w gore
      siP := (si/scU) else siP := ((scD-si)/scD);

    if sf > 500000 then sf := 500000;
    if sf < 1 then sf := 1;
    //if sc > 50000 then sc := 50000;
    //if sc < 5 then sc := 5;
 //   if si > Round(sc) then si := Round(sc);

   //   si := - Round(sc * ((TbGenDuty.Position/(TbGenDuty.Max*2))));

     if (FormChannel.Visible) and (n = ChNr) then
     begin
       ss := '';
       if (Kanal[n].Gen.Style = 2) or (Kanal[n].Gen.Style = 3) then
         ss := ',     df = ' +FormatFloat('0.0', FreqChangeIndex[n] / 100) + ' s';
       ss := 'f = ' + FormatFloat('0.000',sf / 1000)
         +  ' Hz,     T =  ' +FormatFloat('0.000',1000 / sf)+' s' + ss;
       ThLabel := LbGenfreq;  ThCaption := ss;
       GenTimerThread.Synchronize(GenTimerThread.ChangeLbCaption);
   end;




    //Sinusoidalny:
    if Kanal[n].Gen.StepUpDown then
    begin
      if Kanal[n].Gen.ShapeUp = 0 then Kanal[n].Gen.OutLevel :=
        (1 - sin( (siP + 0.5) * pi)) * 128;
      if Kanal[n].Gen.ShapeUp = 1 then Kanal[n].Gen.OutLevel :=
        sin(siP * (pi/2)) * 255;
      //trojkatny:
      if Kanal[n].Gen.ShapeUp = 2 then Kanal[n].Gen.OutLevel := siP * 255;
      //prostokatny
      if Kanal[n].Gen.ShapeUp = 3 then if sip > 0.5 then
        Kanal[n].Gen.OutLevel := 255 else Kanal[n].Gen.OutLevel := 0;
    end else
    begin
      if Kanal[n].Gen.ShapeDown = 0 then Kanal[n].Gen.OutLevel :=
        (1 - sin( (siP + 0.5) * pi)) * 128;
      if Kanal[n].Gen.ShapeDown = 1 then Kanal[n].Gen.OutLevel :=
        sin(siP * (pi/2)) * 255;
      //trojkatny:
      if Kanal[n].Gen.ShapeDown = 2 then Kanal[n].Gen.OutLevel := sip * 255;
      //prostokatny
      if Kanal[n].Gen.ShapeDown = 3 then if sip > 0.5 then
        Kanal[n].Gen.OutLevel := 255 else Kanal[n].Gen.OutLevel := 0;
    end;



    if Kanal[n].Gen.OutLevel > 255 then Kanal[n].Gen.OutLevel := 255;
    if Kanal[n].Gen.OutLevel < 0 then Kanal[n].Gen.OutLevel := 0;

    if FormChannel.CbGenNegative.Checked then
      Kanal[n].Gen.OutLevel := 255 - Kanal[n].Gen.OutLevel;
   // Gauge2.Progress := Round(Kanal[n].Gen.OutLevel);

      Kanal[n].Gen.Progress := siP;
      Kanal[n].Gen.StepIndex := si;
      Kanal[n].Gen.CurrFreq := sf;

end;

//==============================================================================
procedure TFormChannel.Timer2Timer(Sender: TObject);
  var m: Integer;
  var pt: array of TPoint;
begin
  if FormChannel.Visible = True then
  begin

    ImgChart.Width := ImgChart.Width;
    ImgChart.Height := ImgChart.Height;
    setLength(pt, ImgChart.Width);

    pt[0].X := 1;
    pt[0].Y := ImgChart.Height-2;
    pt[High(pt)].X := ImgChart.Width-2;
    pt[High(pt)].Y := ImgChart.Height-2;


    for m := 1 to ImgChart.Width-2 do
    begin
      if Abs(Kanal[ChNr].Bufor[m-1] - Kanal[ChNr].Bufor[m]) > 200 then
        pt[m].X := m+1 else pt[m].X := m;

      pt[m].Y := ImgChart.Height -
        Round((Kanal[ChNr].Bufor[m-1] / 300) * ImgChart.Height) - 2;
    end;



  {  for m := 0 to High(Kanal[ChNr].pArray) do
    begin
      if Abs(Kanal[ChNr].Bufor[m] - Kanal[ChNr].Bufor[m+1]) > 200 then
        Kanal[ChNr].pArray[m].X := m+1 else Kanal[ChNr].pArray[m].X := m;

      Kanal[ChNr].pArray[m].Y := ImgChart.Height -
        Round((Kanal[ChNr].Bufor[m] / 300) * ImgChart.Height) - 3;

    end; }


    GenBmp.Canvas.Pen.Color := clSilver;
    GenBmp.Canvas.Brush.Style := bsSolid;
    GenBmp.Canvas.Brush.Color := clBtnFace;

    GenBmp.Canvas.Rectangle(0, 0, ImgChart.Width, ImgChart.Height);

    //ImgChart.Canvas.Polyline(Kanal[ChNr].pArray);

    GenBmp.Canvas.Pen.Color := clBlack;
    GenBmp.Canvas.Brush.Style := bsSolid;
    GenBmp.Canvas.Brush.Color := clSilver;
    GenBmp.Canvas.Polygon(pt);
    ImgChart.Canvas.Draw(0,0, GenBmp);
  end;
end;

end.

