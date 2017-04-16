{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppAvStd;

interface

{$I ppIfDef.pas}

uses
  ppLabelDef;


type

  {@TppAveryStdLaserJetLabels}
  TppAveryStdLaserJetLabels = class(TppLaserJetLabels)
    protected
      class function GetLabelDef(aIndex: Integer): String; override;

    public
      class function Product: String; override;
      class function Count: Integer; override;

    end; {class, TppAveryStdLaserJetLabels}
    

  {@TppAveryStdDotMatrixLabels}
  TppAveryStdDotMatrixLabels = class(TppDotMatrixLabels)
    protected
      class function GetLabelDef(aIndex: Integer): String; override;

    public
      class function Product: String; override;
      class function Count: Integer; override;
      
    end; {class, TppAveryStdDotMatrixLabels}


implementation

const
  caAveryStdLaserJet: array [0..157] of String = (

  {  LabelType, Name, Width, Height, PaperWidth,
     PaperHeight, MarginTop, MarginBottom, MarginLeft, MarginRight,
     Orientation, RowSpacing, Units, Columns, ColumnPositions }

'Address,2160 - Mini,2.63,1,4.5,5,0.5,0,0.81,0,0,0,1,0',
'Address,2162 - Mini,4,1.33,4.5,5,0.5,0,0.12,0,0,0,1,0',
'Shipping,2163 - Mini,4,2,4.5,5,0.5,0,0.12,0,0,0,1,0',
'File Folder,2180 - Mini,3.44,0.67,4.5,5,0.5,0,0.4,0,0,0,1,0',
'File Folder,2181 - Mini,3.44,0.67,4.5,5,0.5,0,0.4,0,0,0,1,0',
'Diskette,2186 - Mini,2.75,2,4.5,5,0.5,0,0.75,0,0,0,1,0',
'Address,2660 - Mini,2.63,1,4.5,5,0.5,0,0.81,0,0,0,1,0',
'Address,2662 - Mini,4.13,1.33,4.5,5,0.5,0,0.185,0.185,0,0,1,0',
'Shipping,2663 - Mini,4.13,2,4.5,5,0.5,0,0.185,0.185,0,0,1,0',
'File Folder,5066,3,0.5,8.5,11,0.66,0.25,0.75,0,0,0.17,1,2,0.75,4.75',
'Name Badge,5095,3.38,2.33,8.5,11,0.58,0.25,0.69,0,0,0.17,1,2,0.69,4.44',
'Diskette,5096,2.75,2.75,8.5,11,0.5,0.25,0.13,0,0,0.25,1,3,0.13,2.88,5.63',
'Diskette,5097,4,1.5,8.5,11,1,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Address,5160,2.63,1,8.5,11,0.5,0.25,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5161,4,1,8.5,11,0.5,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Address,5162,4,1.33,8.5,11,0.83,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,5163,4,2,8.5,11,0.5,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,5164,4,3.33,8.5,11,0.5,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Full Sheet,5165,8.5,11,8.5,11,0,0,0,0,0,0,1,1,0',
'Return Address,5167,1.75,0.5,8.5,11,0.5,0.25,0.28,0,0,0,1,4,0.28,2.34,4.4,6.46',
'Diskette,5196,2.75,2.75,8.5,11,0.5,0.25,0.13,0,0,0.25,1,3,0.13,2.88,5.63',
'Diskette,5197,4,1.5,8.5,11,1,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Audio Cassette,5198,3.5,1.67,8.5,11,0.5,0.25,0.5,0,0,0,1,2,0.5,4.5',
'F-Video Face,5199-F,3.06,1.83,8.5,11,0.92,0.25,1.07,0,0,0,1,2,1.07,4.37',
'S-Video Spine,5199-S,5.81,0.67,8.5,11,0.5,0.25,1.34,0,0,0,1,1,1.34',
'Address,5260,2.63,1,8.5,11,0.5,0.25,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5261,4,1,8.5,11,0.5,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Address,5262,4,1.33,8.5,11,0.83,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,5263,4,2,8.5,11,0.5,0.25,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,5264,4,3.33,8.5,11,0.5,0.25,0.16,0,0,0,1,2,0.16,4.35',
'File Folder,5266,3,0.5,8.5,11,0.66,0.25,0.75,0,0,0.17,1,2,0.75,4.75',
'Return Address,5267,1.75,0.5,8.5,11,0.5,0.25,0.28,0,0,0,1,4,0.28,2.34,4.4,6.46',
'Tent Card,5305,7.5,1.75,8.5,11,3.38,0,0.5,0,0,3.25,1,1,0.5',
'Tent Card,5309,10,2.5,11,8.5,1.63,3,0.5,0,1,0,1,1,0.5',
'Note Card,5315,5,3.75,11,8.5,0.25,0,0.25,0,1,0.5,1,2,0.25,5.75',
'Identification Card,5361,3.25,2,8.5,11,0.83,0,4.32,0,0,1.67,1,1,4.32',
'Name Badge,5362,3.25,2,8.5,11,0.83,0,4.32,0,0,1.67,1,1,4.32',
'Rotary Card,5364,3.88,2.06,8.5,11,0.81,0,4.32,0,0,1.61,1,1,4.32',
'File Folder,5366,3.4375,0.6708,8.5,11,0.5,0.5,0.5313,0.5313,0,0,1,2,0.5313,4.5313',
'Business Card,5371,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Business Card,5372,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Business Card,5376,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Business Card,5377,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Name Badge,5383,3.5,2.17,8.5,11,1.17,0,0.75,0,0,0,1,2,0.75,4.25',
'Name Badge,5384,4,3,8.5,11,1.13,0,0.25,0,0,0,1,2,0.25,4.25',
'Rotary Card,5385,4,2.17,8.5,11,1.17,0,0.25,0,0,0,1,2,0.25,4.25',
'Rotary Card,5386,5,3,8.5,11,1,0,1.75,0,0,0,1,1,1.75',
'Index Card,5388,5,3,8.5,11,1,0,1.75,0,0,0,1,1,1.75',
'Post Card,5389,6,4,8.5,11,1.5,0,1.25,0,0,0,1,1,1.25',
'Name Badge,5395,3.38,2.33,8.5,11,0.58,0,0.69,0,0,0.17,1,2,0.69,4.44',
'Address,5660,2.83,1,8.5,11,0.5,0,0,0,0,0,1,3,0,2.83,5.66',
'Address,5661,4.25,1,8.5,11,0.5,0,0,0,0,0,1,2,0,4.25',
'Address,5662,4.25,1.33,8.5,11,0.83,0,0,0,0,0,1,2,0,4.25',
'Address,5663,4.25,2,8.5,11,0.5,0,0,0,0,0,1,2,0,4.25',
'Shipping,5664,4.25,3.33,8.5,11,0.5,0,0,0,0,0,1,2,0,4.25',
'Return Address,5667,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'File Folder,5766,3,0.5,8.5,11,0.66,0.25,0.75,0,0,0.17,1,2,0.75,4.75',
'Divider - Mtg.Creator,5836-D,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'Portfolio - Mtg.Creator,5836-P,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Divider - Mtg.Creator,5837-D,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'Portfolio - Mtg.Creator,5837-P,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Divider - Mtg.Creator,5838-D,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'Portfolio - Mtg.Creator,5838-P,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Portfolio - Mtg.Creator,5839,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Portfolio - Mtg.Creator,5840,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Portfolio - Mtg.Creator,5841,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Badge - Mtg.Creator,5843,3.5,2.17,8.5,11,1.17,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Tent Card - Mtg.Creator,5844,7.5,1.75,8.5,11,3.38,0,0.5,0,0,3.25,1,1,0.5',
'Address - Mtg.Creator,5845-A,2.83,1,8.5,11,0.5,0.25,0,0,0,0,1,3,0,2.83,5.66',
'Note Card - Mtg.Creator,5845-N,4.25,5.5,8.5,11,0,0,0,0,0,0,1,2,0,4.25',
'Divider - Mtg.Creator,5848-D,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'Portfolio - Mtg.Creator,5848-P,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Divider - Mtg.Creator,5849-D,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'Portfolio - Mtg.Creator,5849-P,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'Divider - Mtg.Creator,5855-D,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'Portfolio-Mtg.Creator,5855-P,3.5,2,8.5,11,0.5,0.25,0.75,0,0,0,1,2,0.75,4.25',
'File Folder,5866,3,0.5,8.5,11,0.66,0.25,0.75,0,0,0.17,1,2,0.75,4.75',
'Name badge,5883,3.5,2.17,8.5,11,1.17,0,0.75,0,0,0,1,2,0.75,4.25',
'Name Badge,5895,3.38,2.33,8.5,11,0.58,0,0.69,0,0,0.17,1,2,0.69,4.44',
'Diskette,5896,2.75,2.75,8.5,11,0.5,0,0.13,0,0,0,1,3,0.13,2.88,5.63',
'Diskette,5897,4,1.5,8.5,11,1,0,0.16,0,0,0,1,2,0.16,4.35',
'Address,5920,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5922,4,1.33,8.5,11,0.83,0,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,5923,4,2,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Return Address,5927,1.75,0.5,8.5,11,0.5,0.25,0.28,0,0,0,1,4,0.28,2.34,4.4,6.46',
'Address,5930,2.83,1,8.5,11,0.5,0,0,0,0,0,1,3,0,2.83,5.66',
'Address,5932,4.25,1.33,8.5,11,0.83,0,0,0,0,0,1,2,0,4.25',
'Address,5960,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5961,4,1,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Address,5962,4,2,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,5963,4,1.33,8.5,11,0.83,0,0.16,0,0,0,1,2,0.16,4.35',
'File Folder,5966,3,0.5,8.5,11,0.66,0,0.75,0,0,0.17,1,2,0.75,4.75',
'Address,5970,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5971,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5972,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5979,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,5980,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Remove-Em,6460,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Remove-Em,6464,4,3.33,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Remove-Em,6466,3,0.5,8.5,11,0.66,0,0.75,0,0,0.17,1,2,0.75,4.75',
'Diskette,6490,2.69,2,8.5,11,0.5,0,0.13,0,0,0,1,3,0.13,2.91,5.69',
'Address,8160,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,8161,4,1,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Address,8162,4,1.33,8.5,11,0.83,0,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,8163,4,2,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,8164,4,3.33,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Full Sheet,8165,8.5,11,8.5,11,0,0,0,0,0,0,1,1,0',
'File Folder,8166,3,0.5,8.5,11,0.66,0,0.75,0,0,0.17,1,2,0.75,4.75',
'Return Address,8167,1.75,0.5,8.5,11,0.5,0.25,0.28,0,0,0,1,4,0.28,2.34,4.4,6.46',
'Diskette,8196,2.75,2.75,8.5,11,0.5,0,0.13,0,0,0.25,1,3,0.13,2.88,5.63',
'File Folder,8366,3,0.5,8.5,11,0.66,0,0.75,0,0,0.17,1,2,0.75,4.75',
'Business Card,8371,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Business Card,8372,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Business Card,8376,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Business Card,8377,3.5,2,8.5,11,0.5,0,0.75,0,0,0,1,2,0.75,4.25',
'Address,8460,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,8462,4,1.33,8.5,11,0.83,0,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,8463,4,2,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Address,8660,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,8662,4,1.33,8.5,11,0.83,0,0.16,0,0,0,1,2,0.16,4.35',
'Address,8663,4,2,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Return Address,8667,1.75,0.5,8.5,11,0.5,0.25,0.28,0,0,0,1,4,0.28,2.34,4.4,6.46',
'Address,8920,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,8922,4,1.33,8.5,11,0.83,0,0.16,0,0,0,1,2,0.16,4.35',
'Shipping,8923,4,2,8.5,11,0.5,0,0.16,0,0,0,1,2,0.16,4.35',
'Return Address,8927,1.75,0.5,8.5,11,0.5,0.25,0.28,0,0,0,1,4,0.28,2.34,4.4,6.46',
'Address,8930,2.63,1,8.5,11,0.5,0,0.19,0,0,0,1,3,0.19,2.94,5.69',
'Address,8932,4,1.33,8.5,11,0.83,0,0.16,0,0,0,1,2,0.16,4.35',
'Laser Tag,12-294,3.13,2.5,8.5,11,0.5,0,1,0,0,0,1,2,1,5.13',
'Laser Tag,12-295,3.13,2.5,8.5,11,0.5,0,1,0,0,0,1,2,1,5.13',
'Laser Tag,12-296,5.38,3,8.5,11,1,0,1.63,0,0,0,1,1,1.63',
'Laser Tag,12-297,5.38,3,8.5,11,1,0,1.63,0,0,0,1,1,1.63',
'Tabs,Hidden Tab 3,3.31,3.13,8.5,11,0.63,0,4.94,0,0,0.25,1,1,4.94',
'Tabs,Hidden Tab 5,3,2,8.5,11,0.63,0,5.13,0,0,0,1,1,5.13',
'Tabs,Hidden Tab 8,3,1.22,8.5,11,0.63,0,5.13,0,0,0,1,1,5.13',
'Tabs,Hidden Tab 10,3,1,8.5,11,0.63,0,5.13,0,0,0,1,1,5.13',
'Tabs,Index Maker 3,3.13,0.5,8.5,11,0.5,0.25,0.5,0,0,0,1,2,0.5,4.88',
'Tabs,Index Maker 5,1.75,0.5,8.5,11,0.5,0.25,0.3,0,0,0,1,4,0.3,2.35,4.4,6.45',
'Tabs,Index Maker 8,1.13,0.5,8.5,11,0.5,0.25,0.5,0,0,0,1,4,0.5,2.63,4.76,6.89',
'Tabs,Protect-N Tab 8,1.38,0.65,8.5,11,0.29,0,6.05,0,0,0,1,1,6.05',
'Tabs,Ready Index 5,3,1.88,8.5,11,0.63,0,5.13,0,0,0.12,1,1,5.13',
'Tabs,Ready Index 8,3,1.13,8.5,11,0.78,0,5.13,0,0,0.09,1,1,5.13',
'Tabs,Ready Index 10,3,0.88,8.5,11,0.63,0,5.13,0,0,0.12,1,1,5.13',
'Tabs,Ready Index 12,3,0.84,8.5,11,0.5,0,5.13,0,0,0,1,1,5.13',
'Tabs,Ready Index 15,3,0.47,8.5,11,0.94,0,5.13,0,0,0.16,1,1,5.13',
'Tabs,Ready Index Spine 1" ,9.5,0.88,11,8.5,0.88,6.74,0.75,0,1,0,1,1,0.75',
'Tabs,Ready Index Spine 1.5" ,9.5,1.13,11,8.5,1.75,5.62,0.75,0,1,0,1,1,0.75',
'Tabs,Ready Index Spine 2" ,9.5,1.88,11,8.5,3.13,3.49,0.75,0,1,0,1,1,0.75',
'Tabs,Ready Index Spine 3" ,9.5,2.65,11,8.5,5,0,0.75,0,1,0,1,1,0.75',
'Tabs,Self Adhesive Tab 1" ,1,0.34,8.5,11,0.5,5.4,1,0,0,0,1,2,1,2',
'Tabs,Self Adhesive Tab 1.5" ,1.5,0.34,8.5,11,0.5,5.4,0.5,0,0,0,1,2,0.5,2',
'Tabs,Self Adhesive Tab 2" ,2,0.34,8.5,11,0.5,5.4,0.13,0,0,0,1,2,0.13,2.13',
'Tabs,Title Frame Spine 1" ,10,1,11,8.5,1.25,2.75,0.5,0,1,0,1,1,0.5',
'Tabs,Title Frame Spine 1.5" ,10,1.5,11,8.5,1.25,0,0.5,0,1,0,1,1,0.5',
'Tabs,Work Saver 5,2,0.33,8.5,11,0.5,5.55,0.25,0,0,0,1,4,0.25,2.25,4.25,6.25',
'Tabs,Work Saver 8,1.5,0.33,8.5,11,0.5,5.55,0.75,0,0,0,1,2,0.75,2.25',
'Tabs,Work Saver Inserts One Third Cut ,3.5,0.5,8.5,11,1,5,0.75,0,0,0,1,2,0.75,4.25',
'Tabs,Work Saver Inserts One Fifth Cut ,2,0.5,8.5,11,1,5,0.25,0,0,0,1,2,0.25,2.25'
);


  caAveryStdDotMatrix: array [0..39] of String = (

'Address,4010,3.5,0.94,4.25,1,0,0,0.38,0,0,0.06,1,0',
'Address,4011,4,1.44,4.75,1.5,0,0,0.38,0,0,0.06,1,0',
'Address,4013,3.5,0.94,4.25,12,0,0,0.38,0,0,0.06,1,0',
'Address,4143,4,0.94,9.5,12,0,0,0.7,0,0,0.06,1,2,0.7,4.8',
'Address,4144,2.5,0.94,9.5,12,0,0,0.9,0,0,0.06,1,3,0.9,3.5,6.1',
'Address,4145,3.5,0.94,4.5,6,0,0,0.5,0,0,0.06,1,0',
'Address,4146,4,1.44,4.75,6,0,0,0.38,0,0,0.06,1,0',
'Name Badge,4160,3.5,2.44,4.25,5,0,0,0.38,0,0,0.06,1,0',
'Shipping,4161,4,2.94,4.75,6,0,0,0.38,0,0,0.06,1,0',
'Address,4162,3.5,0.94,4.25,6,0,0,0.38,0,0,0.06,1,0',
'Address,4163,3.5,0.94,4.25,6,0,0,0.38,0,0,0.06,1,0',
'Index Card,4166,5,3,6,6,0,0,0.5,0,0,0,1,0',
'Post Card,4167,6,3.5,7,7,0,0,0.5,0,0,0,1,0',
'Rotary Card,4168,4,2.17,5,6.5,0,0,0.5,0,0,0,1,0',
'Rotary Card,4169,5,3,6,6,0,0,0.5,0,0,0,1,0',
'Diskette,4240,4.75,1.25,5.75,6,0,0,0.5,0,0,0.25,1,0',
'Diskette,4241,2.75,2.75,4.5,6,0,0,0.88,0,0,0.25,1,0',
'Address,4249,3.5,0.94,4.5,6,0,0,0.5,0,0,0.06,1,0',
'Address,4250,3.5,0.94,4.5,6,0,0,0.5,0,0,0.06,1,0',
'Address,4251,3.5,0.94,4.5,6,0,0,0.5,0,0,0.06,1,0',
'Address,4253,3.5,0.94,4.5,6,0,0,0.5,0,0,0.06,1,0',
'Address,4254,3.5,0.94,4.5,6,0,0,0.5,0,0,0.06,1,0',
'File Folder,4255,3.5,0.44,4.5,6,0,0,0.5,0,0,0.06,1,0',
'File Folder,4256,3.5,0.44,4.5,6,0,0,0.5,0,0,0.06,1,0',
'File Folder,4257,3.5,0.44,4.5,6,0,0,0.5,0,0,0.06,1,0',
'File Folder,4258,3.5,0.44,4.5,0.5,0,0,0.5,0,0,0.06,1,0',
'File Folder,4259,3.5,0.44,4.5,0.5,0,0,0.5,0,0,0.06,1,0',
'File Folder,4266,3.5,0.44,4.5,0.5,0,0,0.5,0,0,0.06,1,0',
'Address,4600,3.5,0.94,4.5,6,0,0,0.5,0,0,0.06,1,0',
'Address,4601,3.5,0.94,4.25,6,0,0,0.38,0,0,0.06,1,0',
'Address,4602,3.5,0.94,8.1,12,0,0,0.5,0,0,0.06,1,2,0.5,4.1',
'Address,4603,3.5,0.94,11.5,12,0,0,0.4,0,0,0.06,1,3,0.4,4,7.6',
'Address,4604,4,1.44,4.75,6,0,0,0.38,0,0,0.06,1,0',
'Address,4605,4,1.44,8.9,12,0,0,0.4,0,0,0.06,1,2,0.4,4.5',
'Diskette,4606,4.75,1.25,5.75,6,0,0,0.5,0,0,0.25,1,0',
'Diskette,4607,2.75,2.75,4.5,6,0,0,0.88,0,0,0.25,1,0',
'Price Marking,4609,1.5,0.38,8.9,12,0,0,0.5,0,0,0.12,1,5,0.5,2.1,3.7,5.3,6.9',
'Address,4610,2.5,0.94,9.5,12,0,0,0.9,0,0,0.06,1,3,0.9,3.5,6.1',
'Address,4611,4,0.94,9.5,12,0,0,0.7,0,0,0.06,1,2,0.7,4.8',
'Shipping,4612,4,2.94,4.75,6,0,0,0.38,0,0,0.06,1,0'
);

{******************************************************************************
 *
 ** A V E R Y  S T A N D A R D   L A S E R J E T
  *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAveryStdLaserJetLabels.Product }

class function TppAveryStdLaserJetLabels.Product: String;
begin
  Result := 'Avery Standard';
end; {class function, Product}

{------------------------------------------------------------------------------}
{ TppAveryStdLaserJetLabels.Count }

class function TppAveryStdLaserJetLabels.Count: Integer;
begin
  Result := High(caAveryStdLaserJet) + 1;
end; {class function, Count}

{------------------------------------------------------------------------------}
{ TppAveryStdLaserJetLabels.GetLabelDef }

class function TppAveryStdLaserJetLabels.GetLabelDef(aIndex: Integer): String;
begin
  Result := caAveryStdLaserJet[aIndex];
end; {class function, GetLabelDef}

{******************************************************************************
 *
 ** A V E R Y  S T A N D A R D   D O T M A T R I X
  *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAveryStdDotMatrixLabels.Product }

class function TppAveryStdDotMatrixLabels.Product: String;
begin
  Result := 'Avery Standard';
end; {class function, Product}

{------------------------------------------------------------------------------}
{ TppAveryStdDotMatrixLabels.Count }

class function TppAveryStdDotMatrixLabels.Count: Integer;
begin
  Result := High(caAveryStdDotMatrix) + 1;
end; {class function, Count}

{------------------------------------------------------------------------------}
{ TppAveryStdDotMatrixLabels.GetLabelDef }

class function TppAveryStdDotMatrixLabels.GetLabelDef(aIndex: Integer): String;
begin
  Result := caAveryStdDotMatrix[aIndex];
end; {class function, GetLabelDef}


initialization

  ppRegisterLabelSet(TppAveryStdDotMatrixLabels);
  ppRegisterLabelSet(TppAveryStdLaserJetLabels);

finalization
  ppUnRegisterLabelSet(TppAveryStdDotMatrixLabels);
  ppUnRegisterLabelSet(TppAveryStdLaserJetLabels);

end.
 
