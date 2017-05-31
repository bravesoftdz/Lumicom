object FormSettings: TFormSettings
  Left = 540
  Top = 365
  Width = 272
  Height = 306
  Caption = 'FormSettings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ScreenSnap = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 136
    Width = 101
    Height = 13
    Caption = 'Przyciemnienie paneli'
  end
  object Label2: TLabel
    Left = 16
    Top = 208
    Width = 102
    Height = 13
    Caption = 'Odswiezanie wizulacji'
  end
  object CbAlphaBlend: TCheckBox
    Left = 8
    Top = 64
    Width = 129
    Height = 17
    Caption = 'Tryb polprzezroczysty'
    TabOrder = 0
    OnClick = CbStayOnTopClick
  end
  object CbAutoVol: TCheckBox
    Left = 8
    Top = 40
    Width = 185
    Height = 17
    Caption = 'Automatycznie dopasuj glosnosc'
    TabOrder = 1
    OnClick = CbStayOnTopClick
  end
  object CbStayOnTop: TCheckBox
    Left = 8
    Top = 16
    Width = 129
    Height = 17
    Caption = 'Zawsze na wierzchu'
    TabOrder = 2
    OnClick = CbStayOnTopClick
  end
  object TbDarkLevel: TTrackBar
    Left = 8
    Top = 152
    Width = 169
    Height = 25
    Max = 100
    Min = 20
    Position = 75
    TabOrder = 3
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = CbStayOnTopClick
  end
  object TbAlphaBlendLevel: TTrackBar
    Left = 8
    Top = 80
    Width = 169
    Height = 25
    Max = 255
    Min = 20
    Position = 200
    TabOrder = 4
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = CbStayOnTopClick
  end
  object CbScardRmb: TCheckBox
    Left = 8
    Top = 112
    Width = 193
    Height = 17
    Caption = 'Zapami'#281'tuj wybrane '#378'r'#243'd'#322'o d'#378'wi'#281'ku'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = CbStayOnTopClick
  end
  object CbShowDot: TCheckBox
    Left = 16
    Top = 176
    Width = 225
    Height = 17
    Caption = 'Poka'#380' cz'#281'stotliwo'#347#263' o najwy'#380'szej warto'#347'ci'
    TabOrder = 6
    OnClick = CbStayOnTopClick
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 232
    Width = 57
    Height = 17
    Caption = '43 fps'
    Checked = True
    TabOrder = 7
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 80
    Top = 232
    Width = 57
    Height = 17
    Caption = '22 fps'
    TabOrder = 8
    OnClick = RadioButton1Click
  end
  object TimerWinamp: TTimer
    Interval = 100
    Left = 352
    Top = 80
  end
end
