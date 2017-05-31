unit GPFWinAmpControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

const
  WACM_TRACK_PREV       =       40044;
  WACM_TRACK_NEXT       =       40048;
  WACM_PLAY_CUR         =       40045;
  WACM_PAUSE            =       40046;
  WACM_CONTINUE         =       40046;
  WACM_STOP             =       40047;
  WACM_STOP_FADEOUT     =       40147;
  WACM_STOP_AFTERENDED  =       40157;
  WACM_FF_5SECS         =       40148;
  WACM_FR_5SECS         =       40144;
  WACM_PLAYLIST_START   =       40154;
  WACM_PLAYLIST_END     =       40158;
  WACM_OPEN_FILE        =       40029;
  WACM_OPEN_URL         =       40155;
  WACM_FILE_INFO        =       40188;
  WACM_TIME_ELAPSED     =       40037;
  WACM_TIME_REMAINING   =       40038;
  WACM_PREFERENCES      =       40012;
  WACM_VIZ_OPTIONS      =       40190;
  WACM_VIZ_PLUGINOPTS   =       40191;
  WACM_VIZ_EXEC         =       40192;
  WACM_ABOUT            =       40041;
  WACM_TITLE_SCROLL     =       40189;
  WACM_ALWAYSONTOP      =       40019;
  WACM_WINSH            =       40064;
  WACM_WINSH_PL         =       40065;
  WACM_DOUBLESIZE       =       40165;
  WACM_EQ               =       40036;
  WACM_PL               =       40040;
  WACM_MAIN             =       40258;
  WACM_BROWSER          =       40298;
  WACM_EASYMOVE         =       40186;
  WACM_VOL_RAISE        =       40058;
  WACM_VOL_LOWER        =       40059;
  WACM_REPEAT           =       40022;
  WACM_SHUFFLE          =       40023;
  WACM_OPEN_JUMPTIME    =       40193;
  WACM_OPEN_JUMPFILE    =       40194;
  WACM_OPEN_SKINSEL     =       40219;
  WACM_VIZ_PLUGINCONF   =       40221;
  WACM_SKIN_RELOAD      =       40291;
  WACM_QUIT             =       40001;

  WAUM_VERSION          =       0;
  WAUM_START_PLAYBACK   =       100;
  WAUM_PLAYLIST_CLEAR   =       101;
  WAUM_PLAY_SEL_TRACK   =       102;
  WAUM_CHDIR            =       103;
  WAUM_PLAYBACK_STATUS  =       104;
  WAUM_PLAYBACK_POS     =       105;
  WAUM_TRACK_LENGTH     =       105;
  WAUM_PLAYBACK_SEEK    =       106;
  WAUM_PLAYLIST_WRITE   =       120;
  WAUM_PLAYLIST_SETPOS  =       121;
  WAUM_VOL_SET          =       122;
  WAUM_PAN_SET          =       123;
  WAUM_PLAYLIST_COUNT   =       124;
  WAUM_PLAYLIST_GETINDEX=       125;
  WAUM_TRACK_INFO       =       126;
  WAUM_EQ_DATA          =       127;
  WAUM_EQ_AUTOLOAD      =       128;
  WAUM_BOOKMARK_ADDFILE =       129;
  WAUM_RESTART          =       135;
  { plugin only }
  WAUM_SKIN_SET         =       200;
  WAUM_SKIN_GET         =       201;
  WAUM_VIZ_SET          =       202;
  WAUM_PLAYLIST_GETFN   =       211;
  WAUM_PLAYLIST_GETTIT  =       212;
  WAUM_MB_OPEN_URL      =       241;
  WAUM_INET_AVAIL       =       242;
  WAUM_TITLE_UPDATE     =       243;
  WAUM_PLAYLIST_SETITEM =       245;
  WAUM_MB_RETR_URL      =       246;
  WAUM_PLAYLIST_CACHEFL =       247;
  WAUM_MB_BLOCKUPD      =       248;
  WAUM_MB_BLOCKUPD2     =       249;
  WAUM_SHUFFLE_GET      =       250;
  WAUM_REPEAT_GET       =       251;
  WAUM_SHUFFLE_SET      =       252;
  WAUM_REPEAT_SET       =       253;

type
  TGPFWinAmpTimeDisplayMode = (watdmUnknown,watdmElapsed,watdmRemaining);
  TGPFWinAmpPlayBackStatus = (wapsPlaying,wapsStopped,wapsPaused);
  TGPFWinAmpPluginType = (waplNone,waplGeneric,waplDSP,waplInput,waplOutput,waplVisual);

  TGPFWinAmpCustomPlugin = class(TComponent)
  private
    { Private declarations }
    FDescription : String;
  protected
    { Protected declarations }
    function GetHWindow : HWND; virtual; abstract;
    function GetPluginType : TGPFWinAmpPluginType; virtual; abstract;
    function GetDescription : String;
    procedure SetDescription(Value:String); virtual;
  public
    { Public declarations }
    property PluginType : TGPFWinAmpPluginType read GetPluginType;
  published
    { Published declarations }
    property Description : String read GetDescription write SetDescription;
  end;

  TGPFWinAmpNonePlugin = class(TGPFWinAmpCustomPlugin)
  protected
    { Protected declarations }
    function GetHWindow : HWND; override;
    function GetPluginType : TGPFWinAmpPluginType; override;
  end;

  TGPFWinAmpControl = class(TComponent)
  private
    { Private declarations }
    FWindowClassName : String;
    FTimeDisplayMode : TGPFWinAmpTimeDisplayMode;
    FPlugin : TGPFWinAmpCustomPlugin;
    FWindowFinder : TGPFWinAmpNonePlugin;
    function GetHWindow : HWND;
    procedure SetWindowClassName(Value:String);
    function IsRunning : Boolean;
    procedure SetTimeDisplayMode(Value:TGPFWinAmpTimeDisplayMode);
    function GetVersion : Word;
    function GetVersionString : String;
    { user msg stuff }
    function GetPlayBackStatus : TGPFWinAmpPlayBackStatus;
    function GetTrackPosition : Longword;
    procedure SetTrackPosition(Value:Longword);
    function GetTrackLength : Longword;
    function GetPlaylistIndex : Integer;
    procedure SetPlaylistIndex(Value:Integer);
    procedure SetVolume(Value:Byte);
    procedure SetPanning(Value:Byte);
    function GetPlaylistCount : integer;
    function GetTrackSampleRate : Word;
    function GetTrackBitRate : word;
    function GetTrackChannels : Word;
    function GetEQData(Index:Integer):Byte;
    procedure SetEQData(Index:Integer;Value:Byte);
    function GetEQPreamp : Byte;
    function GetEQEnabled : Boolean;
    procedure SetSkin(FileName:String);
    function GetSkin : String;
    function GetPlaylistFileName(Index:Integer):String;
    function GetPlaylistTitle(Index:Integer):String;
    function GetBrowserURL : String;
    procedure SetBrowserURL(Value:String);
    function GetInternet : Boolean;
    function GetShuffle : Boolean;
    procedure SetShuffle(Value:Boolean);
    function GetRepeat : Boolean;
    procedure SetRepeat(Value:Boolean);
    procedure SetBrowserBlock(Value:Boolean);
    function GetPlugin : TGPFWinAmpCustomPlugin;
    procedure SetPlugin(AComponent : TGPFWinAmpCustomPlugin);
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property HWindow : HWND read GetHWindow;
    property Running : Boolean read IsRunning;
    { == commands == }
    procedure TrackNext;
    procedure TrackPrev;
    procedure TrackPlay;
    procedure TrackPause;
    procedure TrackContinue;
    procedure TrackStop(Fadeout:Boolean=false;After:Boolean=false);
    procedure TrackFF;
    procedure TrackFR;
    procedure PlaylistStart;
    procedure PlaylistEnd;
    procedure OpenFileDialog;
    procedure OpenURLDialog;
    procedure OpenInfoDialog;
    procedure OpenJumpToTime;
    procedure OpenJumpToFile;
    procedure VizOpenOptions;
    procedure VizOpenPluginOptions;
    procedure VizExec;
    procedure VizConfigurePlugIn;
    procedure TogglePreferences;
    procedure ToggleAbout;
    procedure ToggleAutoScroll;
    procedure ToggleAlwaysOnTop;
    procedure ToggleWindowShade;
    procedure TogglePlaylistWindowShade;
    procedure ToggleDoubleSize;
    procedure ToggleEQ;
    procedure TogglePL;
    procedure ToggleMain;
    procedure ToggleBrowser;
    procedure ToggleEasyMove;
    procedure ToggleRepeat;
    procedure ToggleShuffle;
    procedure VolRaise;
    procedure VolLower;
    procedure SkinSelect;
    procedure SkinReload;
    procedure Quit;
    { == wm_user things == }
    procedure PlaybackStart(FileName:String);
    procedure PlaylistClear;
    procedure TrackPlaySelected;
    procedure ChangeDir(Value:String);
    function PlaylistSave : Longword;
    procedure AddToBookmarkList(FileName:String);
    procedure Restart;
    procedure VizSelExec(FileName:String;Index:Integer=0);
    procedure UpdateInfo;
    procedure BrowserForceURL(Value:String);
    { == properties == }
    property TimeDisplayMode : TGPFWinAmpTimeDisplayMode read FTimeDisplayMode write SetTimeDisplayMode;
    property Version : Word read GetVersion;
    property VersionString : String read GetVersionString;
    property PlaybackStatus : TGPFWinAmpPlayBackStatus read GetPlaybackStatus;
    property TrackPosition : Longword read GetTrackPosition write SetTrackPosition;
    property TrackLength : Longword read GetTrackLength;
    property TrackSampleRate : Word read GetTrackSampleRate;
    property TrackBitRate : Word read GetTrackBitRate;
    property TrackChannels : Word read GetTrackChannels;
    property PlaylistIndex : Integer read GetPlaylistIndex write SetPlaylistIndex;
    property PlaylistCount : Integer read GetPlaylistCount;
    property Volume : Byte write SetVolume;
    property Panning : Byte write SetPanning;
    property EQData[Index:Integer] : Byte read GetEQData write SetEQData;
    property EQPreamp : Byte read GetEQPreamp;
    property EQEnabled : Boolean read GetEQEnabled;
    property Skin : String read GetSkin write SetSkin;
    property PlaylistFileName[Index:Integer]:String read GetPlaylistFileName;
    property PlaylistTitle[Index:Integer]:String read GetPlaylistTitle;
    property BrowserURL : String read GetBrowserURL write SetBrowserURL;
    property Internet : Boolean read GetInternet;
    property ShuffleOn : Boolean read GetShuffle write SetShuffle;
    property RepeatOn : Boolean read GetRepeat write SetRepeat;
    property BrowserBlock : Boolean write SetBrowserBlock;
  published
    { Published declarations }
    property WindowClassName : String read FWindowClassName write SetWindowClassName;
    property Plugin : TGPFWinAmpCustomPlugin read GetPlugin write SetPlugin;
  end;

procedure Register;

implementation

{$R *.dcr}

procedure Register;
begin
  RegisterComponents('GPF', [TGPFWinAmpControl]);
end;

{ TGPFWinAmpControl }

procedure TGPFWinAmpControl.AddToBookmarkList(FileName: String);
begin
  SendMessage(HWindow,WM_USER,Word(PChar(FileName)),WAUM_BOOKMARK_ADDFILE);
end;

procedure TGPFWinAmpControl.BrowserForceURL(Value: String);
begin
  SendMessage(HWindow,WM_USER,Word(PChar(Value)),WAUM_MB_BLOCKUPD2);
end;

procedure TGPFWinAmpControl.ChangeDir(Value: String);
var cds : COPYDATASTRUCT;
begin
  cds.dwData := WAUM_CHDIR;
  cds.lpData := PChar(Value);
  cds.cbData := Length(Value)+1;
  SendMessage(HWindow,WM_COPYDATA,0,Integer(@cds));
end;

constructor TGPFWinAmpControl.Create(AOwner: TComponent);
begin
  inherited;
  FWindowClassName := 'Winamp v1.x';
  FPlugin := nil;
  FWindowFinder := TGPFWinAmpNonePlugin.Create(Self);
end;

destructor TGPFWinAmpControl.Destroy;
begin
  FWindowFinder.Free;
  inherited;
end;

function TGPFWinAmpControl.GetBrowserURL: String;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      Result := StrPas(PChar(SendMessage(HWindow,WM_USER,0,WAUM_MB_RETR_URL)));
  end
  else
    Result := '';
end;

function TGPFWinAmpControl.GetEQData(Index: Integer): Byte;
begin
  Result := Byte(SendMessage(HWindow,WM_USER,Index,WAUM_EQ_DATA));
end;

function TGPFWinAmpControl.GetEQEnabled: Boolean;
begin
  Result := (SendMessage(HWindow,WM_USER,11,WAUM_EQ_DATA) <> 0);
end;

function TGPFWinAmpControl.GetEQPreamp: Byte;
begin
  Result := Byte(SendMessage(HWindow,WM_USER,10,WAUM_EQ_DATA));
end;

function TGPFWinAmpControl.GetHWindow: HWND;
var tmp : HWND;
begin
  if Assigned(FPlugin) then
  begin
    tmp := FPlugin.GetHWindow;
    if tmp = 0 then
      Result := FWindowFinder.GetHWindow
    else
      Result := tmp;
  end
  else
    Result := FWindowFinder.GetHWindow;
end;

function TGPFWinAmpControl.GetInternet: Boolean;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      Result := (SendMessage(HWindow,WM_USER,0,WAUM_INET_AVAIL) = 1)
    else
      Result := False;
  end
  else
     Result := False;
end;

function TGPFWinAmpControl.GetPlayBackStatus: TGPFWinAmpPlayBackStatus;
var ret : Integer;
begin
  ret := SendMessage(HWindow,WM_USER,0,WAUM_PLAYBACK_STATUS);
  if ret = 1 then
    Result := wapsPlaying
  else if ret = 3 then
    Result := wapsPaused
  else
    Result := wapsStopped;
end;

function TGPFWinAmpControl.GetPlaylistCount: integer;
begin
  Result := SendMessage(HWindow,WM_USER,0,WAUM_PLAYLIST_COUNT);
end;

function TGPFWinAmpControl.GetPlaylistFileName(Index: Integer): String;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      Result := StrPas(PChar(SendMessage(HWindow,WM_User,Index,WAUM_PLAYLIST_GETFN)));
  end
  else
    Result := '';
end;

function TGPFWinAmpControl.GetPlaylistIndex: Integer;
begin
  Result := SendMessage(HWindow,WM_USER,0,WAUM_PLAYLIST_GETINDEX);
end;

function TGPFWinAmpControl.GetPlaylistTitle(Index: Integer): String;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      Result := StrPas(PChar(SendMessage(HWindow,WM_USER,0,WAUM_PLAYLIST_GETTIT)));
  end
  else
    Result := '';
end;

function TGPFWinAmpControl.GetPlugin: TGPFWinAmpCustomPlugin;
begin
  Result := FPlugin;
end;

function TGPFWinAmpControl.GetRepeat: Boolean;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      Result := (SendMessage(HWindow,WM_USER,0,WAUM_REPEAT_GET) = 1)
    else
      Result := False;
  end
  else
    Result := False;
end;

function TGPFWinAmpControl.GetShuffle: Boolean;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      Result := (SendMessage(HWindow,WM_USER,0,WAUM_SHUFFLE_GET) = 1)
    else
      Result := False;
  end
  else
    Result := False;
end;

function TGPFWinAmpControl.GetSkin: String;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      Result := StrPas(PChar(SendMessage(HWindow,WM_USER,0,WAUM_SKIN_GET)));
  end
  else
    Result := '';
end;

function TGPFWinAmpControl.GetTrackBitRate: word;
begin
  Result := Word(SendMessage(HWindow,WM_USER,1,WAUM_TRACK_INFO));
end;

function TGPFWinAmpControl.GetTrackChannels: Word;
begin
  Result := Word(SendMessage(HWindow,WM_USER,2,WAUM_TRACK_INFO));
end;

function TGPFWinAmpControl.GetTrackLength: Longword;
begin
  Result := Word(SendMessage(HWindow,WM_USER,1,WAUM_TRACK_LENGTH));
end;

function TGPFWinAmpControl.GetTrackPosition: Longword;
begin
  Result := Word(SendMessage(HWindow,WM_USER,0,WAUM_PLAYBACK_POS));
end;

function TGPFWinAmpControl.GetTrackSampleRate: Word;
begin
  Result := Word(SendMessage(HWindow,WM_USER,0,WAUM_TRACK_INFO));
end;

function TGPFWinAmpControl.GetVersion: Word;
begin
  Result := Word(SendMessage(HWindow,WM_USER,0,WAUM_VERSION));
end;

function TGPFWinAmpControl.GetVersionString: String;
var ver : Word;
begin
  ver := GetVersion;
  Result := Format('v%d.%d%d',[(ver and $F000) shr 12,(ver and $0FF0) shr 8,ver and $F]);
end;

function TGPFWinAmpControl.IsRunning: Boolean;
begin
  Result := (HWindow <> 0);
end;

procedure TGPFWinAmpControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = FPlugin) then
  begin
    FPlugin := nil;
    //FWindowFinder := TGPFWinAmpNonePlugin.Create(Self);
  end;
end;

procedure TGPFWinAmpControl.OpenFileDialog;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_OPEN_FILE,0);
end;

procedure TGPFWinAmpControl.OpenInfoDialog;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_FILE_INFO,0);
end;

procedure TGPFWinAmpControl.OpenJumpToFile;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_OPEN_JUMPFILE,0);
end;

procedure TGPFWinAmpControl.OpenJumpToTime;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_OPEN_JUMPTIME,0);
end;

procedure TGPFWinAmpControl.OpenURLDialog;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_OPEN_URL,0);
end;

procedure TGPFWinAmpControl.PlaybackStart(FileName:String);
var cds : COPYDATASTRUCT;
begin
  cds.dwData := WAUM_START_PLAYBACK;
  cds.lpData := PChar(FileName);
  cds.cbData := Length(FileName)+1;
  SendMessage(HWindow,WM_COPYDATA,0,Integer(@cds));
end;

procedure TGPFWinAmpControl.PlaylistClear;
begin
  SendMessage(HWindow,WM_USER,0,WAUM_PLAYLIST_CLEAR);
end;

procedure TGPFWinAmpControl.PlaylistEnd;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_PLAYLIST_END,0);
end;

function TGPFWinAmpControl.PlaylistSave: Longword;
begin
  Result := Longword(SendMessage(HWindow,WM_USER,0,WAUM_PLAYLIST_WRITE));
end;

procedure TGPFWinAmpControl.PlaylistStart;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_PLAYLIST_START,0);
end;

procedure TGPFWinAmpControl.Quit;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_QUIT,0);
end;

procedure TGPFWinAmpControl.Restart;
begin
  SendMessage(HWindow,WM_USER,0,WAUM_RESTART);
end;

procedure TGPFWinAmpControl.SetBrowserBlock(Value: Boolean);
begin
  SendMessage(HWindow,WM_USER,Ord(Value),WAUM_MB_BLOCKUPD);
end;

procedure TGPFWinAmpControl.SetBrowserURL(Value: String);
begin
  SendMessage(HWindow,WM_USER,Integer(PChar(Value)),WAUM_MB_OPEN_URL);
end;

procedure TGPFWinAmpControl.SetEQData(Index: Integer; Value: Byte);
begin
  SendMessage(HWindow,WM_USER,Index,WAUM_EQ_DATA);
  SendMessage(HWindow,WM_USER,Value,WAUM_EQ_AUTOLOAD);
end;

procedure TGPFWinAmpControl.SetPanning(Value: Byte);
begin
  SendMessage(HWindow,WM_USER,Value,WAUM_PAN_SET);
end;

procedure TGPFWinAmpControl.SetPlaylistIndex(Value: Integer);
begin
  SendMessage(HWindow,WM_User,Value,WAUM_PLAYLIST_SETPOS);
end;

procedure TGPFWinAmpControl.SetPlugin(AComponent: TGPFWinAmpCustomPlugin);
begin
  FPlugin := AComponent;
  FPlugin.FreeNotification(Self);
end;

procedure TGPFWinAmpControl.SetRepeat(Value: Boolean);
begin
  if Assigned(FPlugin) then
  begin
    if (FPlugin.GetPluginType <> waplNone) and (Value xor GetRepeat) then
      SendMessage(HWindow,WM_User,Ord(Value),WAUM_REPEAT_SET);
  end;
end;

procedure TGPFWinAmpControl.SetShuffle(Value: Boolean);
begin
  if Assigned(FPlugin) then
  begin
    if (FPlugin.GetPluginType <> waplNone) and (Value xor GetShuffle) then
      SendMessage(HWindow,WM_User,Ord(Value),WAUM_SHUFFLE_SET);
  end;
end;

procedure TGPFWinAmpControl.SetSkin(FileName: String);
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      SendMessage(HWindow,WM_USER,Integer(PChar(FileName)),WAUM_SKIN_SET);
  end;
end;

procedure TGPFWinAmpControl.SetTimeDisplayMode(
  Value: TGPFWinAmpTimeDisplayMode);
begin
  if Value = watdmElapsed then
    SendMessage(HWindow,WM_COMMAND,WACM_TIME_ELAPSED,0);
  if Value = watdmRemaining then
    SendMessage(HWindow,WM_COMMAND,WACM_TIME_REMAINING,0);
end;

procedure TGPFWinAmpControl.SetTrackPosition(Value: Longword);
begin
  SendMessage(HWindow,WM_USER,Value,WAUM_PLAYBACK_SEEK);
end;

procedure TGPFWinAmpControl.SetVolume(Value: Byte);
begin
  SendMessage(HWindow,WM_USER,Value,WAUM_VOL_SET);
end;

procedure TGPFWinAmpControl.SetWindowClassName(Value: String);
begin
   if FWindowClassName <> Value then
   begin
      FWindowClassName := Value;
   end;
end;

procedure TGPFWinAmpControl.SkinReload;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_SKIN_RELOAD,0);
end;

procedure TGPFWinAmpControl.SkinSelect;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_OPEN_SKINSEL,0);
end;

procedure TGPFWinAmpControl.ToggleAbout;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_ABOUT,0);
end;

procedure TGPFWinAmpControl.ToggleAlwaysOnTop;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_ALWAYSONTOP,0);
end;

procedure TGPFWinAmpControl.ToggleAutoScroll;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_TITLE_SCROLL,0);
end;

procedure TGPFWinAmpControl.ToggleBrowser;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_BROWSER,0);
end;

procedure TGPFWinAmpControl.ToggleDoubleSize;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_DOUBLESIZE,0);
end;

procedure TGPFWinAmpControl.ToggleEasyMove;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_EASYMOVE,0);
end;

procedure TGPFWinAmpControl.ToggleEQ;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_EQ,0);
end;

procedure TGPFWinAmpControl.ToggleMain;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_MAIN,0);
end;

procedure TGPFWinAmpControl.TogglePL;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_PL,0);
end;

procedure TGPFWinAmpControl.TogglePlaylistWindowShade;
begin
    SendMessage(HWindow,WM_COMMAND,WACM_WINSH_PL,0);
end;

procedure TGPFWinAmpControl.TogglePreferences;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_PREFERENCES,0);
end;

procedure TGPFWinAmpControl.ToggleRepeat;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_REPEAT,0);
end;

procedure TGPFWinAmpControl.ToggleShuffle;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_SHUFFLE,0);
end;

procedure TGPFWinAmpControl.ToggleWindowShade;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_WINSH,0);
end;

procedure TGPFWinAmpControl.TrackContinue;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_CONTINUE,0);
end;

procedure TGPFWinAmpControl.TrackFF;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_FF_5SECS,0);
end;

procedure TGPFWinAmpControl.TrackFR;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_FR_5SECS,0);
end;

procedure TGPFWinAmpControl.TrackNext;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_TRACK_NEXT,0);
end;

procedure TGPFWinAmpControl.TrackPause;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_PAUSE,0);
end;

procedure TGPFWinAmpControl.TrackPlay;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_PLAY_CUR,0);
end;

procedure TGPFWinAmpControl.TrackPlaySelected;
begin
  SendMessage(HWindow,WM_USER,0,WAUM_PLAY_SEL_TRACK);
end;

procedure TGPFWinAmpControl.TrackPrev;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_TRACK_PREV,0);
end;

procedure TGPFWinAmpControl.TrackStop(Fadeout, After: Boolean);
begin
   if Fadeout then
   begin
     SendMessage(HWindow,WM_COMMAND,WACM_STOP_FADEOUT,0);
   end
   else
   begin
     if After then
       SendMessage(HWindow,WM_COMMAND,WACM_STOP_AFTERENDED,0)
     else
       SendMessage(HWindow,WM_COMMAND,WACM_STOP,0);
   end;
end;

procedure TGPFWinAmpControl.UpdateInfo;
begin
  if Assigned(FPlugin) then
  begin
    if FPlugin.GetPluginType <> waplNone then
      SendMessage(HWindow,WM_USER,0,WAUM_TITLE_UPDATE);
  end;
end;

procedure TGPFWinAmpControl.VizConfigurePlugIn;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_VIZ_PLUGINCONF,0);
end;

procedure TGPFWinAmpControl.VizExec;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_VIZ_EXEC,0);
end;

procedure TGPFWinAmpControl.VizOpenOptions;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_VIZ_OPTIONS,0);
end;

procedure TGPFWinAmpControl.VizOpenPluginOptions;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_VIZ_PLUGINOPTS,0);
end;

procedure TGPFWinAmpControl.VizSelExec(FileName: String; Index: Integer);
var tmpStr : String;
begin
  if Index > 0 then
    tmpStr := FileName+','+IntToStr(Index)
  else
    tmpStr := FileName;
  SendMessage(HWindow,WM_USER,Integer(PChar(tmpStr)),WAUM_VIZ_SET);
end;

procedure TGPFWinAmpControl.VolLower;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_VOL_LOWER,0);
end;

procedure TGPFWinAmpControl.VolRaise;
begin
  SendMessage(HWindow,WM_COMMAND,WACM_VOL_RAISE,0);
end;

{ TGPFWinAmpNonePlugin }

function TGPFWinAmpNonePlugin.GetHWindow: HWND;
begin
  Result := FindWindow(PChar(TGPFWinAmpControl(Owner).FWindowClassName),nil);
end;

function TGPFWinAmpNonePlugin.GetPluginType: TGPFWinAmpPluginType;
begin
  Result := waplNone;
end;

{ TGPFWinAmpCustomPlugin }

function TGPFWinAmpCustomPlugin.GetDescription: String;
begin
  Result := FDescription;
end;

procedure TGPFWinAmpCustomPlugin.SetDescription(Value: String);
begin
  FDescription := Value;
end;

end.
