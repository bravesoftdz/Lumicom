unit UnitWinampAssociations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, INIFiles, ComCtrls;

type
  TFormWinampAssociations = class(TForm)
    Panel1: TPanel;
    BtAdd: TButton;
    BtRemove: TButton;
    LvWinampAssociations: TListView;
    procedure BtAddClick(Sender: TObject);
    procedure SaveList;
    procedure BtRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWinampAssociations: TFormWinampAssociations;

implementation

uses UnitMainForm, UnitWinamp, UnitProfiles;

{$R *.dfm}

procedure TFormWinampAssociations.BtAddClick(Sender: TObject);
begin
  WinampAlist[1].Add(MainForm.LbProfile.Caption);
  WinampAlist[0].Add(Winamp.Title);
  SaveList;
end;

procedure TFormWinampAssociations.SaveList;
  var n: Integer;
begin
  ini := TIniFile.Create(ExtractFilePath(Application.ExeName) +
      'associations.ini');
  try
    ini.EraseSection('Main');
    for n := 0 to WinampAlist[0].Count-1 do
    ini.WriteString('Main', WinampAlist[0].Strings[n], WinampAlist[1].Strings[n]);

  finally
  end;
  MainForm.LoadWinampAssociations;
end;

procedure TFormWinampAssociations.BtRemoveClick(Sender: TObject);
begin
  if LvWinampAssociations.ItemIndex <> -1 then
  begin

    WinampAlist[0].Delete(LvWinampAssociations.ItemIndex);
    WinampAlist[1].Delete(LvWinampAssociations.ItemIndex);
  //  LvWinampAssociations.DeleteSelected;
    SaveList;
  end;
end;

end.
