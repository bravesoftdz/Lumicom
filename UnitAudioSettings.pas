unit UnitAudioSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormAudioSettings = class(TForm)
    CbPWM: TCheckBox;
    CbShmitt: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAudioSettings: TFormAudioSettings;

implementation

{$R *.dfm}

end.
