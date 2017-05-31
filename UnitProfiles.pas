unit UnitProfiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, INIFiles;

type
  TFormProfiles = class(TForm)
    CbProfile: TComboBox;
    BtSave: TButton;
    BtDelete: TButton;
    procedure FindProfiles;
    procedure SaveProfile(pName: String);
    procedure LoadProfile(pName: String);
    procedure FormCreate(Sender: TObject);
    procedure MenuItmemClick(Sender: TObject);
    function IntToBool(val: Byte): Boolean;
    procedure SprawdzNazwe;
    function OdczytajString(a1, a2: String; vCount: Integer): Boolean;
    function OdczytajInteger(a1, a2: String; vCount, vMin, vMax: Integer): Boolean;
    function OdczytajBoolean(a1, a2: String; vCount: Integer): Boolean;
    procedure CbProfileKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtDeleteClick(Sender: TObject);
    procedure CbProfileChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TReadProfThread = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  FormProfiles: TFormProfiles;
  ReadProfThread: TReadProfThread;
  tbl: array of Integer;
  str: TStrings;
  ini: TINIFile;
  LoadProfName: String; //nazwa profilu do zalatowania tthread
implementation

uses UnitMainForm, UnitChannel, UnitMixerAudio, UnitStats, UnitSettings,
  UnitAudioSettings, UnitAbout, UnitSineGenerator;

{$R *.dfm}

{ TFormProfiles }
//==============================================================================
procedure TFormProfiles.MenuItmemClick(Sender: TObject);
  var i: Integer;
      s: String;
begin
  i := MainForm.MenuProfiles.Items.IndexOf(TMenuItem(Sender));
  s := TMenuItem(Sender).Caption;
  delete(s, pos('&',s), 1);
    MainForm.LbProfile.Caption := s;
    MainForm.LbProfile.Left :=
      MainForm.ImgMain.Width div 2 - MainForm.LbProfile.Width div 2;


  CbProfile.ItemIndex := i;
  if i + 1 > DefProfCount then
  begin
    LoadProfName := s;
    ReadProfThread := TReadProfThread.Create(False);
  end;
end;
//==============================================================================
procedure TFormProfiles.FindProfiles;
  var SRec: TSearchRec;
      res: Integer;
      st: TStrings;
      mi: TMenuItem;
      s: String;
begin
  st := TStringList.Create;
  res := FindFirst(ExtractFilePath(Application.ExeName) + 'Profiles\*.ini', faAnyFile, SRec);
  while res = 0 do begin
    if (SRec.Name <> '.' ) and (SRec.Name <> '..')and (SRec.Size <> 0) then
    begin
      s := Copy(Srec.Name,1,Length(Srec.Name)-4);
      CbProfile.Items.Add(s);

      mi := TMenuItem.Create(Self);
      mi.Caption := s;
      mi.OnClick := FormProfiles.MenuItmemClick;
      MainForm.MenuProfiles.Items.Add(mi);

      if s = MainForm.LbProfile.Caption then
        CbProfile.ItemIndex := CbProfile.Items.Count-1;


    end;
    res := FindNext(SRec);
  end;
  FindClose(SRec);
  st.Free;
end;
//==============================================================================


procedure TFormProfiles.FormCreate(Sender: TObject);
begin
  Str := TStringList.Create;
end;
//==============================================================================
function TFormProfiles.IntToBool(val: Byte): Boolean;
begin if val = 1 then Result := True else Result := False; end;
//==============================================================================

procedure TReadProfThread.Execute;
begin
  inherited;
 // ReadProfThread.FreeOnTerminate := True;
  FormProfiles.LoadProfile(LoadProfName);
end;

procedure TFormProfiles.LoadProfile(pName: String);
  var n: Integer;
      e: String;
begin
  Str := TStringList.Create;

  //showmessage('safggdfgdfhgdfh');

  if FileExists(ExtractFilePath
    (Application.ExeName) + 'Profiles\' + pName + '.ini') then
  begin
    ini := TIniFile.Create(ExtractFilePath(
      Application.ExeName) + 'Profiles\' + pName + '.ini');
     try
       if OdczytajInteger('Main','Delay',1,1,30) then
         MainForm.TbDelay.Position := Tbl[0];
       if OdczytajInteger('Main','Duty',1,20,98) then
         MainForm.TbDuty.Position := Tbl[0];
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
    MessageBox(0, PChar('Brak pliku ' +pName + '.ini'),
      PChar('B³¹d'), mb_IconError);

end;
//==============================================================================
function TFormProfiles.OdczytajBoolean(a1, a2: String; vCount: Integer): Boolean;
    var nt: Integer;
  begin
    Result := False;
    if OdczytajString(a1,a2,vCount) = True then
    begin
      SetLength(Tbl, vCount);
      Result := True;
      for nt := 0 to vCount-1 do
      begin
       // showmessage(str[nt]+'    '+inttostr(nt));
        if (AnsiLowerCase(str[nt])='true') or (str[nt] = '1') then tbl[nt] := 1 else
        if (AnsiLowerCase(str[nt])='false') or (str[nt] = '0') then tbl[nt] := 0 else
        begin
          Result := False;
          MessageBox(0, PChar('Nieprawid³owa wartoœæ zmiennej "' + a2
          + '" w sekcji "' + a1 + '"!' + #13 +
          'Mo¿e ona przyjmowaæ tylko wartoœci True, False, 1, 0'),
          PChar('B³¹d w pliku konfiguracyjnym!'), mb_IconError);
          showmessage('blad, wartosc zmienej '+a1+'/'+a2+' powinna wynosic True lub False');
          Break;
        end; //if nd <> -2147483647
      end; //for nt := 0 to Str.Count-1
    end; //OdczytajString(a1,a2,vCount) = True
end;

//==============================================================================
function TFormProfiles.OdczytajInteger(a1, a2: String; vCount, vMin,
  vMax: Integer): Boolean;
    var nt, nd: Integer;
  begin
    Result := False;
    if OdczytajString(a1,a2,vCount) = True then
    begin
    //  Showmessage(str.Text);
      SetLength(Tbl, vCount);
      Result := True;
      for nt := 0 to vCount-1 do
      begin
        nd := StrToIntDef(Str[nt], -2147483647);
       // Showmessage(inttostr(nd));
        if (nd <> -2147483647) and (nd >= vMin) and (nd <= vMax)
        then  Tbl[nt] := nd else
        begin
          Result := False;

          MessageBox(0, PChar('Nieprawid³owa wartoœæ zmiennej "' + a2
          + '" w sekcji "' + a1 + '"!' + #13 +
           'Wartoœæ powinna zawieraæ siê w przedziale '
          + IntToStr(vMin) + '..' + IntToStr(vMax)),
            PChar('B³¹d w pliku konfiguracyjnym!'), mb_IconError);
          Break;
        end; //if nd <> -2147483647
      end; //for nt := 0 to Str.Count-1
    end; //OdczytajString(a1,a2,vCount) = True
end;
//==============================================================================
function TFormProfiles.OdczytajString(a1, a2: String;
  vCount: Integer): Boolean;
    var st, su: String;
        nt: Integer;
  begin
    Result := True;
    Str.Clear;
    su := ini.ReadString(a1, a2, #255);
    st := su + ',';
    if su = #255 then
    begin
      MessageBox(0, PChar('Nie mo¿na odnaleŸæ zmiennej "' + a2
        + '" w sekcji "' + a1 + '"!'), PChar('B³¹d w pliku konfiguracyjnym!'), mb_IconError);
      Result := False;
    end else
    for nt := 1 to vCount do
    begin
      Str.Add(Trim(Copy(st, 1, pos(',', st)-1))); //usun spacje i dodaj do listy
      if Pos(',', st) = 0 then
      begin
        MessageBox(0, PChar('Nieprawid³owa wartoœæ zmiennej "' + a2
          + '" w sekcji "' + a1 + '"!' + #13 + '(' + a2 + ' = ' + su + ')'),
          PChar('B³¹d w pliku konfiguracyjnym!'), mb_IconError);
        Result := False;
        Break;
      end;//if Pos(',', st) = 0
      delete(st, 1, Pos(',', st));
    end;//for nt := 1 to vCount

end;
//==============================================================================
procedure TFormProfiles.SaveProfile(pName: String);
  function BoolToStr(b: Boolean): ShortString;
  begin if b = True then Result := 'True' else Result := 'False'; end;
  function BoolToChr(b: Boolean): Char;
  begin if b = True then Result := '1' else Result := '0'; end;

  var s: TStrings;
      n: Integer;

begin
  s := TStringList.Create;
  s.Add('==== Lumicom profile file ====');
  s.Add('');
  s.Add('[Main]');
  s.Add(' Delay'  + #9 + #9 + ' = ' + IntToStr(MainForm.TbDelay.Position));
  s.Add(' Duty'  + #9 + #9 + ' = ' + IntToStr(MainForm.TbDuty.Position));
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

  s.SaveToFile(ExtractFilePath(Application.ExeName) + 'Profiles\' + pName + '.ini');
  s.Free;
end;
//==============================================================================
procedure TFormProfiles.CbProfileKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SprawdzNazwe;
  if (Key = 13) and (BtSave.Enabled) then BtSaveClick(Self);
end;
//==============================================================================
procedure TFormProfiles.SprawdzNazwe;
  var n: Integer;
      s: String;
      b: Boolean;
begin
  Application.ProcessMessages;
  s := UpperCase(Trim(CbProfile.Text));
  b := True;
  for n := 0 to CbProfile.Items.Count-1 do
    if s = UpperCase(CbProfile.Items.Strings[n]) then
    if n + 1 <= DefProfCount then b := False;

    if Trim(s) = '' then b := False;

    if b = False then
    begin
      BtSave.Enabled := False;
      BtDelete.Enabled := False;
    end else
    begin
      BtSave.Enabled := True;
      BtDelete.Enabled := True;
    end;
end;
//==============================================================================
procedure TFormProfiles.BtSaveClick(Sender: TObject);
  var mi: TMenuItem;
      n: Integer;
      s: String;
      b: Boolean;
begin
  b := True;
  s := UpperCase(Trim(CbProfile.Text));
  for n := 0 to CbProfile.Items.Count-1 do
    if s = UpperCase(CbProfile.Items.Strings[n]) then
    if n + 1 > DefProfCount then b := False;

  n := ID_Yes;
  if b = False then n := MessageBox(0, PChar('Czy zastapic istniejacy profil?'),
    PChar('Pytanie'), mb_IconQuestion + mb_YesNo);

  if n = Id_Yes then
  begin
    SaveProfile(CbProfile.Text);
    CbProfile.Items.Add(CbProfile.Text);
    CbProfile.ItemIndex := CbProfile.Items.Count-1;
    mi := TMenuItem.Create(Self);
    mi.Caption := CbProfile.Text;
    mi.OnClick := FormProfiles.MenuItmemClick;
    if b = True then MainForm.MenuProfiles.Items.Add(mi);
    Self.Caption := 'Zapisano profil ' + Trim(CbProfile.Text);

    MainForm.LbProfile.Caption := CbProfile.Text;
    Application.ProcessMessages;
    MainForm.LbProfile.Left :=
      MainForm.ImgMain.Width div 2 - MainForm.LbProfile.Width div 2;
  end;
end;
//==============================================================================
procedure TFormProfiles.FormShow(Sender: TObject);
begin
  SprawdzNazwe;
end;
//==============================================================================


procedure TFormProfiles.BtDeleteClick(Sender: TObject);
  var n: Integer;
      s: String;
begin
  s := Trim(CbProfile.Text);
  n := MessageBox(0, PChar('Czy napewno usunac profil ' + s + '?'),
    PChar('Pytanie'), mb_IconQuestion + mb_YesNo);

  if n = ID_Yes then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'Profiles\' + s + '.ini');
    MainForm.MenuProfiles.Items.Delete(CbProfile.ItemIndex);
    CbProfile.Items.Delete(CbProfile.ItemIndex);
    Self.Caption := 'Usuniêto profil ' + s;
  end;
end;

procedure TFormProfiles.CbProfileChange(Sender: TObject);
begin
  SprawdzNazwe;
end;


end.
