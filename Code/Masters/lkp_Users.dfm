object fmUsers: TfmUsers
  Left = 291
  Top = 151
  BorderStyle = bsDialog
  Caption = #1575#1604#1605#1587#1578#1582#1583#1605#1610#1606
  ClientHeight = 491
  ClientWidth = 1016
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object grp_Content: TGroupBox
    Left = 88
    Top = 102
    Width = 873
    Height = 382
    BiDiMode = bdRightToLeft
    Caption = #1575#1604#1605#1587#1578#1582#1583#1605#1610#1606
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      873
      382)
    object grpData: TGroupBox
      Left = 424
      Top = 26
      Width = 441
      Height = 335
      Anchors = []
      TabOrder = 0
      DesignSize = (
        441
        335)
      object Label2: TLabel
        Left = 360
        Top = 57
        Width = 65
        Height = 19
        Anchors = []
        Caption = #1575#1604#1575#1587#1605' '#1593#1585#1576#1610' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 396
        Top = 23
        Width = 29
        Height = 19
        Anchors = []
        Caption = #1575#1604#1585#1605#1586
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 354
        Top = 93
        Width = 73
        Height = 19
        Anchors = []
        Caption = #1575#1604#1575#1587#1605' '#1575#1606#1580#1604#1610#1586#1610
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 374
        Top = 168
        Width = 53
        Height = 19
        Anchors = []
        Caption = #1575#1604#1605#1580#1605#1608#1593#1577
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 355
        Top = 129
        Width = 72
        Height = 19
        Anchors = []
        Caption = #1573#1587#1605' '#1575#1604#1605#1587#1578#1582#1583#1605
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 159
        Top = 129
        Width = 64
        Height = 19
        Anchors = []
        Caption = #1603#1604#1605#1577' '#1575#1604#1605#1585#1608#1585
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtName: TDBEdit
        Left = 32
        Top = 53
        Width = 315
        Height = 27
        Anchors = []
        DataField = 'FullNameA'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtCode: TDBEdit
        Left = 226
        Top = 19
        Width = 121
        Height = 27
        Anchors = []
        DataField = 'UserID'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DBEdit1: TDBEdit
        Left = 34
        Top = 89
        Width = 315
        Height = 27
        Anchors = []
        DataField = 'FullNameE'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object GP_Status: TDBRadioGroup
        Left = 28
        Top = 198
        Width = 321
        Height = 41
        Caption = #1575#1604#1581#1575#1604#1577
        Columns = 2
        DataField = 'UserStatus'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        Items.Strings = (
          #1606#1588#1591
          #1605#1608#1602#1608#1601)
        ParentFont = False
        TabOrder = 3
        Values.Strings = (
          '1'
          '0')
      end
      object Co_UserGroup: TDBLookupComboBox
        Left = 28
        Top = 164
        Width = 321
        Height = 27
        DataField = 'GroupCode'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        KeyField = 'GroupCode'
        ListField = 'GroupNameA'
        ListSource = DS_UserGroup
        ParentFont = False
        TabOrder = 4
      end
      object DBEdit2: TDBEdit
        Left = 229
        Top = 125
        Width = 120
        Height = 27
        Anchors = []
        DataField = 'UserName'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object DBEdit3: TDBEdit
        Left = 34
        Top = 125
        Width = 120
        Height = 27
        Anchors = []
        DataField = 'Password'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object DBCheckBox1: TDBCheckBox
        Left = 232
        Top = 256
        Width = 113
        Height = 17
        Caption = #1605#1608#1592#1601' '#1606#1602#1591#1577' '#1576#1610#1593
        DataField = 'IsCasher'
        DataSource = DS_Header
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object DBGrid1: TDBGrid
      Left = 9
      Top = 33
      Width = 407
      Height = 327
      DataSource = DS_Header
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clNavy
      TitleFont.Height = -21
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = []
    end
  end
  object GroupBox2: TGroupBox
    Left = 88
    Top = 32
    Width = 873
    Height = 57
    TabOrder = 1
    object BtnOpen: TButton
      Left = 626
      Top = 13
      Width = 115
      Height = 35
      Caption = #1601#1578#1581
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnOpenClick
    end
    object btnAdd: TButton
      Left = 503
      Top = 13
      Width = 115
      Height = 35
      Caption = #1573#1590#1575#1601#1577
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnEdit: TButton
      Left = 379
      Top = 13
      Width = 115
      Height = 35
      Caption = #1578#1593#1583#1610#1600#1600#1604
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 2
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 11
      Top = 13
      Width = 115
      Height = 35
      Caption = #1581#1584#1601
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 5
      OnClick = btnDeleteClick
    end
    object btnSave: TButton
      Left = 254
      Top = 13
      Width = 115
      Height = 35
      Caption = #1581#1601#1600#1600#1600#1600#1600#1592
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 3
      OnClick = btnSaveClick
    end
    object BtnCancel: TButton
      Left = 132
      Top = 13
      Width = 115
      Height = 35
      Caption = #1573#1604#1594#1575#1569
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 4
      OnClick = BtnCancelClick
    end
    object BtnShow: TButton
      Left = 750
      Top = 13
      Width = 115
      Height = 35
      Caption = #1593#1585#1590
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 6
      OnClick = BtnShowClick
    end
  end
  object SDS_Header: TSimpleDataSet
    Aggregates = <>
    Connection = fmMainForm.MainConnection
    DataSet.CommandText = 'Select * From tbl_Users'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 24
    Top = 16
    object SDS_HeaderUserID: TStringField
      DisplayLabel = #1575#1604#1585#1605#1586
      DisplayWidth = 6
      FieldName = 'UserID'
      Required = True
      Size = 75
    end
    object SDS_HeaderFullNameA: TStringField
      DisplayLabel = #1575#1604#1573#1587#1605' '#1593#1585#1576#1610
      DisplayWidth = 20
      FieldName = 'FullNameA'
      Size = 250
    end
    object SDS_HeaderFullNameE: TStringField
      DisplayLabel = #1575#1604#1573#1587#1605' '#1573#1606#1580#1604#1610#1586#1610
      DisplayWidth = 20
      FieldName = 'FullNameE'
      Size = 250
    end
    object SDS_HeaderUserName: TStringField
      DisplayLabel = #1573#1587#1605' '#1575#1604#1605#1587#1578#1582#1583#1605
      DisplayWidth = 20
      FieldName = 'UserName'
      Required = True
      Size = 50
    end
    object SDS_HeaderPassword: TStringField
      DisplayLabel = #1603#1604#1605#1577' '#1575#1604#1605#1585#1608#1585
      DisplayWidth = 10
      FieldName = 'Password'
      Size = 50
    end
    object SDS_HeaderGroupCode: TStringField
      DisplayLabel = #1575#1604#1605#1580#1605#1608#1593#1577
      FieldName = 'GroupCode'
      Size = 10
    end
    object SDS_HeaderUserStatus: TStringField
      DisplayLabel = #1575#1604#1581#1575#1604#1577
      FieldName = 'UserStatus'
      Size = 1
    end
    object SDS_HeaderIsCasher: TBooleanField
      DisplayLabel = #1605#1608#1592#1601' '#1606#1602#1591#1577' '#1575#1604#1576#1610#1593
      FieldName = 'IsCasher'
    end
  end
  object DS_Header: TDataSource
    DataSet = SDS_Header
    Left = 64
    Top = 16
  end
  object SDS_UserGroup: TSimpleDataSet
    Aggregates = <>
    Connection = fmMainForm.MainConnection
    DataSet.CommandText = 'Select * From tbl_UserGroup Where GroupStatus = '#39'1'#39
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 512
    Top = 280
    object SDS_UserGroupGroupCode: TStringField
      DisplayLabel = #1575#1604#1585#1605#1586
      FieldName = 'GroupCode'
      Required = True
      Size = 10
    end
    object SDS_UserGroupGroupNameA: TStringField
      DisplayLabel = #1575#1604#1573#1587#1605' '#1593#1585#1576#1610
      DisplayWidth = 20
      FieldName = 'GroupNameA'
      Size = 75
    end
    object SDS_UserGroupGroupNameE: TStringField
      DisplayLabel = #1575#1604#1573#1587#1605' '#1573#1606#1580#1604#1610#1586#1610
      DisplayWidth = 20
      FieldName = 'GroupNameE'
      Size = 75
    end
  end
  object DS_UserGroup: TDataSource
    DataSet = SDS_UserGroup
    Left = 552
    Top = 280
  end
end
