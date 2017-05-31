object FormWinampAssociations: TFormWinampAssociations
  Left = 825
  Top = 162
  Width = 300
  Height = 505
  Caption = 'Winamp - Powiazania'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 440
    Width = 292
    Height = 38
    Align = alBottom
    TabOrder = 0
    object BtAdd: TButton
      Left = 24
      Top = 8
      Width = 65
      Height = 25
      Caption = 'Dodaj'
      TabOrder = 0
      OnClick = BtAddClick
    end
    object BtRemove: TButton
      Left = 208
      Top = 8
      Width = 65
      Height = 25
      Caption = 'Usun'
      TabOrder = 1
      OnClick = BtRemoveClick
    end
  end
  object LvWinampAssociations: TListView
    Left = 0
    Top = 0
    Width = 292
    Height = 440
    Align = alClient
    Columns = <
      item
        Caption = 'Profil'
        Width = 80
      end
      item
        AutoSize = True
        Caption = 'Tytul'
      end>
    ReadOnly = True
    RowSelect = True
    ShowWorkAreas = True
    TabOrder = 1
    ViewStyle = vsReport
  end
end
