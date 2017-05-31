   unit WinampApi;
    {
    WinAmp API Wrapper for Delphi
    Author: C.Small
    Date: May 2001
    www.sloppycode.net
    Winamp API docs:
    http://www.winamp.com/nsdn/winamp2x/dev/sdk/api.jhtml
    }
    interface
    uses Windows,Messages,Classes,SysUtils;
    type
    TWinampApi = class
    private
    WinampHnd : THandle;
    function ConvertTime(n: integer;m : integer): string;
    function ConvertTimeTool(n: integer): string;
    function split(seperator: Char; text: String; var list: TStringList): Integer;
    public
    WinampPath : String;
    SongLengthParseTime : Boolean;
    SongPosParseTime : Boolean;
    constructor Create(WPath : String);
    function getWhatsPlaying():String;
    function getSongState():String;
    function getSongPosition():String;
    function getSongLength():String;
    function getSongSampleRate():String;
    function getSongBitRate():String;
    function getSongChannels():String;
    function getPlayListPosition():String;
    function getPlayListLength():String;
    procedure getPlayList(var PlayList:TStringList;var FileList:TStringList);
    procedure PlaySong(Mp3Name:string);
    procedure AddToPlayList(Mp3Name:string);
    procedure Play();
    procedure Stop();
    procedure Pause();
    procedure NextTrack();
    procedure PreviousTrack();
    procedure Forward5Seconds();
    procedure Back5Seconds();
    procedure StartOfPlayList();
    procedure VolumeUp();
    procedure VolumeDown();
    procedure FadeOutStop();
    end;
    implementation
    { ----- PUBLIC VOID/NULL RETURN METHODS ---- }
    constructor TWinampApi.Create(WPath : String);
    begin
    SongLengthParseTime := False;
    SongPosParseTime := False;
    WinampPath := WPath;
    WinampHnd := FindWindow(\'Winamp v1.x\', nil);
    end;
    procedure TWinampApi.PlaySong(Mp3Name:String);
    begin
    WinExec(PChar(\'\"\'+WinampPath+\'\\winamp.exe\" \"\'+Mp3Name+\'\"\'),SW_SHOW);
    end;
    procedure TWinampApi.AddToPlayList(Mp3Name:String);
    begin
    WinExec(PChar(\'\"\'+WinampPath+\'\\winamp.exe\" /ADD \"\'+Mp3Name+\'\"\'),SW_SHOW);
    end;
    procedure TWinampApi.Play();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40045, 0);
    end;
    procedure TWinampApi.Stop();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40047, 0);
    end;
    procedure TWinampApi.Pause();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40046, 0);
    end;
    procedure TWinampApi.NextTrack();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40048, 0);
    end;
    procedure TWinampApi.PreviousTrack();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40044, 0);
    end;
    procedure TWinampApi.Forward5Seconds();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40148, 0);
    end;
    procedure TWinampApi.Back5Seconds();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40144, 0);
    end;
    procedure TWinampApi.StartOfPlayList();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40154, 0);
    end;
    procedure TWinampApi.VolumeUp();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40058, 0);
    end;
    procedure TWinampApi.VolumeDown();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40059, 0);
    end;
    procedure TWinampApi.FadeOutStop();
    begin
    SendMessage(WinampHnd, WM_COMMAND, 40147, 0);
    end;
    function TWinampApi.getWhatsPlaying():String;
    var
    TitleLen: integer;
    TempInt : Integer;
    TempStr: String;
    begin
    TempStr := \'Winamp isn\'\'t running\';
    if WinampHnd <> 0 then
    begin
    // Get wHnd text
    TitleLen := GetWindowTextLength(WinampHnd)+2;
    SetLength(TempStr,TitleLen);
    GetWindowText(WinampHnd,Pchar(TempStr),TitleLen);
    SetLength(TempStr,Length(TempStr));
    // Remove \'- Winamp\' part
    TempInt := Pos(\'- Winamp\',TempStr);
    TempStr := Copy(TempStr,0,TempInt -2); // Knock of space and -
    end;
    
    result := TempStr;
    end;
    procedure TWinampApi.getPlayList(var PlayList:TStringList;var FileList:TStringList);
    var
    Buffer: string;
    Stream: TFileStream;
    FileStr : String;
    TempList : TStringList;
    TempListLen : Integer;
    TempStr,TempStr2 : String;
    TempPos,TempPos2 : Integer;
    i : Integer;
    begin
    SendMessage(WinampHnd,WM_USER,0,120);
    Stream := TFileStream.Create(WinampPath+\'\\winamp.m3u\', fmShareDenyNone);
    try
    SetLength(buffer, Stream.Size);
    Stream.Read(Buffer[1], Stream.Size);
    FileStr := Buffer;
    finally
    Stream.Free;
    end;
    TempList := TStringList.Create;
    TempListLen := Split(\'#\',FileStr,TempList);
    // Start from 1 to cut out \'#EXTM3U\'. Grab Name and Filename
    for i:=2 to TempListLen -1 do
    begin
    TempPos := Pos(\',\',TempList.Strings[i]);
    TempPos2 := Pos(#13,TempList.Strings[i]);
    TempStr := Copy(TempList.Strings[i],TempPos +1,(TempPos2 -1) - TempPos);
    TempStr2 := Copy(TempList.Strings[i],TempPos2 +2,(Length(TempList.Strings[i]) -1) - (TempPos2 +2));
    PlayList.Add(TempStr);
    FileList.Add(TempStr2);
    end;
    TempList.Free;
    end;
    { ----- PUBLIC RETURN METHODS ---- }
    function TWinampApi.getSongState():String;
    var
    SongState : Word;
    SongStateStr : String;
    begin
    SongState := SendMessage(WinampHnd,WM_USER,0,104);
    case SongState of
    1: SongStateStr:= \'playing\';
    3: SongStateStr:= \'paused\';
    0: SongStateStr:= \'stopped\'
    else
    SongStateStr := \'unknown\';
    end;
    Result := SongStateStr;
    end;
    function TWinampApi.getSongPosition():String;
    var
    TempInt : Integer;
    begin
    TempInt := SendMessage(WinampHnd,WM_USER,0,105);
    
    if SongPosParseTime then
    Result := ConvertTime(TempInt,1000)
    else
    Result := IntToStr(TempInt);
    end;
    function TWinampApi.getSongLength():String;
    var
    TempInt : Integer;
    begin
    TempInt := SendMessage(WinampHnd,WM_USER,1,105);
    
    if SongLengthParseTime then
    Result := ConvertTime(TempInt,1)
    else
    Result := IntToStr(TempInt);
    end;
    function TWinampApi.getSongSampleRate():String;
    begin
    Result := IntToStr(SendMessage(WinampHnd,WM_USER,0,126));
    end;
    function TWinampApi.getSongBitRate():String;
    begin
    Result := IntToStr(SendMessage(WinampHnd,WM_USER,1,126));
    end;
    function TWinampApi.getSongChannels():String;
    begin
    Result := IntToStr(SendMessage(WinampHnd,WM_USER,2,126));
    end;
    function TWinampApi.getPlayListPosition():String;
    var
    TempInt : Integer;
    begin
    TempInt := SendMessage(WinampHnd,WM_USER,0,125);
    if StrToInt(getPlayListLength()) <1 then
    Result := IntToStr(TempInt)
    else
    Result := IntToStr(TempInt +1);
    end;
    function TWinampApi.getPlayListLength():String;
    begin
    Result := IntToStr(SendMessage(WinampHnd,WM_USER,0,124));
    end;
    { ----- PRIVATE METHODS ----- }
    function TWinampApi.ConvertTime(n: integer;m : integer): string;
    begin
    n := n div m;
    result := ConvertTimeTool(n div 60) + \':\' + ConvertTimeTool(n mod 60);
    end;
    function TWinampApi.ConvertTimeTool(n: integer): string;
    begin
    if n < 10 then
    result := \'0\' + inttostr(n)
    else
    result := inttostr(n);
    end;
    function TWinampApi.split(seperator: Char; text: String; var list: TStringList): Integer;
    var
    mypos, number: Integer;
    begin
    number:=0;
    if Length(text) > 0 then
    begin
    if text[Length(text)] <> seperator then
    text:=text+seperator;
    while(Pos(String(seperator),text))>0 do
    begin
    mypos:=Pos(String(seperator),text);
    list.Add(Copy(text,1,mypos-1));
    text:=Copy(text,mypos+1,Length(text)-mypos);
    Inc(number);
    end;
    end;
    Result:=number;
    end;
    end.