object FormSineGenerator: TFormSineGenerator
  Left = 410
  Top = 322
  Width = 430
  Height = 114
  Caption = 'Generator ton'#243'w'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object TbFreq: TTrackBar
    Left = 8
    Top = 0
    Width = 409
    Height = 33
    Max = 142
    ParentShowHint = False
    Position = 20
    ShowHint = True
    TabOrder = 0
    ThumbLength = 25
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = TbFreqChange
  end
  object BtSound: TButton
    Left = 12
    Top = 40
    Width = 57
    Height = 25
    Hint = 'Same as pushing horn speed button'
    Caption = 'Start'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtSoundClick
  end
  object TbVol: TTrackBar
    Left = 80
    Top = 40
    Width = 273
    Height = 25
    Max = 100
    Position = 65
    TabOrder = 2
    TickMarks = tmBoth
    TickStyle = tsNone
  end
end
