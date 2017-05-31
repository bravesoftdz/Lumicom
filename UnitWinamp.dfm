object FormWinamp: TFormWinamp
  Left = 503
  Top = 142
  Width = 334
  Height = 445
  BorderIcons = [biSystemMenu]
  Caption = 'Winamp'
  Color = clBtnFace
  Constraints.MinHeight = 220
  Constraints.MinWidth = 334
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 326
    Height = 113
    Align = alTop
    BevelOuter = bvLowered
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object LbStatus: TLabel
      Left = 208
      Top = 46
      Width = 30
      Height = 13
      Caption = 'Status'
      Visible = False
    end
    object BtWinampStopFader: TButton
      Left = 176
      Top = 40
      Width = 25
      Height = 25
      Caption = '[]^'
      TabOrder = 0
      OnClick = BtWinampBackClick
    end
    object BtWinampNext: TButton
      Left = 144
      Top = 40
      Width = 25
      Height = 25
      Caption = '>|'
      TabOrder = 1
      OnClick = BtWinampBackClick
    end
    object BtWinampStop: TButton
      Left = 112
      Top = 40
      Width = 25
      Height = 25
      Caption = '[]'
      TabOrder = 2
      OnClick = BtWinampBackClick
    end
    object BtWinampPause: TButton
      Left = 80
      Top = 40
      Width = 25
      Height = 25
      Caption = 'II'
      TabOrder = 3
      OnClick = BtWinampBackClick
    end
    object BtWinampPlay: TButton
      Left = 48
      Top = 40
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 4
      OnClick = BtWinampBackClick
    end
    object BtWinampBack: TButton
      Left = 16
      Top = 40
      Width = 25
      Height = 25
      Caption = '|<'
      TabOrder = 5
      OnClick = BtWinampBackClick
    end
    object TbWinampPos: TTrackBar
      Left = 8
      Top = 8
      Width = 313
      Height = 25
      TabOrder = 6
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbWinampPosChange
    end
    object CbWinampShuffle: TCheckBox
      Left = 16
      Top = 72
      Width = 65
      Height = 17
      Caption = 'Losowo'
      TabOrder = 7
      OnClick = BtWinampBackClick
    end
    object CbWinampRepeat: TCheckBox
      Left = 88
      Top = 72
      Width = 65
      Height = 17
      Caption = 'Powtarzaj'
      TabOrder = 8
      OnClick = BtWinampBackClick
    end
    object TbWinampVol: TTrackBar
      Left = 160
      Top = 68
      Width = 161
      Height = 25
      Max = 255
      Position = 150
      TabOrder = 9
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbWinampVolChange
    end
    object BtWinampRun: TButton
      Left = 208
      Top = 40
      Width = 105
      Height = 25
      Caption = 'Uruchom Winamp-a'
      TabOrder = 10
      Visible = False
      OnClick = BtWinampRunClick
    end
  end
  object LbPlayList: TListBox
    Left = 0
    Top = 113
    Width = 326
    Height = 305
    Align = alClient
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    OnDblClick = LbPlayListDblClick
  end
end
