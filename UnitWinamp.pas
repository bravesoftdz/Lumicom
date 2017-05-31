unit UnitWinamp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, ShlObj, ComCtrls;

type
  TFormWinamp = class(TForm)
    Panel1: TPanel;
    LbPlayList: TListBox;
    BtWinampStopFader: TButton;
    BtWinampNext: TButton;
    BtWinampStop: TButton;
    BtWinampPause: TButton;
    BtWinampPlay: TButton;
    BtWinampBack: TButton;
    TbWinampPos: TTrackBar;
    CbWinampShuffle: TCheckBox;
    CbWinampRepeat: TCheckBox;
    TbWinampVol: TTrackBar;
    LbStatus: TLabel;
    BtWinampRun: TButton;
    procedure BtWinampBackClick(Sender: TObject);
    procedure TbWinampVolChange(Sender: TObject);
    procedure LbPlayListDblClick(Sender: TObject);
    procedure TbWinampPosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ZaladujPlayliste;
    procedure BtWinampRunClick(Sender: TObject);
    procedure CheckWinampState;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TWinamp = packed record
    Handle:     HWND;
    Path:       String;
    Version:    String;
    Title:      String;
    BitRate:    Integer;
    Samplerate: Integer;
    Channels:   Integer;
    Status:     String;
    Length:     Integer;
    Position:   Integer;
    Playlist:   TStrings;
    Plpath:     String;
    TrackCount: Integer;
    SelectedTrack: Integer;
    SelectedTrackOld: Integer;
    Shuffle:    Boolean;
    wRepeat:     Boolean;
    AssociatedTitle: Boolean; //powiazany track
  end;

  TWinampState = class(TThread)
  protected
    procedure Execute; override;
  end;

//  WinampBarDrag: Boolean; //rozpoczeto przesuwanie suwaka
var
  FormWinamp: TFormWinamp;
  Winamp:       TWinamp;
  WinampExist:  Boolean;
  WinampReading: Boolean;
  WinampState :   TWinampState;
  LadowaniePlaylisty: Boolean;


implementation

uses UnitSettings, UnitMainForm, UnitWinampAssociations;

{$R *.dfm}

procedure TFormWinamp.BtWinampBackClick(Sender: TObject);
begin
  if WinampReading = False then
  begin
  if Sender = BtWinampBack then SendMessage(Winamp.Handle, WM_COMMAND, 40044, 0);
  if Sender = BtWinampPlay then SendMessage(Winamp.Handle, WM_COMMAND, 40045, 0);
  if Sender = BtWinampPause then SendMessage(Winamp.Handle, WM_COMMAND, 40046, 0);
  if Sender = BtWinampStop then SendMessage(Winamp.Handle, WM_COMMAND, 40047, 0);
  if Sender = BtWinampNext then SendMessage(Winamp.Handle, WM_COMMAND, 40048, 0);
  if Sender = BtWinampStopFader then SendMessage(Winamp.Handle, WM_COMMAND, 40147, 0);

  if Sender = CbWinampRepeat then SendMessage(Winamp.Handle,WM_COMMAND,40022,0);
  if Sender = CbWinampShuffle then SendMessage(Winamp.Handle,WM_COMMAND,40023,0);
  end;
end;

procedure TFormWinamp.TbWinampVolChange(Sender: TObject);
begin
  SendMessage(Winamp.Handle, WM_USER, TbWinampVol.Position ,122);

end;

procedure TFormWinamp.LbPlayListDblClick(Sender: TObject);
begin
  if LbPlaylist.Items.Count > 0 then
    begin
      SendMessage(Winamp.Handle, WM_USER, LbPlaylist.ItemIndex, 121);
      SendMessage(Winamp.Handle, WM_COMMAND, 40045, 0);
    end;
end;

procedure TFormWinamp.TbWinampPosChange(Sender: TObject);
begin
  if not WinampReading then
    SendMessage(Winamp.Handle, WM_USER, TbWinampPos.Position ,106);
end;

procedure TFormWinamp.FormCreate(Sender: TObject);
  var reg: TRegistry;
      s: String;
      var FilePath: array[0..MAX_PATH] of char;
begin

  //LbPlaylist.Color := RGB(165, 165, 216);
  //Panel1.Color := RGB(165, 165, 216);
  Winamp.Playlist := TStringList.Create;
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey('Software\Winamp', False);
    s := reg.ReadString('');
    if FileExists(s+ '\winamp.exe') then Winamp.Path := s + '\winamp.exe';
    if FileExists(s + '\winamp.m3u') then Winamp.Plpath := s + '\winamp.m3u';
    SHGetSpecialFolderPath(0, FilePath, CSIDL_APPDATA , False);
    if FileExists(FilePath + '\Winamp\winamp.m3u') then
      Winamp.Plpath := FilePath + '\Winamp\winamp.m3u';
  finally
    reg.Free;
  end;
  if Winamp.Plpath <> '' then //jesli winamp jest zainstalowany i odnaleziono playliste...
  begin
    WinampState := TWinampState.Create(False);
    WinampState.Priority := tpIdle;
  end;
end;

procedure TFormWinamp.ZaladujPlayliste;
  var n: Integer;
      str: TStrings;
begin
  if not LadowaniePlaylisty then
  //if (Winamp.Plpath <> '') and (Winamp.Handle <> 0) then
  begin
    LadowaniePlaylisty := True;
    Self.Caption := 'Ladowanie Playlisty';
    Application.ProcessMessages;
    Winamp.Playlist.Clear;
    SendMessage(Winamp.Handle,WM_USER,0,120);
    sleep(100);

    Str := TStringList.Create;
    Str.LoadFromFile(Winamp.Plpath);
    for n := 0 to Str.Count-1 do
      if Copy(Str[n], 1, 8) = '#EXTINF:' then
         Winamp.Playlist.Add(IntToStr(Winamp.Playlist.Count+1) + '. ' +
         Copy(Str[n], pos(',',Str[n])+1, Length(Str[n])-pos(',',Str[n])));
    LbPlayList.Items := Winamp.Playlist;
    Winamp.TrackCount := SendMessage(Winamp.Handle,WM_USER,0,124);
    str.Free;
    LadowaniePlaylisty := False;
  end;

end;

procedure TFormWinamp.BtWinampRunClick(Sender: TObject);
begin
  WinExec(PChar(UnitWinamp.Winamp.Path), 0);
end;

{ TWinampState }
//==============================================================================
procedure TWinampState.Execute;

begin
  inherited;
  while FormWinamp.Caption <> '8347659837569723598' do
  begin
    if ZamykanieProgramu then break;
    WinampState.Synchronize(FormWinamp.CheckWinampState);

    sleep(50);
  end;
end;

procedure TFormWinamp.CheckWinampState;
  var v: Integer;
      s: String;
begin


//  if Self.Visible = True then
  if WinampReading = False then with FormWinamp do
  begin
    WinampReading := True;
    Winamp.Handle := FindWindow('Winamp v1.x',nil);
    if Winamp.Handle <> 0 then
    begin
      V := SendMessage(Winamp.Handle,WM_USER,0,0);
      Winamp.Version := Format('v%d.%d%d',
        [(V and $F000) shr 12,(V and $0FF0) shr 8,V and $F]);

      // --------------- pobierz tytul ----------------------
      v := GetWindowTextLength(Winamp.Handle) + 2;
      SetLength(s, v);
      GetWindowText(Winamp.Handle, Pchar(s), v);

      if Copy(LowerCase(s),1,6) <> 'winamp' then Delete(s, pos(' - Winamp', s),
      Length(s) - pos(' - Winamp', s)+1);
      Delete(s, 1, Pos('. ', s)+1);

      Winamp.Title := s;

      // --------------- pobierz status ----------------------
      v := SendMessage(Winamp.Handle, WM_USER, 0, 104);
      case v of
        1: Winamp.Status := 'odtwarzanie';
        3: Winamp.Status := 'pazua';
        0: Winamp.Status := 'zatrzymany';
      else Winamp.Status := 'nieznany';
      end;


      s := '';
      if (Winamp.Status = 'odtwarzanie') or (Winamp.Status = 'pauza') then
        s := Winamp.Title;
   {   if MainForm.LbWinampTrack.Caption <> s then
      begin
        MainForm.LbWinampTrack.Caption := s;
        FormWinampAssociations.LbTitle.Caption :=
          MainForm.LbProfile.Caption + ' = ' + s;
      end; }
      // --------------- pobierz pozycje ----------------------
      Winamp.Position := SendMessage(Winamp.Handle,WM_USER,0,105);

      // --------------- pobierz dlugosc ----------------------
      Winamp.Length := SendMessage(Winamp.Handle,WM_USER,1,105) * 1000;

      // --------------- pobierz Bitrate ----------------------
      Winamp.BitRate := SendMessage(Winamp.Handle,WM_USER,1,126);

      // --------------- pobierz Samplerate ----------------------
      Winamp.Samplerate := SendMessage(Winamp.Handle,WM_USER,0,126);

      // --------------- pobierz Channels ----------------------
      Winamp.Channels:= SendMessage(Winamp.Handle,WM_USER,2,126);

      // ------------------ pobierz liczbe utworow -------------------
      Winamp.TrackCount := SendMessage(Winamp.Handle,WM_USER,0,124);

       // ------------------ pobierz zaznaczony utwor  -------------------
      Winamp.SelectedTrack := SendMessage(Winamp.Handle,WM_USER,0,125);

      if Winamp.Channels = 2 then s := 'stereo' else s := 'mono';

      LbStatus.Caption := IntToStr(Winamp.Samplerate)+'kHz, '+
        IntToStr(Winamp.BitRate)+'kbps, '+s;


      if SendMessage(Winamp.Handle,WM_USER,0,251) = 1 then
        Winamp.wRepeat := True else Winamp.wRepeat := False;

      if SendMessage(Winamp.Handle,WM_USER,0,250) = 1 then
        Winamp.Shuffle := True else Winamp.Shuffle := False;


    CbWinampRepeat.Checked := Winamp.wRepeat;
    CbWinampShuffle.Checked := Winamp.Shuffle;

     if LbPlayList.Items.Count > Winamp.SelectedTrack + 1 then
       if Winamp.SelectedTrack <> Winamp.SelectedTrackOld then
     begin
       LbPlaylist.ItemIndex := Winamp.SelectedTrack;
       LbPlaylist.Selected[Winamp.SelectedTrack] := True;
       Winamp.SelectedTrackOld := Winamp.SelectedTrack;
     end;

     //  self.Caption := inttostr(winamp.TrackCount) + inttostr(winamp.Playlist.Count);
      if Winamp.TrackCount <> Winamp.Playlist.Count then ZaladujPlayliste;



      TbWinampPos.Max := Winamp.Length;
      TbWinampPos.Position := Winamp.Position;

      if not LadowaniePlaylisty then
      FormWinamp.Caption := Winamp.Title;
      //FormSettings.GbWinamp.Caption := ' Winamp [' + Winamp.Status + '] ';

      LbStatus.Visible := True;
      TbWinampPos.Enabled := True;
      BtWinampPlay.Enabled := True;
      BtWinampPause.Enabled := True;
      BtWinampStop.Enabled := True;
      BtWinampBack.Enabled := True;
      BtWinampNext.Enabled := True;
      BtWinampStopFader.Enabled := True;
      TbWinampVol.Enabled := True;
      BtWinampRun.Visible := False;
      LbPlaylist.Enabled := True;
      CbWinampShuffle.Enabled := True;
      CbWinampRepeat.Enabled := True;
      MainForm.ImgWinamp.Visible := True;

    end else
    begin
      Winamp.Title := '';
      //if Winamp.Path <> '' then
      //  FormSettings.GbWinamp.Caption := ' Winamp (nie odnaleziono) ';
      if Winamp.Path <> '' then BtWinampRun.Visible := True;
      TbWinampPos.Enabled := False;
      LbStatus.Visible := False;
      BtWinampPlay.Enabled := False;
      BtWinampPause.Enabled := False;
      BtWinampStop.Enabled := False;
      BtWinampBack.Enabled := False;
      BtWinampNext.Enabled := False;
      BtWinampStopFader.Enabled := False;
      TbWinampVol.Enabled := False;
      LbPlaylist.Enabled := False;
      CbWinampShuffle.Enabled := False;
      CbWinampRepeat.Enabled := False;
      LbPlaylist.Clear;
      Winamp.Playlist.Clear;
      Winamp.TrackCount := 0;
      MainForm.ImgWinamp.Visible := False;
    end;
     WinampReading := False;
  end; //Self.Visible
end;

end.
