unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, FFTReal, Math, ComCtrls, XPMan, Gauges,
  StdCtrls, Menus, AudioIo, INIFiles;

type
  TMainForm = class(TForm)
    ImgMain: TImage;
    ImgTlo05: TImage;
    ImgTlo12: TImage;
    ImgTlo24: TImage;
    BtSettings: TImage;
    BtSpeaker: TImage;
    BtBars: TImage;
    BtVisBars: TImage;
    BtPause: TImage;
    BtSound: TImage;
    BtAbout: TImage;
    BtMinimize: TImage;
    BtClose: TImage;
    BtVis: TImage;
    TimerSkin: TTimer;
    XPManifest1: TXPManifest;
    TbAmplify: TTrackBar;
    ImgLedG: TImage;
    ImgLedR: TImage;
    ImgLedY: TImage;
    ImgLedGx: TImage;
    ImgLedRx: TImage;
    ImgLedYx: TImage;
    TbDelay: TTrackBar;
    TbDuty: TTrackBar;
    PnChannel_05: TPanel;
    PnChannel_04: TPanel;
    PnChannel_03: TPanel;
    PnChannel_02: TPanel;
    PnChannel_01: TPanel;
    PopupMainMenu: TPopupMenu;
    ryb1: TMenuItem;
    mMode5: TMenuItem;
    mMode12: TMenuItem;
    mMode24: TMenuItem;
    PnChannel_08: TPanel;
    PnChannel_07: TPanel;
    PnChannel_06: TPanel;
    PnChannel_09: TPanel;
    PnChannel_10: TPanel;
    PnChannel_11: TPanel;
    PnChannel_12: TPanel;
    PnChannel_13: TPanel;
    PnChannel_14: TPanel;
    PnChannel_15: TPanel;
    PnChannel_16: TPanel;
    PnChannel_24: TPanel;
    PnChannel_23: TPanel;
    PnChannel_22: TPanel;
    PnChannel_21: TPanel;
    PnChannel_20: TPanel;
    PnChannel_19: TPanel;
    PnChannel_18: TPanel;
    PnChannel_17: TPanel;
    LbProfile: TLabel;
    ImgWinamp: TImage;
    Winap1: TMenuItem;
    TimerFPS: TTimer;
    MenuProfiles: TPopupMenu;
    Domyslny: TMenuItem;
    ImgVis: TPaintBox;
    Zmknij1: TMenuItem;
    ImgWykrzyknik: TImage;
    WinampMenu: TPopupMenu;
    Powiaz1: TMenuItem;
    Pokazpowiazania1: TMenuItem;
    procedure LadujDomyslneUstawienia;
    procedure ZapiszUstawienia;
    procedure WczytajUstawienia;
    procedure Przeladuj;
    procedure DarkColorLevel;
    procedure SendData;
    procedure Rysuj;
    function Kolor(Col1, Col2: TColor; Max, Pos: Integer): TColor;
    procedure ButtonClick(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function AudioInBufferFilled(Buffer: PAnsiChar;
      var Size: Integer): Boolean;
    procedure TimerSkinTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImgMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgMainDblClick(Sender: TObject);
    procedure ButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtSettingsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PnChannel_24DblClick(Sender: TObject);
    procedure ImgVisMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImgWinampClick(Sender: TObject);
    procedure Winap1Click(Sender: TObject);
    procedure TimerFPSTimer(Sender: TObject);
    procedure LbProfileDblClick(Sender: TObject);
    procedure LbProfileMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Zmknij1Click(Sender: TObject);
    procedure LoadWinampAssociations;
    procedure Powiaz1Click(Sender: TObject);
    procedure Pokazpowiazania1Click(Sender: TObject);
    procedure SprawdzPowiazania;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  TDrawThread = class(TThread)
  protected
    procedure Execute; override;
  end;

  TPrzyciski = record
    Img: TImage;
    Active: Boolean;
  end;

  LEDs = record
    FreqMax: Integer;
    FreqMin: Integer;
    SmpMin:  Integer; //zakres sampli
    SmpMax:  Integer;
    Active:  array of Boolean;
    Level:   Currency;
  end;

  TAudio = record
    FreqMin:  Integer;
    FreqMax:  Integer;
    SmplMin:  Integer;
    SmplMax:  Integer;
    OutLevel:       Currency; //poziom wyjsciowy
    Level:    Currency;   //aktualny poziom audio
    DiffLevel: Currency;  //poziom roznicowy audio
    SchmitMin:      Byte; //minimalna wartosc petly histerezy
    SchmitMax:      Byte; //maksymalna wartosc petly histerezy
    Pulse:          Boolean; //tryb impulsowy
    PulseTime:      Word; //czas impulsu
    PulseBreak:     Word; //czas przerwy
    DiffMode:       Boolean;
    PWM:            Boolean; //tryb PWM
    RefPoint:       Byte; //punkt odniesienia
    Analyze:        Byte; //metoda analizy
    Amplify:        Integer; //wzmocnienie
    Delay:          Integer; //opoznienie
  end;

  TGen = record
    FreqMin:        Word; //zakres minimalny
    FreqMax:        Word; //zakres maksymalny
    OutLevel:       Currency; //poziom wyjsciowy
    ShapeUp:          Byte; //ksztlt zbocza narastajacego(sinus, trojkat, prostokat)
    ShapeDown:          Byte; //ksztlt zbocza opadajacego (sinus, trojkat, prostokat)
    Style:          Byte; //sposob zmian (plynny, skokowy, losowy)
    StepUpDown:          Boolean; // kierunek zliczania impulsow
    StepIndex:      LongInt; // index podzialki czestotliwosci
    StepBreakIndex: Integer;
    FreqChangeStep:   Integer;
   // StepsCountUp:      Currency; //calkowita ilosc krokow narastajacych
   // StepsCountDown:      Currency; //calkowita ilosc krokow opadajacych
    Progress:       Double; //aktualny wskaznik postepu (procentowy)
   // FreqChanged:     Boolean; //czy wartosc czestotliwosci ulegla zmianie
   // FreqUpDown:     Boolean;  //zwiekszanie lub zmniejszanie czestotliwosci dla trybu plynnego
  //  FreqStep:       Currency;
    CurrFreq:       Currency; //chwilowa czestotliwosc
    CyclesCount:    Integer; //licznik cykli zmian czestotliwosci dla trybu skokowego
 //   FreqChngMin:    Integer; // zakres zmian czestotliwosci         [SeGenFreqChMin]
 //   FreqChngMax:    Integer; // zakres zmian czestotliwosci         [SeGenFreqChMin]
    Duty:           Integer; // wspolczynnik wypelnienia            [TbGenDuty]
    Shape:          Integer; // ksztalt przebiegu (stromosc zbocza) [TbGenShape]
    Negative:       Boolean; // negacja przebiegu                   [CbGenNegative]
  end;

  TxRandom = record
    Mode:           Integer; //aktualny tryb
    FreqMin:        Word;
    FreqMax:        Word;
    mAudio:         Boolean;
    mGen:           Boolean;
    mOn:            Boolean;
    mOff:           Boolean;

  end;

  TKanal = record
    Panel:          TPanel; // uchwyty paneli
    Mode:           Byte;
    Audio:          TAudio;
    Gen:            TGen;
    xRandom:        TxRandom;
    ColorLight:     TColor;
    ColorDark:      TColor;
    Caption:        ShortString; //etykieta na panelu
    OutChannel:     Byte; //numer kanalu wyjsciowego
    StrobMode:      Boolean; //tryb stroboskop
    Negative:       Boolean; //negacja
    MajorPWM:       Boolean; //glowny PWM
    OutLevel:       Currency; //poziom wyjsciowy
    OutPower:       Byte; //ogranicznik mocy
    pArray:         array of TPoint;
    Bufor:          array[0..5000] of Byte;
  end;

var
  MainForm: TMainForm;
  AudioIn: TAudioIn;
  AudioOut: TAudioOut;
  DrawThread: TDrawThread;
  

  //================== ZMIENNE DO WIZUALNEJ OBSLUGI PROGRAMU ===================
  przyciski:              array[1..10] of TPrzyciski; // wskaznik rekordu
  MDMove:           Boolean;  // czy klawisz jest klikniety
  PMove:            TPoint;   // wspolrzedne klikniecia
  ShowSpectDot:     Boolean = True;
  CursorFFTfreq:    String; //czestotliwosc wskazana kursorem na analizatorze
  CursorFFTfreqOld: String;
  WinampTitleOld:   String;
  EnableWinampTitle: Boolean = True;
  CzasPrzerwy:       Integer = 0; //liczba cykli w ktorych nie jest nic rysowane
  DrawBusy:           Boolean; //program aktualnie zajety jest rysowaniem
  DrawFPS:           Integer = 0;
  VisBMP:           TBitmap;
  VisDelay:         Boolean;  //czy zmniejszyc czestotliwosc odswiezania
  VisDlyDiv:        Boolean;  // licznik (dwukrotny)
  WinampAlist:      array[0..1] of TStrings;
  FftLogMask:       array of Word;
  FftAmplMask:       array of Currency;

  //===================== ZMIENNE DO OBSLUGI TRYBOW PRACY ======================
  Kanal:      array[1..24] of TKanal;

  DarkLevel:  Byte = 80;


  //============================= ZMIENNE STATYSTYCZNE =========================
  StartTime:        TTime; //czas uruchomienia programu
  ZeroTime:         LongInt = 0;  //czas bezczynnosci (brak dzwieku)
  aFftSr:            array[0..50] of Double;
  FftSr:            Currency;
  aFftMax:         array[0..50] of Double;
  FftSrMax:           Currency;

  //=================================== WIZULACJE ==============================
  VisMode:            Byte = 0; //tryb wyswietlania 0-osc., 1-anal., 2-anl.led
  SpectLedImgLoaded:    Boolean; //czy zaladowano tlo dla analizatora LED
  LED:              array of LEDs;
  LedCountY :         Byte = 15;
  LedCountX:          Byte = 15;
  LedBmp: TBitmap; // bitmapa dla analizatora led
  sda:           array of TPoint; //tablica ostatnio rysowanych punktow
   LedTop: Integer;   // pozycja diodowego analizatora

  //=========== REJESTRACJA I PRZETWARZANIE DZWIEKU ============================

//  AudioBuffer:               PAnsiChar; //przepisany bufor (potrzebny do obslugi watku)
  Scope:                array of Integer;
  FftOut:               array of Currency; // wartosci FFT po przetworzeniu (BufferSize/2)
  FFT:                   TFFTReal; //obiekt FFT
  FFTpfltIn:             pflt_array; //dane wejsciowe dla FFT
  FftIn:                array of Single;
  FFTpfltOut:            pflt_array; //przetworzone dane FFT
  BuffSize:              Integer; //rzeczywisty rozmiar bufora 16bit (Bufor/2)
  Min, Max : Integer;  // ???
  TempMax  : Integer;  // ???
  FftFallDly:            Currency = 3; //opoznienie opadania analizatora

  OscMaxLv:      Currency; //chwilowy maksymalny poziom glosnosci;
  AudioInMaxLv:  Integer; //chwilowy poziom sygnalu wejsciowego
  AudioInMaxLvSr:  Currency; // chwilowy sredni poziom sygnalu wejsciowego
  FftMaxLv:      Integer;  // wartosc czestotliwosci o najwyzszym poziomie
  FFtFreqmaxLv:  Integer; //numer probki czestotliwosci o najwyzszym poziomie
  VolChanging:   Boolean; //informacja o tym, ze wlasnie zmienia sie glosnosc
  aAmplify:       Currency; //poziom wzmocnienia
  AutoVol:     Boolean = True; //automatyczna regulacja glosnosci
  AudioFPS:    Integer = 0;
  WykrzyknikVisible:  Boolean; //czy wyswietlone jest ostrzezenie


  vl, vr: integer; //audioin2
  //=========================== POZOSTALE ZMIENNE ==============================
  Pause:      Boolean;
  FPS_Counter:   Integer = 0;
  ChannCount:    Byte = 12; //ilosc kanalow 5,12,24
  ZamykanieProgramu: Boolean;

  DefProfCount:   Integer = 1; //liczba domyslnych profili

implementation

uses UnitSettings, UnitStats, UnitMixerAudio, UnitSineGenerator,
  UnitAudioSettings, UnitChannel, UnitAbout, UnitWinamp, UnitProfiles,
  UnitWinampAssociations;

{$R *.dfm}
//==============================================================================
procedure TMainForm.FormCreate(Sender: TObject);
  var n: Integer;
      d: Double;
begin
  VisBMP := TBitmap.Create;
  VisBMP.Width := ImgVis.Width;
  VisBMP.Height := ImgVis.Height;

  // AUDIO IO
  TAudioIO.Create(Self);
  AudioIn := TAudioIN.Create(Self);
  AudioOut := TAudioOut.Create(Self);
  AudioIn.OnBufferFilled := AudioInBufferFilled;
  AudioOut.OnFillBuffer := FormSineGenerator.AudioOut1FillBuffer;

  AudioOut.BufferSize := 4096;
  AudioOut.FrameRate := 44100;



  AudioIn.Stereo := False;
  AudioIn.BufferSize := 2048;
  AudioIn.FrameRate := 44100;


  DrawThread := TDrawThread.Create(True);
  DrawThread.Priority := tpLowest;


 // DoubleBuffered := True;
  SetLength(LED, LedCountX);
  for n := 0 to LedCountX-1 do SetLength(LED[n].Active, LedCountY);

  GetMem(FFTpfltIn, AudioIn.BufferSize * SizeOf_flt);
  GetMem(FFTpfltOut, AudioIn.BufferSize * SizeOf_flt);
  FFT:=TFFTReal.Create(AudioIn.BufferSize);

  BuffSize := AudioIn.BufferSize div 2;
  // ustal rozmiary tablic
  SetLength(FftOut, BuffSize);
  SetLength(Scope, BuffSize);

  ImgVis.Canvas.Draw(-ImgVis.Left,-ImgVis.Top,ImgMain.Picture.Graphic);

  Przyciski[1].Img := BtSettings;
  Przyciski[2].Img := BtSpeaker;
  Przyciski[3].Img := BtBars;
  Przyciski[4].Img := BtVisBars;
  Przyciski[5].Img := BtPause;
  Przyciski[6].Img := BtSound;
  Przyciski[7].Img := BtVis;
  Przyciski[8].Img := BtAbout;
  Przyciski[9].Img := BtMinimize;
  Przyciski[10].Img := BtClose;

  StartTime := GetTime ;
  MainForm.LadujDomyslneUstawienia;
  LedBmp := TBitmap.Create;


  SetLength(FftLogMask, ImgVis.Width); //ustal rozmiar maski
  for n := 0 to ImgVis.Width-1 do
  begin
    d := 1-log10(1+9* (VisBMP.Width-n)/(VisBMP.Width));
    d := power(d, 1.3);
    if d < 0 then d := 0;
    if d > 1 then d := 1;
    d := d * (20000 / (AudioIn.FrameRate/2) * BuffSize -1);
    FftLogMask[n] := Round(d);
  end;
   //maska wzmocnienia fft
  SetLength(FftAmplMask, Buffsize);
  for n := 0 to Buffsize-1 do //obliczenie ABS(FFT)
    FftAmplMask[n] := 2 * power( (1 + 3.3113-  log10(1+n)),3.5);
end;
//==============================================================================
function TMainForm.AudioInBufferFilled(Buffer: PAnsiChar;
  var Size: Integer): Boolean;
  var SP    : ^SmallInt;
      m, n, v  : Integer;
      xMin, xMax : Integer;
      c, f: Double;
      vMax: Currency;
begin
  AudioFPS := AudioFPS + 1;
  SetLength(FftIn, BuffSize);
  c := (MainForm.TbAmplify.Max - MainForm.TbAmplify.Position) /
    MainForm.TbAmplify.Max ;

  aAmplify := (5.47722*c) * (5.47722*c);

  if Pause = False then
  begin
    SP := Pointer(Buffer);
    xMin := SP^;
    xMax := xMin;
    for n := 0 to BuffSize-1 do
    begin
      FftIn[n] := 0;
      v := SP^;
      FFTpfltIn[n] := SP^;
      FftIn[n] := SP^;
      Inc(SP);
      if (xMin > v) then xMin := v;
      if (xMax < v) then xMax := v;
     end;
    if (Min > xMin) then Min := xMin;
    if (Max < xMax) then Max := xMax;

    TempMax := xMax;
    if (Abs(xMin) > xMax) then TempMax := Abs(xMin);

//========================= OBLICZENIA ANALIZATORA WIDMA =======================
    for n := 0 to BuffSize-1 do //okienkowanie Hanninga
      begin
        Scope[n] := Round(FftIn[n] * aAmplify * -1); //przepisanie tablicy przed okienkowaniem
        FftIn[n] := Round( FftIn[n] *sin(  (n/(Buffsize-1) )*pi ));
        FFTpfltIn[n] := FftIn[n];
      end;

     // Label1.Caption := Currtostr(FftIn[0]) + '   '+Currtostr(FftIn[1023]);
    FftMaxLv := 0;
    FFT.do_fft(FFTpfltOut, FFTpfltIn);  //obliczenie FFT
    for n := 0 to Buffsize-1 do //obliczenie ABS(FFT)
    begin
      f := Sqrt(Sqr(FFTpfltOut^[n]) + Sqr(FFTpfltOut^[n+BuffSize]));
    //  c := 2 * power( (1 + 3.3113-  log10(1+n)),3.5);

      f := (aAmplify * f /  FftAmplMask[n]) * 1.7;  //wzmocnienie

      f := f - (40*aAmplify); //obnizenie


      if f < 0 then f := 0;
      if f > FftOut[n] then FftOut[n] := f else
        FftOut[n] := FftOut[n] - (FftOut[n]-f)/(
        (MainForm.TbDelay.Position*mainForm.TbDelay.Position/30)/
          (unitMainForm.AudioIn.BufferSize/2048));

      if FftOut[n] < 0 then FftOut[n] := 0;
      if FftOut[n] > FftMaxLv then
      begin
        FftMaxLv := Round(FftOut[n]); //przepisz wartosc wzmocnienia
        FFtFreqmaxLv := n;  // przepisz numer probki
      end;
    end; //for n := 0 to Buffsize-1
//============================ OBLICZENIA OSCYLOSKOPU ==========================
    OscMaxLv := 0;
    AudioInMaxLv := 0;
    for n := 0 to BuffSize-1 do
    begin
      if Abs(Scope[n]) > OscMaxLv then  OscMaxLv := Abs(Scope[n]);
      if Abs(FFTpfltIn[n]) > Abs(AudioInMaxLv) then AudioInMaxLv := Round(FFTpfltIn[n]);
    end;

    if Abs(AudioInMaxLvSr) < Abs(AudioInMaxLv) then AudioInMaxLvSr :=
      Abs(AudioInMaxLv) else AudioInMaxLvSr := AudioInMaxLvSr - 100;

      if AudioInMaxLvSr < 0 then AudioInMaxLvSr := 0;

//    gauge1.Progress := Round(AudioInMaxLvSr);

  //============================= ANALIZATOR LED ==============================
    c := 0;
    for m := 0 to LedCountX-1 do
    begin
      for n := Led[m].SmpMin to Led[m].SmpMax do
      if FftOut[n] > c then c := FftOut[n] ;
      if c > 65000 THEN C:= 65000;
      c :=  (c / 60000) * LedCountY-0.5;
      Led[m].Level :=c;
      if Led[m].Level < -6 then Led[m].Level := -6;
    end;

  //--------------------------- Statystyki -------------------------------------

  //przepisz tablice
  for n := High(aFftSr) downto 1 do aFftSr[n] := aFftSr[n-1];
  for n := High(aFftMax) downto 1 do aFftMax[n] := aFftMax[n-1];
  c := 0;
  for n := 0 to High(FftOut) do c := c + FftOut[n];
  c := c / Length(FftOut);
  aFftSr[0] := c;
  FftSr := Mean(aFftSr);
  c := 0;
  for n := 0 to High(FftOut) do if FftOut[n] > c then c := FftOut[n];
  aFftMax[0] := c;
  FftSrMax := Mean(aFftMax);

    {============== PRZELICZENIA DLA POSZCZEGOLNYCH KANALOW ===================}
    for m := 1 to 24 do
    begin
      vMax := 0;
      for n := Kanal[m].Audio.SmplMin to Kanal[m].Audio.SmplMax do
      begin

      if FftOut[n] > vMax then vMax := FftOut[n];
      end; //n := Kanal[m].Audio.SmplMin to Kanal[m].Audio.SmplMax

      c := vMax;
      c := ((101-MainForm.TbDuty.Position)/100)* c * 4;

      if Kanal[m].Audio.DiffMode then
      begin
        if (c - Kanal[m].Audio.OutLevel) > Kanal[m].Audio.DiffLevel then
          Kanal[m].Audio.DiffLevel := (c - Kanal[m].Audio.OutLevel) else
            Kanal[m].Audio.DiffLevel :=
              Kanal[m].Audio.DiffLevel - (Kanal[m].Audio.DiffLevel/10);
        c := Kanal[m].Audio.DiffLevel;
      end;

        if not Kanal[m].Audio.PWM then
        begin
          if c > 50000 then  c := 65535 else
          if c < 30000 then  c := 0 else
          c := Kanal[m].Audio.OutLevel * 256; //przywrocenie poprzedniej wartosci
        end;


       c := c / 256; //ograniczenie zakresu (65536 -> 256)
       if c > 255 then c := 255;
       if c < 0 then c := 0;
       Kanal[m].Audio.OutLevel := c;






     //============================================================
     end; //for m := 1 to 24 do

    if AutoVol = True then
    begin
      v := 2000-MainForm.TbAmplify.Position;
      c := (FftSrMax + FftSr) / 1.15 ;

      if aFftMax[0] > 150000 then v := v - (v div 100) else
      if c > 85000 then v := v - (v div 300) else
      if c > 70000 then v := v - (v div 500);
     // if FftSrMax > 550000 then v := v - (v div 1000);

      if (FftSrMax < 5000) and (FftSr < 1500) then v := v + (v div 100) else
      if c < 10000 then v := v + (v div 300) else
      if c < 30000 then v := v + (v div 600);
      //if FftSrMax < 40000 then v := v + (v div 1000);
      MainForm.TbAmplify.Position := 2000-v;
    end;

  Inc(FPS_Counter);
  end; // pause = False
  SendData;
  DrawThread.Execute;


  Result := TRUE;
end;

//==============================================================================
procedure TMainForm.SendData;
  var n,v: Byte;
      PnCl: TColor;
      R,G,B: Byte;
      k: Integer;
begin
  v := 0;
  for n := 1 to 24 do
  begin
    if Kanal[n].Mode = 1 then v := Round(Kanal[n].Gen.OutLevel);
    if Kanal[n].Mode = 2 then v := Round(Kanal[n].Audio.OutLevel);
    if Kanal[n].Mode = 3 then Kanal[n].OutLevel := 255;
    if Kanal[n].Mode = 4 then Kanal[n].OutLevel := 0;
   // v := Round((v/255) * v);

    // jesli nie zezwolono na prace w trybie PWM:
    if not Kanal[n].MajorPWM then
      if v < 128 then v := 0 else v := 255;

    Kanal[n].OutLevel := v;

    // przepisz bufor:
    if not Pause then
    begin
      for k := High(Kanal[n].Bufor) downto 1 do
        Kanal[n].Bufor[k] := Kanal[n].Bufor[k-1];
        Kanal[n].Bufor[0] := v;
    end;

      PnCl := MainForm.Kolor(Kanal[n].ColorLight,Kanal[n].ColorDark,255,255-v);
    Kanal[n].Panel.Color := PnCl;
    R := GetRvalue(PnCl); G := GetGvalue(PnCl); B := GetBvalue(PnCl);
    Kanal[n].Panel.Font.Color := RGB(not R, not G, not B);
   // if PanelNumber = d then  FormChannel.PnPreview.Color := PnCl;
  end;
  if FormChannel.Visible then
    FormChannel.GaLevel.Progress := Round(Kanal[ChNr].Gen.OutLevel);

   if not Pause then
     FormChannel.Timer2Timer(Self);
end;

// =============================== RYSOWANIE CANVAS ============================
//==============================================================================


{ TDrawThread }

procedure TDrawThread.Execute;
begin
  inherited;
  if VisDelay = True then
  begin
    if VisDlyDiv then DrawThread.Synchronize(MainForm.Rysuj);
    VisDlyDiv := not VisDlyDiv;

  end else DrawThread.Synchronize(MainForm.Rysuj);



end;

//==============================================================================

procedure TMainForm.Rysuj;
  var    m, n: Integer;
         mx, my, ya: Integer;
  sd:   array of TPoint;
  b: Boolean;
  d: Double;


  const
    //OscDiv = 65536;
    OscDiv = 80000;
   // OscDiv = 70000;
    FftDiv = 32768;
begin
  DrawFPS := DrawFPS + 1;

  CzasPrzerwy := CzasPrzerwy + 1;

  if not DrawBusy then
  if (MainForm.Visible) then With MainForm do
  try
   DrawBusy := True;
   b := True;

   if Winamp.Title <> WinampTitleOld then SprawdzPowiazania;


  // =============================== OSCYLOSKKOP ===============================
  if VisMode = 0 then
  begin
     SpectLedImgLoaded := False;
    SetLength(sd, VisBMP.Width); // ustal rozmiar tablicy punktow

    for n := 0 to High(sd) do
    begin
      sd[n].X := n;

      d := Scope[Round( n * BuffSize / VisBMP.Width)];

      sd[n].Y := Round( d * VisBMP.Height /OscDiv); // oblicz wartosc w pionie


      sd[n].Y := sd[n].Y + VisBMP.Height div 2; // przesun do polowy
      if sd[n].Y < 0 then sd[n].Y := 0; //dodatkowe zabezpieczenia
      if sd[n].Y > VisBMP.Height then sd[n].Y := VisBMP.Height-1;

      //jesli dwie kolejne wartosci sa identyczne to ustaw pozycje X na -1:
      if sd[n].Y > 0 then if sd[n].Y = sd[n-1].Y then sd[n].X := sd[n-1].X;


    end;
    //---------------- sprawdzanie czy tablice sa identyczne -------------------
    if Length(sd) <> Length(sda) then b := False; //jezeli rozmiary tablic sa rozne
    if b = True then for n := 0 to High(sd) do if sd[n].Y <> sda[n].Y then
    begin b := False; Break; end; //jesli wspolrzedne sa rozne to..

    if (b = False) or (WinampTitleOld <> Winamp.Title) then //jesli tablice sa roze to rysuj
    begin
      CzasPrzerwy := CzasPrzerwy - 2;
      SetLength(sda, Length(sd));
      for n := 0 to High(sd) do sda[n] := sd[n]; //przepisz punkty

      VisBMP.Canvas.Draw(-ImgVis.Left,-ImgVis.Top,ImgTlo12.Picture.Graphic);
      // linia pozioma
      VisBMP.Canvas.Pen.Color := RGB(60, 60, 80);
      VisBMP.Canvas.MoveTo(0, ImgVis.Height Div 2);
      VisBMP.Canvas.LineTo(ImgVis.Width, ImgVis.Height Div 2);
     { // linia pionowa
      VisBMP.Canvas.MoveTo(ImgVis.Width Div 2, 0);
      VisBMP.Canvas.LineTo(ImgVis.Width Div 2, ImgVis.Height); }



      VisBMP.Canvas.Pen.Color := clLime;
      VisBMP.Canvas.Polyline(sd); //rysuj oscyloskop
      //tytul utworu z winampa
      if Winamp.AssociatedTitle then VisBMP.Canvas.Font.Color := clWhite else
        VisBMP.Canvas.Font.Color := clGray;
      VisBMP.Canvas.Brush.Style := bsClear;
      if (Winamp.Status = 'odtwarzanie') and (EnableWinampTitle) then
      VisBMP.Canvas.TextOut(2, 2, Winamp.Title);
      WinampTitleOld := Winamp.Title;


    end;
  end; // VisMode = 0

  // ============================ ANALIZATOR WIDMA =============================
    if VisMode = 1 then
    begin
      SpectLedImgLoaded := False;
      setLength(sd,VisBMP.Width + 2);

      // pierwszy punkt tablicy (lewy dolny rog)
      sd[0].X := 0;
      sd[0].Y := VisBMP.Height-1;
      // ostatni punkt tablicy (prawy dolny rog)
      sd[VisBMP.Width + 1].X := VisBMP.Width-1;
      sd[VisBMP.Width + 1].Y := VisBMP.Height-1;

      my := 0;
      mx := 0;
      for n := 0 to VisBMP.Width - 1 do
      begin
        sd[n+1].X := n;

        ya := Round(FftOut[FftLogMask[n]] * VisBMP.Height/FftDiv);

        if ya > my then
        begin
          mx := n;
          my := ya;
          if my < 0 then my := 0;
         end;

         if ya < 0 then ya := 0;
        //if ya < VisBMP.Height-1 then sd[n+1].Y := VisBMP.Height-1;

        sd[n+1].Y := VisBMP.Height - ya;
        if sd[n+1].Y < 0 then sd[n+1].Y := 0;

        //eliminowanie dwoch sasiednich identycznych wartosci
        if sd[n+1].Y > 3 then
        if sd[n+1].Y = sd[n].Y then
        begin
          sd[n+1].Y := sd[n].Y;
          sd[n+1].X := sd[n].X;
        end;

      end;
          //---------------- sprawdzanie czy tablice sa identyczne -------------------
    if Length(sd) <> Length(sda) then b := False; //jezeli rozmiary tablic sa rozne
    if b = True then for n := 0 to High(sd) do if sd[n].Y <> sda[n].Y then
    begin b := False; Break; end; //jesli wspolrzedne sa rozne to..
    if (b = False) or (CursorFFTfreqOld <> CursorFFTfreq) or
      (WinampTitleOld <> Winamp.Title) then //jesli tablice sa roze to rysuj
    begin
      CzasPrzerwy := CzasPrzerwy - 2;
      SetLength(sda, Length(sd));
      for n := 0 to High(sd) do sda[n] := sd[n]; //przepisz punkty
      VisBMP.Canvas.Draw(-ImgVis.Left,-ImgVis.Top,ImgTlo12.Picture.Graphic);



      my := VisBMP.Height - my; //odwroc
      if my > VisBMP.Height then my := VisBMP.Height;
      if my < 0 then my := 0;

      {--------------------- wartosci czestotliwosci ----------------------}
      if CursorFFTfreq <> '' then
      begin
        VisBMP.Canvas.Brush.Style := bsClear;
        VisBMP.Canvas.Font.Color := clGray;
        VisBMP.Canvas.TextOut(VisBMP.Width div 2 -
          VisBMP.Canvas.TextWidth(CursorFFTfreq) div 2, 16, CursorFFTfreq);

        CursorFFTfreqOld := CursorFFTfreq;
      end;



      if ShowSpectDot then
      begin
      //-------------- narysuj przecinajace sie proste
       VisBMP.Canvas.Pen.Color := clGreen;
      if my < 2 then my := 2;
      if mx < 2 then mx := 2;
      if my > VisBMP.Height - 3 then my := VisBMP.Height - 3;
      if mx > VisBMP.Width - 3 then my := VisBMP.Width - 3;


       VisBMP.Canvas.MoveTo(mx,0);
      VisBMP.Canvas.LineTo(mx, VisBMP.Height);
      VisBMP.Canvas.MoveTo(0, my);
      VisBMP.Canvas.LineTo(VisBMP.Width, my);
      end;
      //-------------------- nanies przebieg ---------------
      VisBMP.Canvas.Pen.Color := clLime;
      VisBMP.Canvas.Brush.Color := clGreen;
      VisBMP.Canvas.Brush.Style := bsDiagCross;

      VisBMP.Canvas.Polygon(sd);; //rysuj analizator

      //tytul utworu z winampa
      if Winamp.AssociatedTitle then VisBMP.Canvas.Font.Color := clWhite else
        VisBMP.Canvas.Font.Color := clGray;
      VisBMP.Canvas.Brush.Style := bsClear;
      if (Winamp.Status = 'odtwarzanie') and (EnableWinampTitle) then
      VisBMP.Canvas.TextOut(2, 2, Winamp.Title);
      WinampTitleOld := Winamp.Title;

      if ShowSpectDot then
      begin
      // ------------------ narysuj kulke ---------------
      VisBMP.Canvas.Pen.Color := clRed;
      VisBMP.Canvas.Brush.Color := clYellow;
      VisBMP.Canvas.Brush.Style := bsSolid;

      VisBMP.Canvas.Ellipse(mx-2,my-2,mx+3,my+3);
      end;
      end;
  end; //VisMode = 1

//============================ ANALIZATOR LED ===================================



  if (VisMode = 2) then
  begin

     if (Winamp.Status = 'odtwarzanie') and (LedTop <> 18) then
     begin
       LedTop := 18;
       WinampTitleOld := #243+#210;
     end;

     if (Winamp.Status <> 'odtwarzanie') and (LedTop <> 11) then
     begin
       LedTop := 11;
       WinampTitleOld := #243+#210;

     end;

    if (SpectLedImgLoaded = False) or (WinampTitleOld <> Winamp.Title) then
    begin
      VisBMP.Canvas.Draw(-ImgVis.Left,-ImgVis.Top,ImgTlo12.Picture.Graphic);
      CzasPrzerwy := CzasPrzerwy - 2;
      //tytul utworu z winampa
      if Winamp.AssociatedTitle then VisBMP.Canvas.Font.Color := clWhite else
        VisBMP.Canvas.Font.Color := clGray;
      VisBMP.Canvas.Brush.Style := bsClear;
      if (Winamp.Status = 'odtwarzanie') and (EnableWinampTitle) then
        VisBMP.Canvas.TextOut(2, 2, Winamp.Title);
      WinampTitleOld := Winamp.Title;

      SpectLedImgLoaded := True;
      VisBMP.Canvas.Brush.Color := clblack;
      VisBMP.Canvas.Pen.Color := clBlack;
      for m := 0 to LedCountX-1 do // poziom
        for n := 0 to LedCountY-1 do
        begin
        if n > 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedRx.Picture.Bitmap);
        if n = 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedYx.Picture.Bitmap);
         if n < 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedGx.Picture.Bitmap);
         Led[m].Active[n] := False;
        end; //m,n
    end;

    for m := 0 to LedCountX-1 do // poziom
    for n := 0 to LedCountY-1 do
    begin
      if LED[m].Level >= n then if Led[m].Active[n] = False then
      begin //jasne
        if n > 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedR.Picture.Bitmap);
        if n = 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedY.Picture.Bitmap);
        if n < 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedG.Picture.Bitmap);
        Led[m].Active[n] := True;
      end;
      if LED[m].Level < n then if Led[m].Active[n] = True then
      begin
        if n > 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedRx.Picture.Bitmap);
        if n = 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedYx.Picture.Bitmap);
         if n < 10 then
          VisBMP.Canvas.Draw(4+m*15,LedTop+(LedCountY-n-1)*8,ImgLedGx.Picture.Bitmap);
         Led[m].Active[n] := False;
      end; //m,n
    end;




  end; //VisMode = 2




    if CzasPrzerwy < 0 then CzasPrzerwy := 0;
  if CzasPrzerwy > 1000 then CzasPrzerwy := 1000;


  //ImgVis.Picture.Bitmap := VisBMP;

   if ((AudioInMaxLvSr > 32760) and (not WykrzyknikVisible)) or
      ((AudioInMaxLvSr > 29500) and (WykrzyknikVisible)) then
      begin
       VisBMP.Canvas.Draw(ImgVis.Width - 23, 3, ImgWykrzyknik.Picture.Bitmap);
       WykrzyknikVisible := True;
      end else WykrzyknikVisible := False;



    FormStats.Gauge2.Progress := Round(AudioInMaxLvSr);
    formstats.Label10.Caption := 'AudioInMaxLvSr = ' + currtostr(AudioInMaxLvSr);
   ImgVis.Canvas.Draw(0, 0, VisBMP);

  DrawBusy := False;
 except
   DrawBusy := False;
 end;

end;
//==============================================================================
procedure TMainForm.TimerSkinTimer(Sender: TObject);
  var P: TPoint;
      n: Integer;
      b: Boolean;
begin
  GetCursorPos(P);
  P.X := P.X - Self.Left;
  P.Y := P.Y - Self.Top;

  for n := 1 to 10 do
  begin
    if (P.X > Przyciski[n].Img.Left) and (P.X < Przyciski[n].Img.Left +
    Przyciski[n].Img.Width) and (P.Y > Przyciski[n].Img.Top) and (P.Y < Przyciski[n].Img.Top +
    Przyciski[n].Img.Height) then b := True else b := False;

    if (b = True) and (Przyciski[n].Active = False) then
    begin
      Przyciski[n].Img.Canvas.Draw(-Przyciski[n].Img.Left,
        -Przyciski[n].Img.Top, ImgTlo24.Picture.Graphic);
      Przyciski[n].Active := True;
    end;

    if (b = False) and (Przyciski[n].Active = True) then
    begin
      Przyciski[n].Img.Canvas.Draw(-Przyciski[n].Img.Left,
        -Przyciski[n].Img.Top, ImgTlo12.Picture.Graphic);
      Przyciski[n].Active := False;
      MDMove := False;
    end;

  end; //for n := 1 to 10 do

end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ZamykanieProgramu := True;
  AudioIn.StopAtOnce;
  AudioOut.StopAtOnce;
  GenTimerThread.Terminate;
  Application.ProcessMessages;
  Sleep(10);

  FFT.Free;
  Dispose(FFTpfltIn);
  Dispose(FFTpfltOut);
  if LbProfile.Font.Color = clWhite then  ZapiszUstawienia;
end;

procedure TMainForm.ImgMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=MbLeft then  MDMove:=True; PMove:=Point(X, Y);
end;

procedure TMainForm.ImgMainMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  CursorFFTfreq := '';
  if MDMove then begin Left:=Left+(X-PMove.X); Top:=Top+(Y-PMove.Y);end;
end;

procedure TMainForm.ImgMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MDMove := False;
end;

procedure TMainForm.ButtonClick(Sender: TObject);
begin
  if Sender = BtMinimize then Application.Minimize;
  if Sender = BtClose then Self.Close;
  if Sender = BtVis then
  begin
    inc(VisMode);
    if VisMode > 2 then VisMode := 0;
  end;
  if Sender = BtSettings then FormSettings.Visible := not FormSettings.Visible;
  if Sender = BtAbout then FormStats.Visible := not FormStats.Visible;
  if Sender = BtSound then FormMixer.Visible := not FormMixer.Visible;
  if Sender = BtSpeaker then FormAudioSettings.Visible := not FormAudioSettings.Visible;
end;

procedure TMainForm.LadujDomyslneUstawienia;
  var n: Integer;
begin
  for n := 1 to 24 do
  begin
    Kanal[n].Caption := IntToStr(n);
    Kanal[n].Mode := 2;
    Kanal[n].OutChannel := n;
    Kanal[n].OutPower := 255;
    Kanal[n].MajorPWM := True;
    Kanal[n].Audio.SchmitMin := 40;
    Kanal[n].Audio.SchmitMax := 60;
    Kanal[n].Audio.PulseTime := 100;
    Kanal[n].Audio.PulseBreak := 150;
    Kanal[n].Audio.RefPoint := 0;
    Kanal[n].Audio.Analyze := 0;
    Kanal[n].Audio.Amplify := 50;
    Kanal[n].Audio.Delay := 10;

    Kanal[n].Gen.FreqMin := 10+Random(150);
    Kanal[n].Gen.FreqMax := Kanal[n].Gen.FreqMin + Random(5000);
    Kanal[n].Gen.FreqChangeStep := 10 + Random(50);
    Kanal[n].Gen.Shape := 100;
    Kanal[n].Gen.Duty := Random(50);

    Kanal[n].xRandom.FreqMin := 1 + Random(20);
    Kanal[n].xRandom.FreqMax := Kanal[n].xRandom.FreqMin + Random(80);
    Kanal[n].xRandom.mAudio := True;
    Kanal[n].xRandom.mGen := True;
    Kanal[n].xRandom.mOn := True;
    Kanal[n].xRandom.mOff := True;
  end;


  Led[0].FreqMin := 20;    Led[0].FreqMax := 63;
  Led[1].FreqMin := 64;    Led[1].FreqMax := 89;
  Led[2].FreqMin := 90;    Led[2].FreqMax := 129;
  Led[3].FreqMin := 130;    Led[3].FreqMax := 179;
  Led[4].FreqMin := 180;    Led[4].FreqMax := 299;
  Led[5].FreqMin := 300;    Led[5].FreqMax := 499;
  Led[6].FreqMin := 500;    Led[6].FreqMax := 799;
  Led[7].FreqMin := 801;    Led[7].FreqMax := 1299;
  Led[8].FreqMin := 1300;    Led[8].FreqMax := 2199;
  Led[9].FreqMin := 2200;    Led[9].FreqMax := 3499;
  Led[10].FreqMin := 3500;    Led[10].FreqMax := 6999;
  Led[11].FreqMin := 7000;    Led[11].FreqMax := 9399;
  Led[12].FreqMin := 9400;    Led[12].FreqMax := 12499;
  Led[13].FreqMin := 12500;    Led[13].FreqMax := 15299;
  Led[14].FreqMin := 15300;    Led[14].FreqMax := 18000;

  for n := 0 to ledCountX-1 do
  begin
    Led[n].SmpMin := Round((Led[n].FreqMin / (AudioIn.FrameRate/2)) * (BuffSize) -1);
    Led[n].SmpMax := Round((Led[n].FreqMax / (AudioIn.FrameRate/2)) * (BuffSize) -1);
  end;

  Kanal[1].Panel := PnChannel_01;   Kanal[2].Panel := PnChannel_02;
  Kanal[3].Panel := PnChannel_03;   Kanal[4].Panel := PnChannel_04;
  Kanal[5].Panel := PnChannel_05;   Kanal[6].Panel := PnChannel_06;
  Kanal[7].Panel := PnChannel_07;   Kanal[8].Panel := PnChannel_08;
  Kanal[9].Panel := PnChannel_09;   Kanal[10].Panel := PnChannel_10;
  Kanal[11].Panel := PnChannel_11;  Kanal[12].Panel := PnChannel_12;
  Kanal[13].Panel := PnChannel_13;  Kanal[14].Panel := PnChannel_14;
  Kanal[15].Panel := PnChannel_15;  Kanal[16].Panel := PnChannel_16;
  Kanal[17].Panel := PnChannel_17;  Kanal[18].Panel := PnChannel_18;
  Kanal[19].Panel := PnChannel_19;  Kanal[20].Panel := PnChannel_20;
  Kanal[21].Panel := PnChannel_21;  Kanal[22].Panel := PnChannel_22;
  Kanal[23].Panel := PnChannel_23;  Kanal[24].Panel := PnChannel_24;

  Kanal[1].ColorDark := clMaroon;   Kanal[1].ColorLight := clRed;
  Kanal[2].ColorDark := clGreen;    Kanal[2].ColorLight := clLime;
  Kanal[3].ColorDark := clOlive;    Kanal[3].ColorLight := clYellow;
  Kanal[4].ColorDark := clNavy;     Kanal[4].ColorLight := clBlue;
  Kanal[5].ColorDark := clPurple;   Kanal[5].ColorLight := clFuchsia;
  Kanal[6].ColorDark := clBlack;    Kanal[6].ColorLight := clGray;
  Kanal[7].ColorDark := clTeal;     Kanal[7].ColorLight := clAqua;
  Kanal[8].ColorDark := clSilver;   Kanal[8].ColorLight := clWhite;
  Kanal[9].ColorDark := clMaroon;   Kanal[9].ColorLight := clRed;
  Kanal[10].ColorDark := clGreen;   Kanal[10].ColorLight := clLime;
  Kanal[11].ColorDark := clOlive;   Kanal[11].ColorLight := clYellow;
  Kanal[12].ColorDark := clNavy;    Kanal[12].ColorLight := clBlue;
  Kanal[13].ColorDark := clPurple;  Kanal[13].ColorLight := clFuchsia;
  Kanal[14].ColorDark := clBlack;   Kanal[14].ColorLight := clGray;
  Kanal[15].ColorDark := clTeal;    Kanal[15].ColorLight := clAqua;
  Kanal[16].ColorDark := clSilver;  Kanal[16].ColorLight := clWhite;
  Kanal[17].ColorDark := clMaroon;  Kanal[17].ColorLight := clRed;
  Kanal[18].ColorDark := clGreen;   Kanal[18].ColorLight := clLime;
  Kanal[19].ColorDark := clOlive;   Kanal[19].ColorLight := clYellow;
  Kanal[20].ColorDark := clNavy;    Kanal[20].ColorLight := clBlue;
  Kanal[21].ColorDark := clPurple;  Kanal[21].ColorLight := clFuchsia;
  Kanal[22].ColorDark := clBlack;   Kanal[22].ColorLight := clGray;
  Kanal[23].ColorDark := clTeal;    Kanal[23].ColorLight := clAqua;
  Kanal[24].ColorDark := clSilver;  Kanal[24].ColorLight := clWhite;

  Kanal[1].Audio.FreqMin := 40;      Kanal[1].Audio.FreqMax := 90;
  Kanal[2].Audio.FreqMin := 101;      Kanal[2].Audio.FreqMax := 230;
  Kanal[3].Audio.FreqMin := 231;     Kanal[3].Audio.FreqMax := 500;
  Kanal[4].Audio.FreqMin := 501;     Kanal[4].Audio.FreqMax := 1300;
  Kanal[5].Audio.FreqMin := 1301;    Kanal[5].Audio.FreqMax := 3300;
  Kanal[6].Audio.FreqMin := 3301;    Kanal[6].Audio.FreqMax := 6600;
  Kanal[7].Audio.FreqMin := 6601;    Kanal[7].Audio.FreqMax := 12000;
  Kanal[8].Audio.FreqMin := 12001;   Kanal[8].Audio.FreqMax := 16000;
  Kanal[9].Audio.FreqMin := 20;      Kanal[9].Audio.FreqMax := 50;
  Kanal[10].Audio.FreqMin := 51;     Kanal[10].Audio.FreqMax := 200;
  Kanal[11].Audio.FreqMin := 201;    Kanal[11].Audio.FreqMax := 500;
  Kanal[12].Audio.FreqMin := 501;    Kanal[12].Audio.FreqMax := 1300;
  Kanal[13].Audio.FreqMin := 1301;   Kanal[13].Audio.FreqMax := 3300;
  Kanal[14].Audio.FreqMin := 3301;   Kanal[14].Audio.FreqMax := 6600;
  Kanal[15].Audio.FreqMin := 6601;   Kanal[15].Audio.FreqMax := 12000;
  Kanal[16].Audio.FreqMin := 12001;  Kanal[16].Audio.FreqMax := 16000;
  Kanal[17].Audio.FreqMin := 20;     Kanal[17].Audio.FreqMax := 50;
  Kanal[18].Audio.FreqMin := 51;     Kanal[18].Audio.FreqMax := 200;
  Kanal[19].Audio.FreqMin := 201;    Kanal[19].Audio.FreqMax := 500;
  Kanal[20].Audio.FreqMin := 501;    Kanal[20].Audio.FreqMax := 1300;
  Kanal[21].Audio.FreqMin := 1301;   Kanal[21].Audio.FreqMax := 3300;
  Kanal[22].Audio.FreqMin := 3301;   Kanal[22].Audio.FreqMax := 6600;
  Kanal[23].Audio.FreqMin := 6601;   Kanal[23].Audio.FreqMax := 12000;
  Kanal[24].Audio.FreqMin := 12001;  Kanal[24].Audio.FreqMax := 16000;

  for n := 1 to 24 do
  begin
    Kanal[n].Audio.SmplMin := Round((Kanal[n].Audio.FreqMin /
      (AudioIn.FrameRate/2)) * (BuffSize) -1);
    Kanal[n].Audio.SmplMax := Round((Kanal[n].Audio.FreqMax /
      (AudioIn.FrameRate/2)) * (BuffSize) -1);
  end;

end;

procedure TMainForm.ImgMainDblClick(Sender: TObject);
// var m: Integer;
  //  s: String;
begin
  {s := Inttostr(buffsize)+#13;
   for m := 1 to 24 do
     s := s + IntTostr(m) + ': ' + IntToStr(kanal[m].Audio.SmplMin) + ' - ' +
      IntToStr(kanal[m].Audio.SmplMax) +#13;


    { s := s + IntTostr(m) + ': ' + IntToStr(led[m].SmpMin) + ' - ' +
      IntToStr(led[m].SmpMax) +#13; }

   //  ShowMessage(s);
     self.Close;
end;

procedure TMainForm.ButtonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if Sender = BtPause then Pause := not Pause;
end;




//==============================================================================
procedure TMainForm.Przeladuj;
  var n: Integer;
begin
  for n := 1 to 24 do Kanal[n].Panel.Visible := False;
  //---------------------------- 5 --------------------------------
  if ChannCount = 5 then
  begin
    ImgMain.Picture.Graphic := ImgTlo05.Picture.Graphic;
    LbProfile.Top := 271;
    ImgWinamp.Top := 265;
    for n := 1 to 5 do
    begin
      Kanal[n].Panel.Visible := True;
      Kanal[n].Panel.Top := 209;    Kanal[n].Panel.Width := 45;
      Kanal[n].Panel.Height := 45;
    end;
    Kanal[1].Panel.Left := 24;   Kanal[2].Panel.Left := 94;
    Kanal[3].Panel.Left := 164;  Kanal[4].Panel.Left := 234;
    Kanal[5].Panel.Left := 304;
  end; //ChannCount = 5
  //---------------------------- 12 --------------------------------
  if ChannCount = 12 then
  begin
    ImgMain.Picture.Graphic := ImgTlo12.Picture.Graphic;
    LbProfile.Top := 330;
    ImgWinamp.Top := 324;
    for n := 1 to 12 do
    begin
      Kanal[n].Panel.Visible := True;
      Kanal[n].Panel.Width := 45;
      Kanal[n].Panel.Height := 45;
    end;
    Kanal[1].Panel.Left := 15;    Kanal[2].Panel.Left := 75;
    Kanal[3].Panel.Left := 135;   Kanal[4].Panel.Left := 194;
    Kanal[5].Panel.Left := 254;   Kanal[6].Panel.Left := 314;

    for n := 1 to 6 do
    begin
      Kanal[n].Panel.Top := 209;
      Kanal[n+6].Panel.Top := 267;
      Kanal[n+6].Panel.Left := Kanal[n].Panel.Left;
    end;

  end; //ChannCount = 12
  //---------------------------- 24 --------------------------------
  if ChannCount = 24 then
  begin
    ImgMain.Picture.Graphic := ImgTlo24.Picture.Graphic;
    LbProfile.Top := 350;
    ImgWinamp.Top := 344;
    for n := 1 to 24 do
    begin
      Kanal[n].Panel.Visible := True;
      Kanal[n].Panel.Width := 33;
      Kanal[n].Panel.Height := 33;
    end;
    Kanal[1].Panel.Left := 14;    Kanal[2].Panel.Left := 59;
    Kanal[3].Panel.Left := 103;   Kanal[4].Panel.Left := 148;
    Kanal[5].Panel.Left := 192;   Kanal[6].Panel.Left := 237;
    Kanal[7].Panel.Left := 281;   Kanal[8].Panel.Left := 326;

    for n := 1 to 8 do
    begin
      Kanal[n].Panel.Top := 209;
      Kanal[n+8].Panel.Top := 255;
      Kanal[n+16].Panel.Top := 300;
      Kanal[n+8].Panel.Left := Kanal[n].Panel.Left;
      Kanal[n+16].Panel.Left := Kanal[n].Panel.Left;
    end;

  end; //ChannCount = 244


  for n := 1 to 10 do
  begin
        Przyciski[n].Img.Canvas.Draw(-Przyciski[n].Img.Left,
        -Przyciski[n].Img.Top, ImgTlo12.Picture.Graphic);
      Przyciski[n].Active := False;
  end;

  Self.Width := ImgMain.Width;
  Self.Height := ImgMain.Height;

end;
//==============================================================================
procedure TMainForm.MenuItemClick(Sender: TObject);
begin
  if Sender = mMode5 then ChannCount := 5;
  if Sender = mMode12 then ChannCount := 12;
  if Sender = mMode24 then ChannCount := 24;
  if (Sender = mMode5) or (Sender = mMode12) or (Sender = mMode24) then Przeladuj;
end;
//==============================================================================
procedure TMainForm.BtSettingsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TimerSkinTimer(Self);
  TimerSkin.Enabled := True;
end;
//==============================================================================
function TMainForm.Kolor(Col1, Col2: TColor; Max, Pos: Integer): TColor;
   var R,G,B: Byte;
begin
  if Pos < 0 then Pos := 0;
  if Pos > max then Pos := max;
  R := Round(GetRValue(Col1) + (GetRValue(Col2)-GetRValue(Col1))*(Pos/Max));
  G := Round(GetGValue(Col1) + (GetGValue(Col2)-GetGValue(Col1))*(Pos/Max));
  B := Round(GetBValue(Col1) + (GetBValue(Col2)-GetBValue(Col1))*(Pos/Max));
  Result := RGB(R,G,B);
end;
//==============================================================================
procedure TMainForm.PnChannel_24DblClick(Sender: TObject);
begin
  UnitChannel.ChNr := StrToInt(Copy(TPanel(Sender).Name, 11, 2));
  FormChannel.Caption := 'Lumicom, Kana³ ' + IntToStr(UnitChannel.ChNr);
  FormChannel.Odswiez;
  FormChannel.Show;
end;
//==============================================================================
procedure TMainForm.ZapiszUstawienia;
  function BoolToStr(b: Boolean): ShortString;
  begin if b = True then Result := 'True' else Result := 'False'; end;
  function BoolToChr(b: Boolean): Char;
  begin if b = True then Result := '1' else Result := '0'; end;

  var s: TStrings;
      n: Integer;
begin
  s := TStringList.Create;
  s.Add('==== Lumicom config file ====');
  s.Add('');
  s.Add('[Main]');
  s.Add(' ChannCnt' + #9 + ' = ' + IntToStr(ChannCount));
  s.Add(' MainPos' + #9 + ' = ' + IntToStr(MainForm.Left) + ',' +
    IntToStr(MainForm.Top));
  s.Add(' ChanPos' + #9 + ' = ' + IntToStr(FormChannel.Left) + ',' +
    IntToStr(FormChannel.Top));
  s.Add(' StatsPos' + #9 + ' = ' + IntToStr(FormStats.Left) + ',' +
    IntToStr(FormStats.Top));
  s.Add(' SettPos' + #9 + ' = ' + IntToStr(FormSettings.Left) + ',' +
    IntToStr(FormSettings.Top));
  s.Add(' MixPos' + #9 + #9 + ' = ' + IntToStr(FormMixer.Left) + ',' +
    IntToStr(FormMixer.Top));
  s.Add(' AsetPos' + #9 + ' = ' + IntToStr(FormAudioSettings.Left) + ',' +
    IntToStr(FormAudioSettings.Top));
  s.Add(' AboutPos' + #9 + ' = ' + IntToStr(FormAbout.Left) + ',' +
    IntToStr(FormAbout.Top));
  s.Add(' GenPos' + #9 + #9 + ' = ' + IntToStr(FormSineGenerator.Left) + ',' +
    IntToStr(FormSineGenerator.Top));
  s.Add(' GenSize' + #9 + ' = ' + IntToStr(FormSineGenerator.Width) + ',' +
    IntToStr(FormSineGenerator.Height));
  if FormSettings.CbScardRmb.Checked then
  begin
    s.Add(' sCard' + #9 + #9 + ' = ' + FormMixer.CbScard.Text);
    s.Add(' sSource' + #9 + ' = ' + FormMixer.CbSource.Text);
    s.Add(' sVolume' + #9 + ' = ' + IntToStr(FormMixer.TbVol.Position));
  end;
  s.Add(' SinGenFreq' + #9 + ' = ' + IntToStr(FormSineGenerator.TbFreq.Position));
  s.Add(' SinGenVol' + #9 + ' = ' + IntToStr(FormSineGenerator.TbVol.Position));
  s.Add(' Amplify'  + #9 + ' = ' + IntToStr(TbAmplify.Position));
  s.Add(' Delay'  + #9 + #9 + ' = ' + IntToStr(TbDelay.Position));
  s.Add(' Duty'  + #9 + #9 + ' = ' + IntToStr(TbDuty.Position));

  s.Add(' AlphaBlend'  + #9 + ' = ' + BoolToStr(FormSettings.CbAlphaBlend.Checked));
  s.Add(' AlphaBlendVal'  + #9 + ' = ' + IntToStr(FormSettings.TbAlphaBlendLevel.Position));
  s.Add(' StayOnTop'  + #9 + ' = ' + BoolToStr(FormSettings.CbStayOnTop.Checked));
  s.Add(' AutoVol'  + #9 + ' = ' + BoolToStr(FormSettings.CbAutoVol.Checked));
  s.Add(' PnDarkLev' + #9 + ' = ' + IntToStr(FormSettings.TbDarkLevel.Position));
  s.Add(' VisMode' + #9 + ' = ' + IntToStr(VisMode));
  s.Add(' SpecDot' + #9 + ' = ' + BoolToStr(ShowSpectDot));
  s.Add(' Profile' + #9 + ' = ' + LbProfile.Caption);

  for n := 1 to 24 do
  begin
    s.Add('');
    s.Add('[Channel ' + IntToStr(n) + ']');
    s.Add(' Caption'  + #9 + ' = ' + Kanal[n].Caption);
    s.Add(' Mode'  + #9 + #9 + ' = ' + IntToStr(Kanal[n].Mode));
    s.Add(' Color'  + #9 + #9 + ' = ' + IntToStr(GetRvalue(Kanal[n].ColorLight))
     +','+IntToStr(GetGvalue(Kanal[n].ColorLight))+','+
       IntToStr(GetBvalue(Kanal[n].ColorLight)));
    s.Add(' PWM'  + #9 + #9 + ' = ' + BoolToStr(Kanal[n].MajorPWM));
    s.Add(' Negative'  + #9 + ' = ' + BoolToStr(Kanal[n].Negative));
    s.Add(' Strob'  + #9 + #9 + ' = ' + BoolToStr(Kanal[n].StrobMode));
    s.Add(' OutChan'  + #9 + ' = ' + IntToStr(Kanal[n].OutChannel));
    s.Add(' Power'  + #9 + #9 + ' = ' + IntToStr(Kanal[n].OutPower));

    s.Add(' aFreq'  + #9 + #9 + ' = ' + IntToStr(Kanal[n].Audio.FreqMin) + ',' +
      IntToStr(Kanal[n].Audio.FreqMax));
    s.Add(' aPulseT'  + #9 + ' = ' + IntToStr(Kanal[n].Audio.PulseTime) +
      ',' + IntToStr(Kanal[n].Audio.PulseBreak));
    s.Add(' aTreshold'  + #9 + ' = ' + IntToStr(Kanal[n].Audio.SchmitMin) +
      ',' + IntToStr(Kanal[n].Audio.SchmitMax));
    s.Add(' aAnalyze' + #9 + ' = ' + IntToStr(Kanal[n].Audio.Analyze) + ',' +
      IntToStr(Kanal[n].Audio.RefPoint));
    s.Add(' aPwm'  + #9 + #9 + ' = ' + BoolToStr(Kanal[n].Audio.PWM));
    s.Add(' aPulse'  + #9 + #9 + ' = ' + BoolToStr(Kanal[n].Audio.Pulse));
    s.Add(' aDiff'  + #9 + #9 + ' = ' + BoolToStr(Kanal[n].Audio.DiffMode));
    s.Add(' aAmplify'  + #9 + ' = ' + IntToStr(Kanal[n].Audio.Amplify));
    s.Add(' aDelay'  + #9 + #9 + ' = ' + IntToStr(Kanal[n].Audio.Delay));

    s.Add(' rFreq'  + #9 + #9 + ' = ' + IntToStr(Kanal[n].xRandom.FreqMin) +
      ',' + IntToStr(Kanal[n].xRandom.FreqMax));
    s.Add(' rModes' + #9 + #9 + ' = ' + BoolToChr(Kanal[n].xRandom.mAudio) + ',' +
      BoolToChr(Kanal[n].xRandom.mGen) + ',' + BoolToChr(Kanal[n].xRandom.mOn)
        + ',' + BoolToChr(Kanal[n].xRandom.mOff));
    s.Add(' gFreq'  + #9 + #9 + ' = ' + IntToStr(Kanal[n].Gen.FreqMin) +
      ',' + IntToStr(Kanal[n].Gen.FreqMax));
    s.Add(' gShapeMode' + #9 + ' = ' + IntToStr(Kanal[n].Gen.ShapeUp) + ',' +
      IntToStr(Kanal[n].Gen.ShapeDown));
    s.Add(' gStyle' + #9 + #9 + ' = ' + IntToStr(Kanal[n].Gen.Style));
    s.Add(' gFreqChng' + #9 + ' = ' + IntToStr(Kanal[n].Gen.FreqChangeStep));
    s.Add(' gDuty' + #9 + #9 + ' = ' + IntToStr(Kanal[n].Gen.Duty));
    s.Add(' gShapeVal' + #9 + ' = ' + IntToStr(Kanal[n].Gen.Shape));
    s.Add(' gNegative' + #9 + ' = ' + BoolToStr(Kanal[n].Gen.Negative));
  end;

  s.SaveToFile(ExtractFilePath(Application.ExeName) + 'settings.ini');
  s.Free;

end;
//==============================================================================
procedure TMainForm.WczytajUstawienia;
  var n: Integer;
      e: String;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'settings.ini') then
  begin
    UnitProfiles.ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'settings.ini');
     with FormProfiles do try
       if OdczytajInteger('Main','ChannCnt',1,5,24) then
         ChannCount := Tbl[0];
       if OdczytajInteger('Main','MainPos',2,-1000,2000) then begin
         MainForm.Left := Tbl[0]; MainForm.Top := Tbl[1]; end;
       if OdczytajInteger('Main','ChanPos',2,-1000,2000) then begin
         FormChannel.Left := Tbl[0]; FormChannel.Top := Tbl[1]; end;
       if OdczytajInteger('Main','StatsPos',2,-1000,2000) then begin
         FormStats.Left := Tbl[0]; FormStats.Top := Tbl[1]; end;
       if OdczytajInteger('Main','SettPos',2,-1000,2000) then begin
         FormSettings.Left := Tbl[0]; FormSettings.Top := Tbl[1]; end;
       if OdczytajInteger('Main','MixPos',2,-1000,2000) then begin
         FormMixer.Left := Tbl[0]; FormMixer.Top := Tbl[1]; end;
       if OdczytajInteger('Main','AsetPos',2,-1000,2000) then begin
         FormAudioSettings.Left := Tbl[0]; FormAudioSettings.Top := Tbl[1]; end;
       if OdczytajInteger('Main','AboutPos',2,-1000,2000) then begin
         FormAbout.Left := Tbl[0]; FormAbout.Top := Tbl[1]; end;
       if OdczytajInteger('Main','GenPos',2,-1000,2000) then begin
         FormSineGenerator.Left := Tbl[0]; FormSineGenerator.Top := Tbl[1]; end;
       if OdczytajInteger('Main','GenSize',2,10,2200) then begin
         FormSineGenerator.Width := Tbl[0]; FormSineGenerator.Height := Tbl[1]; end;
       if OdczytajInteger('Main','Amplify',1,TbAmplify.Min,TbAmplify.Max) then
         TbAmplify.Position := Tbl[0];
       if OdczytajInteger('Main','Delay',1,1,30) then
         TbDelay.Position := Tbl[0];
       if OdczytajInteger('Main','Duty',1,20,98) then
         TbDuty.Position := Tbl[0];
       if ini.ValueExists('Main', 'sCard') then
       begin
         FormSettings.CbScardRmb.Checked := True;
         DefsCard := ini.ReadString('Main','sCard','');
         DefsSource := ini.ReadString('Main','sSource','');
         DefsVolume := ini.ReadInteger('Main','sVolume',-1);
       end;
       if OdczytajInteger('Main','SinGenFreq',1,
         FormSineGenerator.TbFreq.Min,FormSineGenerator.TbFreq.Max) then
         FormSineGenerator.TbFreq.Position := Tbl[0];
       if OdczytajInteger('Main','SinGenVol',1,0,100) then
         FormSineGenerator.TbVol.Position := Tbl[0];
       if OdczytajBoolean('Main','AlphaBlend',1) then
         FormSettings.CbAlphaBlend.Checked := IntToBool(Tbl[0]);
       if OdczytajInteger('Main','AlphaBlendVal',1,20,255) then
         FormSettings.TbAlphaBlendLevel.Position := Tbl[0];
       if OdczytajBoolean('Main','StayOnTop',1) then
         FormSettings.CbStayOnTop.Checked := IntToBool(Tbl[0]);
       if OdczytajBoolean('Main','AutoVol',1) then
         FormSettings.CbAutoVol.Checked := IntToBool(Tbl[0]);
       if OdczytajInteger('Main','PnDarkLev',1,20,100) then
         FormSettings.TbDarkLevel.Position := Tbl[0];
       if OdczytajInteger('Main','VisMode',1,0,2) then
         VisMode := Tbl[0];
       if OdczytajBoolean('Main','SpecDot',1) then
         ShowSpectDot := IntToBool(Tbl[0]);
       if OdczytajString('Main','Profile',1) then
         LbProfile.Caption := Str[0];

       if Trim(LbProfile.Caption) = '' then LbProfile.Caption := '[domyœlny]';

      MainForm.LbProfile.Left :=
      MainForm.ImgMain.Width div 2 - MainForm.LbProfile.Width div 2;


      for n := 1 to 24 do
      begin
        e := 'Channel ' + IntToStr(n);
        if OdczytajString(e, 'Caption', 1) then begin
          Kanal[n].Caption := str[0]; Kanal[n].Panel.Caption := str[0]; end;
         if OdczytajInteger(e, 'Mode', 1, 0, 4) then
           Kanal[n].Mode := Tbl[0];
        if OdczytajInteger(e, 'Color', 3, 0, 255) then
          Kanal[n].ColorLight := RGB(Tbl[0], Tbl[1], Tbl[2]);
        if OdczytajBoolean(e, 'PWM', 1) then
          Kanal[n].MajorPWM := IntToBool(Tbl[0]);
        if OdczytajBoolean(e, 'Negative', 1) then
          Kanal[n].Negative := IntToBool(Tbl[0]);
        if OdczytajBoolean(e, 'Strob', 1) then
          Kanal[n].StrobMode := IntToBool(Tbl[0]);

        if OdczytajInteger(e, 'OutChan', 1, 1, 24) then
          Kanal[n].OutChannel := Tbl[0];
        if OdczytajInteger(e, 'Power', 1, 0, 255) then
          Kanal[n].OutPower := Tbl[0];
        if OdczytajInteger(e, 'aFreq', 2, 20, 20000) then begin
          Kanal[n].Audio.FreqMin := Tbl[0]; Kanal[n].Audio.FreqMax := Tbl[1]; end;
        if OdczytajInteger(e, 'aPulseT', 2, 1, 5000) then begin
          Kanal[n].Audio.PulseTime := Tbl[0]; Kanal[n].Audio.PulseBreak := Tbl[1]; end;
        if OdczytajInteger(e, 'aTreshold', 2, 0, 100) then begin
          Kanal[n].Audio.SchmitMin := Tbl[0]; Kanal[n].Audio.SchmitMax := Tbl[1]; end;
        if OdczytajInteger(e, 'aAnalyze', 1, 0, 3) then
          Kanal[n].Audio.RefPoint := Tbl[0];

        if OdczytajBoolean(e, 'aPwm', 1) then
          Kanal[n].Audio.PWM := IntToBool(Tbl[0]);
        if OdczytajBoolean(e, 'aPulse', 1) then
          Kanal[n].Audio.Pulse := IntToBool(Tbl[0]);
        if OdczytajBoolean(e, 'aDiff', 1) then
          Kanal[n].Audio.DiffMode := IntToBool(Tbl[0]);
        if OdczytajInteger(e, 'aAmplify', 1, 0, 150) then
          Kanal[n].Audio.Amplify := Tbl[0];
        if OdczytajInteger(e, 'aDelay', 1, 0, 150) then
          Kanal[n].Audio.Delay := Tbl[0];

        if OdczytajInteger(e, 'rFreq', 2, 1, 600) then begin
          Kanal[n].xRandom.FreqMin := Tbl[0]; Kanal[n].xRandom.FreqMax := Tbl[1]; end;

        if OdczytajBoolean(e, 'rModes', 4) then begin
          Kanal[n].xRandom.mAudio := IntToBool(Tbl[0]);
          Kanal[n].xRandom.mGen := IntToBool(Tbl[1]);
          Kanal[n].xRandom.mOn := IntToBool(Tbl[2]);
          Kanal[n].xRandom.mOff := IntToBool(Tbl[3]); end;

        if OdczytajInteger(e, 'gFreq', 2, 1, 10000) then begin
          Kanal[n].Gen.FreqMin := Tbl[0]; Kanal[n].Gen.FreqMax := Tbl[1]; end;

        if OdczytajInteger(e, 'gShapeMode', 2, 0, 4) then
        begin Kanal[n].Gen.ShapeUp := Tbl[0]; Kanal[n].Gen.ShapeDown := Tbl[1]; end;
        if OdczytajInteger(e, 'gStyle', 1, 0, FormChannel.CbGenStyle.Items.Count-1) then
          Kanal[n].Gen.Style := Tbl[0];

        if OdczytajInteger(e, 'gFreqChng', 1, 0, 100) then
          Kanal[n].Gen.FreqChangeStep := Tbl[0];
        if OdczytajInteger(e, 'gDuty', 1, 0, 99) then
          Kanal[n].Gen.Duty := Tbl[0];
        if OdczytajInteger(e, 'gShapeVal', 1, 2, 198) then
          Kanal[n].Gen.Shape := Tbl[0];
         if OdczytajBoolean(e, 'gNegative', 1) then begin
          Kanal[n].Gen.Negative := IntToBool(Tbl[0]); end;

      end; // for n := 1 to 24

     finally
       ini.Free;
     end;
  end else // FileExists
    MessageBox(0, PChar('Brak pliku "settings.ini"' + #13 +
      'Program zostanie uruchomiony z domyœlnymi ustawieniami'), PChar('B³¹d'), mb_IconError);

end;

procedure TMainForm.DarkColorLevel;
  var n, r, g, b: Byte;
begin
  for n := 1 to 24 do
  begin
    r := GetRvalue(Kanal[n].ColorLight);
    g := GetGvalue(Kanal[n].ColorLight);
    b := GetBvalue(Kanal[n].ColorLight);

    r := Round(r - (r*(DarkLevel/100)));
    g := Round(g - (g*(DarkLevel/100)));
    b := Round(b - (b*(DarkLevel/100)));

    Kanal[n].ColorDark := RGB(r,g,b);
  end;
end;

procedure TMainForm.ImgVisMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var o: Currency;
      j: ShortString;
begin
  j := 'Hz';
  o := 20 + (x/ImgVis.Width) * 20020;

  if o > 1000 then
  begin
    o := o / 1000;
    j := 'kHz';
  end;
  CursorFFTfreq := FormatFloat('0.00',o) + j;
end;

procedure TMainForm.ImgWinampClick(Sender: TObject);
begin
  FormWinamp.Visible := not FormWinamp.Visible;
 
end;

procedure TMainForm.Winap1Click(Sender: TObject);
begin
  FormWinamp.Show;
end;


procedure TMainForm.TimerFPSTimer(Sender: TObject);
begin
//  Label1.Caption := 'draw fps: ' + CurrToStr(DrawFPS/(TimerFPS.Interval/1000))
  //  + ', audio fps: ' + CurrToStr(AudioFPS/(TimerFPS.Interval/1000));
  DrawFPS := 0;
  AudioFPS := 0;
end;

procedure TMainForm.LbProfileDblClick(Sender: TObject);
begin
  FormProfiles.Visible := not FormProfiles.Visible;
end;

procedure TMainForm.LbProfileMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then MenuProfiles.Popup
    (Self.Left+LbProfile.Left+X, Self.Top++LbProfile.Top+Y);
  if Button = mbRIGHT then if not FormProfiles.Visible then
  begin
    FormProfiles.CbProfile.Text := MainForm.LbProfile.Caption;
    FormProfiles.Show;
  end else FormProfiles.Visible := False;
end;
//==============================================================================
procedure TMainForm.Zmknij1Click(Sender: TObject);
begin
  Close;
end;
//==============================================================================
procedure TMainForm.LoadWinampAssociations;
  var n: Integer;
      li: TListItem;
begin
 // if FileExists(ExtractFilePath(Application.ExeName) + 'associations.ini') then
  begin
    n := 0;
    UnitProfiles.ini := TIniFile.Create(ExtractFilePath(Application.ExeName) +
      'associations.ini');
    try
      WinampAlist[0] := TStringList.Create;
      WinampAlist[1] := TStringList.Create;
      ini.ReadSection('Main', WinampAlist[0]);
      for n := 0 to WinampAlist[0].Count - 1 do
        WinampAlist[1].Add(ini.ReadString('Main', WinampAlist[0].Strings[n],''));


    finally
    end;

  FormWinampAssociations.LvWinampAssociations.Clear;
  li := TListItem.Create(FormWinampAssociations.LvWinampAssociations.Items);
  for n := 0 to WinampAlist[0].Count-1 do
  begin
    li := FormWinampAssociations.LvWinampAssociations.Items.Add;
    li.Caption := WinampAlist[1].Strings[n];
    li.SubItems.Add(WinampAlist[0].Strings[n])


   // li.SubItems[0].Caption := 'dfg';
     // (WinampAlist[0].Strings[n] + ' - ' + );
  end;
  end;

end;

procedure TMainForm.Powiaz1Click(Sender: TObject);
begin
  FormWinampAssociations.BtAddClick(Sender);
 WinampTitleOld := '';
end;

procedure TMainForm.Pokazpowiazania1Click(Sender: TObject);
begin
   FormWinampAssociations.Visible := not FormWinampAssociations.Visible;
end;

procedure TMainForm.SprawdzPowiazania;
  var n: Integer;
      s: String;
begin
  Winamp.AssociatedTitle := False;
  for n := 0 to FormWinampAssociations.LvWinampAssociations.Items.Count-1 do
    if Winamp.Title = FormWinampAssociations.LvWinampAssociations.
      Items[n].SubItems.Strings[0] then
      begin
        Winamp.AssociatedTitle := True;
        Break;
      end;

  if Winamp.AssociatedTitle then
  begin
    ZapiszUstawienia;
    Application.ProcessMessages;
    Sleep(10);
    LbProfile.Font.Color := clAqua;
    s := FormWinampAssociations.LvWinampAssociations.Items[n].Caption;
    FormProfiles.LoadProfile(s);
    LbProfile.Caption := s;
    MainForm.LbProfile.Left :=
      MainForm.ImgMain.Width div 2 - MainForm.LbProfile.Width div 2;
  end else
  begin
    if LbProfile.Font.Color = clAqua then WczytajUstawienia;

    LbProfile.Font.Color := clWhite;


  end;

end;

end.
