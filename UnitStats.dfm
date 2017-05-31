object FormStats: TFormStats
  Left = 763
  Top = 108
  Width = 362
  Height = 560
  Caption = 'Statystyki'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 153
    Height = 13
    Caption = 'Czas zerowego poziomu sygnalu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LbZeroTime: TLabel
    Left = 168
    Top = 24
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 114
    Height = 13
    Caption = 'Czas dzialania programu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LbTimeProgress: TLabel
    Left = 168
    Top = 8
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 104
    Width = 142
    Height = 13
    Caption = 'Poziom sygna'#322'u wej'#347'ciowego:'
  end
  object LbVolInMax: TLabel
    Left = 160
    Top = 100
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GaAudioInMaxLv: TGauge
    Left = 18
    Top = 120
    Width = 320
    Height = 25
    MaxValue = 32767
    Progress = 0
    ShowText = False
  end
  object Label4: TLabel
    Left = 16
    Top = 160
    Width = 124
    Height = 13
    Caption = 'Chwilowy poziom sygna'#322'u:'
  end
  object GaAudioLvMax: TGauge
    Left = 18
    Top = 176
    Width = 320
    Height = 25
    MaxValue = 32767
    Progress = 0
    ShowText = False
  end
  object LbMax: TLabel
    Left = 144
    Top = 156
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GaFftMax: TGauge
    Left = 18
    Top = 232
    Width = 320
    Height = 25
    MaxValue = 65535
    Progress = 0
    ShowText = False
  end
  object Label5: TLabel
    Left = 16
    Top = 216
    Width = 165
    Height = 13
    Caption = 'Chwilowy maksymalny poziom FFT:'
  end
  object LbFftMax: TLabel
    Left = 184
    Top = 212
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 24
    Top = 272
    Width = 91
    Height = 13
    Caption = #346'redni poziom FFT:'
  end
  object GaFftSr: TGauge
    Left = 18
    Top = 288
    Width = 320
    Height = 25
    MaxValue = 65535
    Progress = 0
    ShowText = False
  end
  object Label8: TLabel
    Left = 24
    Top = 328
    Width = 151
    Height = 13
    Caption = #346'redni maksymalny poziom FFT:'
  end
  object GaFftSrMax: TGauge
    Left = 18
    Top = 344
    Width = 320
    Height = 25
    MaxValue = 65535
    Progress = 0
    ShowText = False
  end
  object LbFftSrMax: TLabel
    Left = 176
    Top = 324
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LbFftSr: TLabel
    Left = 120
    Top = 268
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 64
    Width = 67
    Height = 13
    Caption = 'Wzmocnienie:'
  end
  object LbAmplify: TLabel
    Left = 80
    Top = 68
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Gauge1: TGauge
    Left = 18
    Top = 424
    Width = 320
    Height = 25
    MaxValue = 1000
    Progress = 0
  end
  object Label9: TLabel
    Left = 16
    Top = 400
    Width = 68
    Height = 13
    Caption = 'Czas przerwy: '
  end
  object Gauge2: TGauge
    Left = 26
    Top = 480
    Width = 320
    Height = 25
    MaxValue = 32768
    Progress = 0
  end
  object Label10: TLabel
    Left = 24
    Top = 464
    Width = 78
    Height = 13
    Caption = 'AudioInMaxLvSr'
  end
  object BtAbout: TButton
    Left = 280
    Top = 8
    Width = 65
    Height = 25
    Caption = 'About'
    TabOrder = 0
    OnClick = BtAboutClick
  end
  object TimerRefresh: TTimer
    Interval = 100
    OnTimer = TimerRefreshTimer
    Left = 216
    Top = 8
  end
end
