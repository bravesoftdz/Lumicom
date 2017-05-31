object FormChannel: TFormChannel
  Left = 324
  Top = 78
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'FormChannel'
  ClientHeight = 615
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ScreenSnap = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BtAudio: TSpeedButton
    Left = 96
    Top = 152
    Width = 81
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = 'Audio'
    OnClick = BtGenClick
  end
  object BtGen: TSpeedButton
    Left = 8
    Top = 152
    Width = 81
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Generator'
    OnClick = BtGenClick
  end
  object BtRan: TSpeedButton
    Left = 184
    Top = 152
    Width = 81
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Losowy'
    OnClick = BtGenClick
  end
  object SpeedButton1: TSpeedButton
    Left = 280
    Top = 152
    Width = 49
    Height = 25
    Glyph.Data = {
      7E000000424D7E000000000000003E0000002800000020000000100000000100
      01000000000040000000C40E0000C40E0000020000000000000000000000FFFF
      FF00FFFFFFFFFFFFFFFF7FFC07FEBFFBF7FDDFF7F7FBDFEFF7FBDFEFF7FBEFDF
      F7F7EFBFF7F7EF7FF7F7F6FFF7EFF6FFF7EFF5FFF7EFFBFFF7DFFBFFF01FFFFF
      FFFF}
    NumGlyphs = 2
    Transparent = False
  end
  object ImgChart: TPaintBox
    Left = 8
    Top = 184
    Width = 321
    Height = 49
  end
  object GbGen: TGroupBox
    Left = 8
    Top = 240
    Width = 321
    Height = 257
    Caption = ' Generator '
    TabOrder = 0
    object Label2: TLabel
      Left = 28
      Top = 118
      Width = 12
      Height = 13
      Caption = 'od'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbGenfreq: TLabel
      Left = 16
      Top = 72
      Width = 67
      Height = 13
      Caption = 'Cz'#281'stotliwo'#347#263':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 104
      Top = 118
      Width = 21
      Height = 13
      Caption = 'mHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel6: TBevel
      Left = 8
      Top = 200
      Width = 305
      Height = 9
      Shape = bsTopLine
    end
    object Label8: TLabel
      Left = 16
      Top = 152
      Width = 61
      Height = 13
      Caption = 'Wypelnienie:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 176
      Top = 152
      Width = 34
      Height = 13
      Caption = 'Ksztalt:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel15: TBevel
      Left = 152
      Top = 152
      Width = 9
      Height = 41
      Shape = bsRightLine
    end
    object LbGenDuty: TLabel
      Left = 83
      Top = 152
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbGenShape: TLabel
      Left = 219
      Top = 152
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 104
      Top = 16
      Width = 94
      Height = 13
      Caption = 'Zbocze narastajace'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label27: TLabel
      Left = 216
      Top = 16
      Width = 89
      Height = 13
      Caption = 'Zbocze opadajace'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Bevel16: TBevel
      Left = 8
      Top = 64
      Width = 305
      Height = 9
      Shape = bsTopLine
    end
    object Label30: TLabel
      Left = 264
      Top = 118
      Width = 21
      Height = 13
      Caption = 'mHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label31: TLabel
      Left = 188
      Top = 118
      Width = 12
      Height = 13
      Caption = 'do'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbGenFreqChange: TLabel
      Left = 16
      Top = 208
      Width = 91
      Height = 13
      Caption = 'Op'#243#378'nienie waha'#324':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel18: TBevel
      Left = 8
      Top = 144
      Width = 305
      Height = 9
      Shape = bsTopLine
    end
    object Bevel19: TBevel
      Left = 192
      Top = 208
      Width = 9
      Height = 41
      Shape = bsRightLine
    end
    object Label29: TLabel
      Left = 224
      Top = 208
      Width = 47
      Height = 13
      Caption = 'Styl zmian'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel11: TBevel
      Left = 80
      Top = 16
      Width = 9
      Height = 41
      Shape = bsRightLine
    end
    object LbGenFreqChStep: TLabel
      Left = 152
      Top = 208
      Width = 6
      Height = 13
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SeGenMin: TSpinEdit
      Left = 44
      Top = 111
      Width = 57
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 10000
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 1000
      OnChange = SeAudioFreqMinChange
    end
    object SeGenMax: TSpinEdit
      Left = 204
      Top = 111
      Width = 57
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 10000
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 3000
      OnChange = SeAudioFreqMinChange
    end
    object PnGen: TPanel
      Left = 8
      Top = 88
      Width = 305
      Height = 17
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 2
      object PnGenFreqPos: TPanel
        Left = 80
        Top = 5
        Width = 4
        Height = 8
        BevelOuter = bvSpace
        Color = clGray
        TabOrder = 2
      end
      object BtGenMin: TButton
        Left = 32
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 0
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
      object BtGenMax: TButton
        Left = 96
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 1
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
    end
    object CbGenShapeUp: TComboBox
      Left = 104
      Top = 32
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = 'Sinus'
      OnChange = TbOutPowerChange
      Items.Strings = (
        'Sinus'
        'Parabola'
        'Tr'#243'jk'#261't'
        'Prostok'#261't')
    end
    object TbGenDuty: TTrackBar
      Left = 4
      Top = 168
      Width = 149
      Height = 25
      Max = 97
      TabOrder = 4
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbOutPowerChange
    end
    object TbGenShape: TTrackBar
      Left = 168
      Top = 168
      Width = 145
      Height = 25
      Max = 198
      Min = 2
      Position = 100
      TabOrder = 5
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbOutPowerChange
    end
    object CbGenShapeDown: TComboBox
      Left = 216
      Top = 32
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = 'Sinus'
      OnChange = TbOutPowerChange
      Items.Strings = (
        'Sinus'
        'Parabola'
        'Tr'#243'jk'#261't'
        'Prostok'#261't')
    end
    object CbGenStyle: TComboBox
      Left = 224
      Top = 224
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 7
      Text = 'Stala'
      OnChange = TbOutPowerChange
      Items.Strings = (
        'Stala'
        'Wahadlo'
        'Skokowy'
        'Losowy'
        'Chaos')
    end
    object CbGenNegative: TCheckBox
      Left = 16
      Top = 28
      Width = 65
      Height = 17
      Caption = 'Negacja'
      TabOrder = 8
      OnClick = TbOutPowerChange
    end
    object TbGenFreqChStep: TTrackBar
      Left = 8
      Top = 224
      Width = 185
      Height = 25
      Max = 100
      Position = 20
      TabOrder = 9
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbOutPowerChange
    end
  end
  object GbRandom: TGroupBox
    Left = 8
    Top = 504
    Width = 321
    Height = 89
    Caption = ' Losowy '
    TabOrder = 1
    object Label10: TLabel
      Left = 8
      Top = 16
      Width = 119
      Height = 13
      Caption = 'Zmiana trybu po up'#322'ywie:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 88
      Top = 64
      Width = 12
      Height = 13
      Caption = 'do'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 64
      Width = 12
      Height = 13
      Caption = 'od'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 188
      Top = 64
      Width = 5
      Height = 13
      Caption = 's'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbRandomCount: TLabel
      Left = 160
      Top = 16
      Width = 8
      Height = 13
      Caption = '-s'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel9: TBevel
      Left = 216
      Top = 16
      Width = 9
      Height = 65
      Shape = bsRightLine
    end
    object SeRandomMax: TSpinEdit
      Left = 128
      Top = 59
      Width = 57
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 600
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 10
      OnChange = SeAudioFreqMinChange
    end
    object SeRandomMin: TSpinEdit
      Left = 24
      Top = 59
      Width = 57
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 600
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 3
      OnChange = SeAudioFreqMinChange
    end
    object CbRanOff: TCheckBox
      Left = 232
      Top = 64
      Width = 73
      Height = 17
      Caption = 'Wy'#322#261'czony'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = TbOutPowerChange
    end
    object CbRanOn: TCheckBox
      Left = 232
      Top = 48
      Width = 73
      Height = 17
      Caption = 'W'#322#261'czony'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = TbOutPowerChange
    end
    object CbRanGen: TCheckBox
      Left = 232
      Top = 32
      Width = 73
      Height = 17
      Caption = 'Generator'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = TbOutPowerChange
    end
    object CbRanAudio: TCheckBox
      Left = 232
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Audio'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = TbOutPowerChange
    end
    object PnRandom: TPanel
      Left = 8
      Top = 32
      Width = 209
      Height = 17
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 6
      object BtRandomMin: TButton
        Left = 48
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 0
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
      object BtRandomMax: TButton
        Left = 88
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 1
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
    end
  end
  object GbMain: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 137
    Caption = ' Opcje '
    TabOrder = 2
    object LbMode1: TLabel
      Left = 80
      Top = 37
      Width = 47
      Height = 13
      Caption = 'Generator'
      Transparent = True
    end
    object LbMode2: TLabel
      Left = 80
      Top = 55
      Width = 27
      Height = 13
      Caption = 'Audio'
      Transparent = True
    end
    object LbMode3: TLabel
      Left = 80
      Top = 72
      Width = 49
      Height = 13
      Caption = 'W'#322#261'czony'
      Transparent = True
    end
    object LbMode4: TLabel
      Left = 80
      Top = 90
      Width = 54
      Height = 13
      Caption = 'Wy'#322#261'czony'
      Transparent = True
    end
    object LbMode0: TLabel
      Left = 80
      Top = 20
      Width = 36
      Height = 13
      Caption = 'Losowy'
      Transparent = True
    end
    object LbMode5: TLabel
      Left = 80
      Top = 108
      Width = 22
      Height = 13
      Caption = 'Auto'
      Transparent = True
    end
    object Label34: TLabel
      Left = 153
      Top = 12
      Width = 21
      Height = 13
      Caption = 'Moc'
      Transparent = True
    end
    object Bevel3: TBevel
      Left = 136
      Top = 16
      Width = 9
      Height = 113
      Shape = bsRightLine
    end
    object Bevel20: TBevel
      Left = 176
      Top = 16
      Width = 9
      Height = 113
      Shape = bsRightLine
    end
    object Bevel21: TBevel
      Left = 32
      Top = 16
      Width = 9
      Height = 113
      Shape = bsRightLine
    end
    object Label36: TLabel
      Left = 193
      Top = 12
      Width = 38
      Height = 13
      Caption = 'Etykieta'
      Transparent = True
    end
    object Label37: TLabel
      Left = 265
      Top = 12
      Width = 46
      Height = 13
      Caption = 'Kanal wy.'
      Transparent = True
    end
    object GaLevel: TGauge
      Left = 8
      Top = 16
      Width = 25
      Height = 113
      BackColor = clBtnFace
      ForeColor = clSilver
      Kind = gkVerticalBar
      MaxValue = 255
      Progress = 0
      ShowText = False
    end
    object TbMode: TTrackBar
      Left = 48
      Top = 12
      Width = 25
      Height = 117
      Max = 5
      Orientation = trVertical
      PageSize = 1
      Position = 2
      TabOrder = 0
      TickStyle = tsNone
      OnChange = TbModeChange
    end
    object TbOutPower: TTrackBar
      Left = 152
      Top = 24
      Width = 25
      Height = 105
      Max = 255
      Orientation = trVertical
      PageSize = 1
      Position = 255
      TabOrder = 1
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbOutPowerChange
    end
    object EdCaption: TEdit
      Left = 192
      Top = 32
      Width = 49
      Height = 21
      MaxLength = 8
      TabOrder = 2
      OnChange = EdCaptionChange
      OnClick = TbOutPowerChange
    end
    object CbOutCh: TComboBox
      Left = 264
      Top = 32
      Width = 49
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = '1'
      OnChange = TbOutPowerChange
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23'
        '24')
    end
    object PnColor: TPanel
      Left = 272
      Top = 64
      Width = 41
      Height = 33
      Caption = 'Kolor'
      Color = clSilver
      ParentBackground = False
      TabOrder = 4
      OnClick = PnColorClick
    end
    object CbMajorPWM: TCheckBox
      Left = 192
      Top = 88
      Width = 49
      Height = 17
      Hint = 'Zezw'#243'l na tryb PWM'
      HelpKeyword = 'Zezw'#243'l na tryb PWM'
      Caption = 'PWM'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = TbOutPowerChange
    end
    object ComboBox1: TComboBox
      Left = 264
      Top = 108
      Width = 49
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = '1'
      OnChange = TbOutPowerChange
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23'
        '24')
    end
    object CbNegative: TCheckBox
      Left = 192
      Top = 112
      Width = 65
      Height = 17
      Caption = 'Negacja'
      TabOrder = 7
      OnClick = TbOutPowerChange
    end
    object CbStrob: TCheckBox
      Left = 192
      Top = 64
      Width = 71
      Height = 17
      Caption = 'Impulsowy'
      TabOrder = 8
      OnClick = TbOutPowerChange
    end
  end
  object GbAudio: TGroupBox
    Left = 344
    Top = 8
    Width = 321
    Height = 361
    Caption = ' Audio '
    TabOrder = 3
    object Gauge2: TGauge
      Left = 12
      Top = 16
      Width = 25
      Height = 89
      ForeColor = clGreen
      Kind = gkVerticalBar
      MaxValue = 255
      Progress = 0
      ShowText = False
    end
    object Bevel5: TBevel
      Left = 8
      Top = 112
      Width = 185
      Height = 9
      Shape = bsTopLine
    end
    object Image1: TImage
      Left = 56
      Top = 16
      Width = 137
      Height = 89
    end
    object Bevel13: TBevel
      Left = 40
      Top = 16
      Width = 9
      Height = 89
      Shape = bsRightLine
    end
    object Bevel14: TBevel
      Left = 192
      Top = 16
      Width = 9
      Height = 281
      Shape = bsRightLine
    end
    object Bevel8: TBevel
      Left = 8
      Top = 304
      Width = 305
      Height = 9
      Shape = bsTopLine
    end
    object Label14: TLabel
      Left = 218
      Top = 16
      Width = 71
      Height = 13
      Caption = 'Metoda analizy'
    end
    object Label15: TLabel
      Left = 213
      Top = 64
      Width = 84
      Height = 13
      Caption = 'Punkt odniesienia'
    end
    object Label9: TLabel
      Left = 213
      Top = 112
      Width = 68
      Height = 13
      Caption = 'Okienkowanie'
    end
    object Label17: TLabel
      Left = 270
      Top = 224
      Width = 19
      Height = 13
      Caption = '[ms]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 212
      Top = 192
      Width = 61
      Height = 13
      Caption = 'Czas impulsu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 270
      Top = 264
      Width = 19
      Height = 13
      Caption = '[ms]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 211
      Top = 240
      Width = 62
      Height = 13
      Caption = 'Czas przerwy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 13
      Top = 120
      Width = 116
      Height = 13
      Caption = 'Zakres czestotliwosci FF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 174
      Top = 168
      Width = 19
      Height = 13
      Caption = '[Hz]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 78
      Top = 168
      Width = 19
      Height = 13
      Caption = '[Hz]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 9
      Top = 200
      Width = 80
      Height = 13
      Caption = 'Prog zadzialania:'
    end
    object Label20: TLabel
      Left = 65
      Top = 248
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label28: TLabel
      Left = 169
      Top = 248
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label6: TLabel
      Left = 9
      Top = 312
      Width = 64
      Height = 13
      Caption = 'Wzmocnienie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbAmplVal: TLabel
      Left = 123
      Top = 312
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 152
      Top = 312
      Width = 9
      Height = 41
      Shape = bsRightLine
    end
    object Label21: TLabel
      Left = 180
      Top = 312
      Width = 53
      Height = 13
      Caption = 'Op'#243#378'nienie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbAudioDelayVal: TLabel
      Left = 251
      Top = 312
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel4: TBevel
      Left = 208
      Top = 160
      Width = 105
      Height = 9
      Shape = bsTopLine
    end
    object Bevel10: TBevel
      Left = 8
      Top = 192
      Width = 185
      Height = 9
      Shape = bsTopLine
    end
    object Bevel12: TBevel
      Left = 8
      Top = 272
      Width = 185
      Height = 9
      Shape = bsTopLine
    end
    object CbAnalyze: TComboBox
      Left = 216
      Top = 32
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Maks. warto'#347#263
      OnClick = TbOutPowerChange
      Items.Strings = (
        'Maks. warto'#347#263
        #346'rednia'
        #346'rednia sinus'
        #346'rednia tr'#243'jk'#261't')
    end
    object CbRefP: TComboBox
      Left = 216
      Top = 80
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Sta'#322'a'
      OnClick = TbOutPowerChange
      Items.Strings = (
        'Sta'#322'a'
        #346'rednia'
        #346'rednia max')
    end
    object CbAudioShape: TComboBox
      Left = 216
      Top = 128
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'Brak'
      OnClick = TbOutPowerChange
      Items.Strings = (
        'Brak'
        'Sinus'
        'Sinus/2'
        'Trojkat'
        'Trojkat/2')
    end
    object CbPulseMode: TCheckBox
      Left = 208
      Top = 168
      Width = 97
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Tryb impulsowy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 3
      WordWrap = True
      OnClick = TbOutPowerChange
    end
    object SeAudioPulseTime: TSpinEdit
      Left = 216
      Top = 211
      Width = 49
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 5000
      MinValue = 1
      ParentFont = False
      TabOrder = 4
      Value = 100
      OnChange = SeAudioFreqMinChange
    end
    object SeAudioPulseBreak: TSpinEdit
      Left = 216
      Top = 259
      Width = 49
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 5000
      MinValue = 1
      ParentFont = False
      TabOrder = 5
      Value = 100
      OnChange = SeAudioFreqMinChange
    end
    object CbAudioDiffMode: TCheckBox
      Left = 96
      Top = 280
      Width = 97
      Height = 17
      Caption = 'Tryb r'#243#380'nicowy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      WordWrap = True
      OnClick = TbOutPowerChange
    end
    object CbAudioPWM: TCheckBox
      Left = 16
      Top = 280
      Width = 73
      Height = 17
      Caption = 'Tryb PWM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = TbOutPowerChange
    end
    object PnAudioFreq: TPanel
      Left = 8
      Top = 136
      Width = 185
      Height = 17
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 8
      object BtAudioFreqMin: TButton
        Left = 48
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 0
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
      object BtAudioFreqMax: TButton
        Left = 104
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 1
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
    end
    object SeAudioFreqMax: TSpinEdit
      Left = 112
      Top = 163
      Width = 57
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 20000
      MinValue = 20
      ParentFont = False
      TabOrder = 9
      Value = 20000
      OnChange = SeAudioFreqMinChange
    end
    object SeAudioFreqMin: TSpinEdit
      Left = 16
      Top = 163
      Width = 57
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 20000
      MinValue = 20
      ParentFont = False
      TabOrder = 10
      Value = 20
      OnChange = SeAudioFreqMinChange
    end
    object Panel1: TPanel
      Left = 8
      Top = 216
      Width = 185
      Height = 17
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 11
      object Button1: TButton
        Left = 48
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 0
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
      object Button2: TButton
        Left = 88
        Top = 0
        Width = 17
        Height = 17
        TabOrder = 1
        OnMouseDown = BtAudioFreqMinMouseDown
        OnMouseMove = BtAudioFreqMinMouseMove
        OnMouseUp = BtAudioFreqMinMouseUp
      end
    end
    object SeAudioSchmitMin: TSpinEdit
      Left = 16
      Top = 243
      Width = 49
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 100
      MinValue = 0
      ParentFont = False
      TabOrder = 12
      Value = 40
      OnChange = SeAudioFreqMinChange
    end
    object SeAudioSchmitMax: TSpinEdit
      Left = 112
      Top = 243
      Width = 49
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 100
      MinValue = 0
      ParentFont = False
      TabOrder = 13
      Value = 60
      OnChange = SeAudioFreqMinChange
    end
    object TbAmplify: TTrackBar
      Left = 4
      Top = 328
      Width = 149
      Height = 25
      Max = 150
      Position = 50
      TabOrder = 14
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbOutPowerChange
    end
    object TbAudioDelay: TTrackBar
      Left = 168
      Top = 328
      Width = 145
      Height = 25
      Max = 150
      Position = 50
      TabOrder = 15
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TbOutPowerChange
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 598
    Width = 888
    Height = 17
    Panels = <>
  end
  object ColorDialog1: TColorDialog
    Left = 304
    Top = 536
  end
end
