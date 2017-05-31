object FormProfiles: TFormProfiles
  Left = 545
  Top = 275
  BorderStyle = bsDialog
  Caption = 'Profile'
  ClientHeight = 76
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CbProfile: TComboBox
    Left = 8
    Top = 8
    Width = 257
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Domyslny'
    OnChange = CbProfileChange
    OnKeyDown = CbProfileKeyDown
    Items.Strings = (
      'Domyslny')
  end
  object BtSave: TButton
    Left = 16
    Top = 40
    Width = 97
    Height = 25
    Caption = 'Zapisz'
    TabOrder = 1
    OnClick = BtSaveClick
  end
  object BtDelete: TButton
    Left = 160
    Top = 40
    Width = 97
    Height = 25
    Caption = 'Usu'#324
    TabOrder = 2
    OnClick = BtDeleteClick
  end
end
