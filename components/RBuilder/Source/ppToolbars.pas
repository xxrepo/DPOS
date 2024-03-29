{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit ppToolbars;

interface
                                    
{$I ppIfDef.pas}

{x$DEFINE CodeSite}

uses
  {$IFDEF CodeSite}CodeSite.Interop,{$ENDIF}
  Windows,
  Messages,
  Types,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  ExtCtrls,
  Menus,
  ToolWin,
  {$IFDEF Delphi7}Themes,{$ENDIF}

  ppTypes,
  ppIniStorage,
  ppClass,
  ppUtils;

type

  TppToolbar = class;
  TppDropDownPanel = class;
  TppToolbarButton = class;

  TppToolbarClass = class of TppToolbar;

  {TppCustomToolWindow
    - ancestor to floating tool windows and palettes}

  TppCustomToolWindow = class(TForm)
  private
    FLanguageIndex: Longint;
    FOnHelp: TppHelpEvent;
    FOnVisibleChanged: TNotifyEvent;

  protected
    // overriden from ancetor
    procedure SetParent(AParent: TWinControl); override;
    procedure DoEndDrag(Target:TObject; X, Y: Integer); override;
    procedure DoEndDock(Target: TObject; X, Y: Integer); override;
    procedure DoStartDock(var DragObject: TDragObject); override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;

    procedure AfterParentChange; virtual;
    procedure BeforeParentChange; virtual;
    procedure DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean); virtual;
    procedure DoVisibleChanged; virtual;
    procedure SetLanguageIndex(aLanguageIndex: Longint); virtual;


  public
    constructor Create(aOwner: TComponent); override;

    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure LoadPreferences(aIniStorage: TppIniStorage); virtual;
    procedure SavePreferences(aIniStorage: TppIniStorage); virtual;

    property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;

    property OnHelp: TppHelpEvent read FOnHelp write FOnHelp;
    property OnVisibleChanged: TNotifyEvent read FOnVisibleChanged write FOnVisibleChanged;

  end;


  {TppToolPaletteWindow

    floating tool palette window (not dockable)
      - used to implement tear away color palette}
  TppToolPaletteWindow = class(TppCustomToolWindow)
  end;


  {TppToolWindow

     dockable tool window
       - descendants include Report Tree and Data Tree}

  TppToolWindow = class(TppCustomToolWindow)
  protected
    procedure DoDock(NewDockSite: TWinControl; var ARect: TRect); override;

  public
    constructor Create(aOwner: TComponent); override;

  end;


  {@TppToolImageList }
  TppToolImageList = class(TImageList)
  private
    FToolNames: TStrings;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ExtractImageWithMask(Index: Integer; Image, Mask: TBitmap);

    function IndexOfTool(aToolName: String): Integer;
    function AddTool(const aToolName: String): Integer;
    function AddToolWithMask(const aToolName, aMaskName: String): Integer;

  end;



  {@TppDropDownPanel }
  TppDropDownPanel = class(TPanel)
  private
    FActiveCaption: Boolean;
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FToolWindow: TppToolPaletteWindow;
    FTearAway: Boolean;
    FTitleBarHint: String;
    FOnToolWindowActivate: TNotifyEvent;
    FOnToolWindowCreate: TNotifyEvent;
    FOnToolWindowShow: TNotifyEvent;
    FOnToolWindowHide: TNotifyEvent;

    function  GetTitleBarRect: TRect;
    function IsActiveCaption(aPoint: TPoint): Boolean;
    procedure SetTearAway(aValue: Boolean);

    {message stuff}
    procedure CMVisibleChanged (var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMMouseActivate (var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;

    procedure PaintTitleBar;
    procedure ToolWindowVisibleChangedEvent(Sender: TObject);

  protected

    procedure Paint; override;
    procedure CreateParams (var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ActivateToolWindow; virtual;
    procedure CreateToolWindow;   virtual;
    procedure FreeToolWindow;     virtual;

    procedure DoCancelHint;
    procedure DoShowHint;

    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;

    property ToolWindow: TppToolPaletteWindow read FToolWindow;

    property TearAway: Boolean read FTearAway write SetTearAway;
    property TitleBarHint: String read FTitleBarHint write FTitleBarHint;

    property OnToolWindowActivate: TNotifyEvent read FOnToolWindowActivate write FOnToolWindowActivate;
    property OnToolWindowCreate: TNotifyEvent read FOnToolWindowCreate  write FOnToolWindowCreate;
    property OnToolWindowShow: TNotifyEvent read FOnToolWindowShow write FOnToolWindowShow;
    property OnToolWindowHide: TNotifyEvent read FOnToolWindowHide write FOnToolWindowHide;

  end; {class, TppDropDownPanel}



  {@TppToolbarButton }
  TppToolbarButton = class(TToolButton)
  private
    FActive: Boolean;
    FMouseDownPos: TPoint;
    FDropDownPanel: TppDropDownPanel;
    FMenuIsDown: Boolean;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;


    function  GetToolbar: TppToolbar;
    procedure SetDropdownPanel(Value: TppDropDownPanel);
    procedure SetActive(aValue: Boolean);
    procedure ShowDropDownPanel;
    
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;

    procedure DoMouseLeave;
    procedure DoMouseEnter;

    procedure DropDownPanelMouseLeaveEvent(Sender: TObject);
    procedure DropDownPanelMouseEnterEvent(Sender: TObject);

  protected
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure MouseEntered;
    procedure MouseLeft; 

    procedure SetParent(aParent: TWinControl); override;

    {can be overridden by descendants to create an on demand create/destroy of
    drop down panels for efficiency}
    procedure DropDownPanelShowEvent(Sender: TObject); virtual;
    procedure DropDownPanelHideEvent(Sender: TObject); virtual;
    function GetDropDownPanel: TppDropDownPanel; virtual;

    property MenuIsDown: Boolean read FMenuIsDown write FMenuIsDown;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;


  public
    constructor Create(AOwner: TComponent); override;

    procedure Click; override;

    property Active: Boolean read FActive write SetActive;
    property ToolBar: TppToolbar read GetToolbar;

  published
    property DropDownPanel: TppDropDownPanel read GetDropDownPanel write SetDropdownPanel;

  end; {class, TppToolbarButton}


  {@TppToolbarSeparator }
  TppToolbarSeparator = class(TToolButton)
  private
  public
    constructor Create(AOwner: TComponent); override;

  end;

  TppToolbarOrientation = (toHorizontal, toVertical);

  {@TppToolbar }
  TppToolbar = class(TToolbar)
  private
    FActiveButton: TppToolbarButton;
    FLanguageIndex: Longint;
    FTimer: TTimer;
    FInitialized: Boolean;
    FDockRow: Integer;
    FOrientation: TppToolbarOrientation;
    FOnFloat: TNotifyEvent;
    FDragObject: TDragDockObject;

    function GetActive: Boolean;
    procedure TimerEvent(Sender: TObject);

    procedure Initialize;
    function GetRightMostControl: TControl;
    function GetRightMostControlPos: Integer;
    procedure OrientVertically;
    function GetBottomMostControl: TControl;
    procedure SetOrientation(const Value: TppToolbarOrientation);
    function GetHorizontalBoundsRect: TRect;
    function GetVerticalBoundsRect: TRect;

  protected
    function GetBottomMostControlPos: Integer;

    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure DoDock(NewDockSite: TWinControl; var ARect: TRect); override;
    procedure DoStartDock(var DragObject: TDragObject); override;
    procedure DoEndDock(Target: TObject; X, Y: Integer); override;

    procedure CreateControls; virtual;
    procedure SetLanguageIndex(aLanguageIndex: Longint); virtual;
    procedure SetParent(Parent: TWinControl); override;

    procedure ButtonActivateEvent(Sender: TObject);
    procedure ButtonDeactivateEvent(Sender: TObject);
    procedure ButtonMouseLeaveEvent(Sender: TObject);
    procedure ButtonMouseEnterEvent(Sender: TObject);

    procedure DoOnFloat; virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure WMMove(var Message: TWMMove); message WM_MOVE;

    procedure LoadPreferences(aIniStorage: TppIniStorage); virtual;
    procedure SavePreferences(aIniStorage: TppIniStorage); virtual;

    procedure AddControl(aControl: TControl);
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;

    property ActiveButton: TppToolbarButton read FActiveButton;
    property Active: Boolean read GetActive;
    property Orientation: TppToolbarOrientation read FOrientation write SetOrientation;
    property VerticalBoundsRect: TRect read GetVerticalBoundsRect;
    property HorizontalBoundsRect: TRect read GetHorizontalBoundsRect;

    property DockRow: Integer read FDockRow write FDockRow;
    property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;

    property OnFloat: TNotifyEvent read FOnFloat write FOnFloat;
  end; {class, TppToolbar}



  {@TppToolbarDragDockObject
     - created when a toolbar is dragged }
  TppToolbarDragDockObject = class(TDragDockObject)
  private
    FCursorPos: TPoint;
  protected
    procedure DrawDragDockImage; override;
    procedure AdjustDockRect(ARect: TRect);  override;
    procedure EraseDragDockImage; override;
  public
    constructor Create(AControl: TControl); override;
  end;



  {@TppHorizontalDock }
  TppHorizontalDock = class(TControlBar)
    private
      procedure ehGetSiteInfo(Sender: TObject; DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);

    protected
{$IFDEF xCodeSite}
      procedure WndProc(var Message: TMessage); override;
      procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
      procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
{$ENDIF}
    public
      constructor Create(aOwner: TComponent); override;
{$IFDEF xCodeSite}
      procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
{$ENDIF}

  end;



  {@TppVerticalDock
     - TPanel descendant used as a docksite for ToolWindows}
     
  TppVerticalDock = class(TPanel)
  private
    FSplitter: TSplitter;
    FVisibleWidth: Integer;

    procedure AddSplitter;
    procedure RemoveSplitter;
    procedure HideDock;
    procedure ShowDock;

    procedure ehDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
    procedure ehDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ehGetSiteInfo(Sender: TObject; DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);

  protected
    procedure AlignControls (aControl: TControl; var Rect: TRect); override;
    function GetVisibleDockClientCount: Integer;
    function CreateDockManager: IDockManager; override;

    procedure Notification(aComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property VisibleWidth: Integer read FVisibleWidth;

  end; {class, TppVerticalDock}


  {@TppVerticalDockTree
       - DockTree descendant}

  TppVerticalDockTree = class(TDockTree)
  private
  protected
    procedure PaintDockFrame(Canvas: TCanvas; Control: TControl; const ARect: TRect); override;
    procedure AdjustDockRect(Control: TControl; var ARect: TRect); override;
//TODO    procedure WndProc(var Message: TMessage); override;
  public
  end;


  {@TppVerticalToolbarDockTree }
  TppVerticalToolbarDockTree = class(TDockTree)
  private
  protected
    procedure PaintDockFrame(Canvas: TCanvas; Control: TControl; const ARect: TRect); override;
    procedure PositionDockRect(Client, DropCtl: TControl; DropAlign: TAlign; var DockRect: TRect); override;
  public
  end;


  {@TppVerticalToolbarDock }
  TppVerticalToolbarDock = class(TPanel)
  private
    FVisibleWidth: Integer;
    FDockTree: TppVerticalToolbarDockTree;

    procedure HideDock;
    procedure ShowDock;

    procedure ehDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
    procedure ehDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ehGetSiteInfo(Sender: TObject; DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);

  protected
    procedure AlignControls (aControl: TControl; var Rect: TRect); override;
    function GetDockEdge(MousePos: TPoint): TAlign; override;
    function GetVisibleDockClientCount: Integer;

    procedure Notification(aComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;


  end;



  TppHintTimerType = (ttCancel, ttShow);

  {@TppHintTimer }
  TppHintTimer = class(TTimer)
  private
    FTimerType: TppHintTimerType;

    procedure TimerEvent(Sender: TObject);

  public
    constructor Create(aOwner: TComponent); override;
    
    property TimerType: TppHintTimerType read FTimerType write FTimerType;

  end; {class, TppHintTimer}


  function ShowHintTimer: TppHintTimer;
  function CancelHintTimer: TppHintTimer;
  function ToolImageList: TppToolImageList;



var
  ppCustomToolWindow: TppCustomToolWindow;

implementation

const cDropdownComboWidth = 11;

var
  FShowHintTimer: TppHintTimer;
  FCancelHintTimer: TppHintTimer;
  FHintWindow: THintWindow;
  FToolImageList: TppToolImageList;


{$R *.dfm}

{******************************************************************************
 *
 **  C U S T O M   T O O L   W I N D O W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.Create}

constructor TppCustomToolWindow.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FOnHelp := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.SetParent}

procedure TppCustomToolWindow.SetParent(AParent: TWinControl);
var
  lbParentChanging: Boolean;
begin

  lbParentChanging := (Parent <> aParent) and not(csDestroying in ComponentState);

  if lbParentChanging then
    try
      BeforeParentChange;

      inherited;

    finally
      AfterParentChange;
    end
  else
    inherited;

end;

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.BeforeParentChange}

procedure TppCustomToolWindow.BeforeParentChange;
begin

end;

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.AfterParentChange}

procedure TppCustomToolWindow.AfterParentChange;
begin

end;

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.DoOnHelp}

procedure TppCustomToolWindow.DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);
begin
  {fire the help event}
  if Assigned(FOnHelp) then FOnHelp(Sender, aHelpFile, aKeyphrase, aCallHelp);

end; {procedure, DoOnHelp}

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.SetLanguageIndex}

procedure TppCustomToolWindow.SetLanguageIndex(aLanguageIndex: Longint);
begin
  FLanguageIndex := aLanguageIndex;
end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.LoadPreferences}

procedure TppCustomToolWindow.LoadPreferences(aIniStorage: TppIniStorage);
begin

  Top := aIniStorage.ReadInteger(Name, 'Top', Top);
  Left := aIniStorage.ReadInteger(Name, 'Left', Left);

  UnDockWidth := aIniStorage.ReadInteger(Name, 'UnDockWidth', Width);
  UnDockHeight := aIniStorage.ReadInteger(Name, 'UnDockHeight', Height);

end; {procedure, LoadPreferences}

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.SavePreferences}

procedure TppCustomToolWindow.SavePreferences(aIniStorage: TppIniStorage);
begin

  aIniStorage.WriteInteger(Name, 'Top', Top);
  aIniStorage.WriteInteger(Name, 'Left', Left);
  aIniStorage.WriteInteger(Name, 'UnDockWidth', UnDockWidth);
  aIniStorage.WriteInteger(Name, 'UnDockHeight', UnDockHeight);

end; {procedure, SavePreferences}


{------------------------------------------------------------------------------}
{ TppCustomToolWindow.CMVisibleChanged}

procedure TppCustomToolWindow.CMVisibleChanged(var Message: TMessage);
begin
{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppCustomToolWindow.CMVisibleChanged');
{$ENDIF}

  if (Floating) and not(csDestroying in ComponentState) then
    DoVisibleChanged;

  inherited;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppCustomToolWindow.CMVisibleChanged');
{$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.DoVisibleChanged}

procedure TppCustomToolWindow.DoVisibleChanged;
begin
  if Assigned(FOnVisibleChanged) then FOnVisibleChanged(Self);

end;

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.DoEndDrag}

procedure TppCustomToolWindow.DoEndDrag(Target:TObject; X, Y: Integer);
begin

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppCustomToolWindow.DoEndDrag');
{$ENDIF}
 inherited;

  // return focus to designer
  if not(csDestroying in ComponentState) then
    TForm(Owner).SetFocus;
//      SendMessage(TForm(Owner).Handle, WM_Activate, WA_ACTIVE, 0);

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppCustomToolWindow.DoEndDrag');
{$ENDIF}


end;

{------------------------------------------------------------------------------}
{ TppCustomToolWindow.DoEndDock}

procedure TppCustomToolWindow.DoEndDock(Target:TObject; X, Y: Integer);
begin
{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppCustomToolWindow.DoEndDock');
{$ENDIF}

   inherited;

//TODO  ExceptionUtils.IgnoreExceptions(False);

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppCustomToolWindow.DoEndDock');
{$ENDIF}

end;


procedure TppCustomToolWindow.DoStartDock(var DragObject: TDragObject);
begin
{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppCustomToolWindow.DoStartDock');
{$ENDIF}

  inherited;

//TODO  ExceptionUtils.IgnoreExceptions(True);
  DragObject := TDragDockObject.Create(Self);
//  gCodeSite.Send('DragObject: '+ DragObject.ClassName);


{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppCustomToolWindow.DoStartDock');
{$ENDIF}

end;


procedure TppCustomToolWindow.DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean); 
begin
{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppCustomToolWindow.DockOver');
{$ENDIF}

  inherited;

  Accept := False;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppCustomToolWindow.DockOver');
{$ENDIF}

end;


{******************************************************************************
 *
 **  T O O L   W I N D O W
 *
{******************************************************************************}

{ TppToolWindow }

{------------------------------------------------------------------------------}
{ TppToolWindow.LoadPreferences}

constructor TppToolWindow.Create(aOwner: TComponent);
begin
  inherited;

//  DoubleBuffered := True;

  BorderStyle := bsSizeToolWin;

end;

{------------------------------------------------------------------------------}
{ TppToolWindow.DoDock}

procedure TppToolWindow.DoDock(NewDockSite: TWinControl; var ARect: TRect);
begin

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('DoDock');
{$ENDIF}

  inherited;

  // set BorderStyle base on whether tool window is docked
  if NewDockSite <> nil then
    BorderStyle := bsNone
  else
    BorderStyle := bsSizeToolWin;


{$IFDEF CodeSite}
  gCodeSite.ExitMethod('DoDock');
{$ENDIF}

end;

{******************************************************************************
 *
 **  T O O L   I M A G E    L I S T
 *
{******************************************************************************}

{ TppToolImageList.Create }

constructor TppToolImageList.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FToolNames := TStringList.Create;

  Clear;

end;

{ TppToolImageList.Destroy }

destructor TppToolImageList.Destroy;
begin

  FToolNames.Free;

  inherited Destroy;
end;

{ TppToolImageList.IndexOfTool }

function TppToolImageList.IndexOfTool(aToolName: String): Integer;
begin
  Result := FToolNames.IndexOf(aToolName);
end;

{ TppToolImageList.AddTool }

function TppToolImageList.AddTool(const aToolName: String): Integer;
var
  lBitmap: TBitmap;
begin

  lBitmap := TBitmap.Create;

  try
    //ResourceUtils.LoadBitmap(lBitmap, aToolName);
    lBitmap.Handle := ppBitmapFromResource(aToolName);

    if (lBitmap.Handle = 0) then
      lBitmap.Handle := ppBitmapFromResource('PPNOBITMAP');

    lBitmap.Width := Width;
    lBitmap.Height := Height;

    AddMasked(lBitmap, clSilver);

    FToolNames.Add(aToolName);


  finally
    lBitmap.Free;

  end;

  Result := FToolNames.Count - 1;

end;

{ TppToolImageList.AddToolWithMask }

function TppToolImageList.AddToolWithMask(const aToolName, aMaskName: String): Integer;
var
  lBitmap: TBitmap;
  lMask: TBitmap;
begin

  lBitmap := TBitmap.Create;
  lMask   := TBitmap.Create;

  try
    lBitmap.Handle := ppBitmapFromResource(aToolName);
    lMask.Handle := ppBitmapFromResource(aMaskName);

//    ResourceUtils.LoadBitmap(lBitmap, aToolName);
//    ResourceUtils.LoadBitmap(lMask, aMaskName);

    Add(lBitmap, lMask);

    FToolNames.Add(aToolName);

  finally
    lBitmap.Free;
    lMask.Free;

  end;

  Result := FToolNames.Count - 1;

end;

{ TppToolImageList.ExtractImageWithMask }

procedure TppToolImageList.ExtractImageWithMask(Index: Integer; Image, Mask: TBitmap);
begin

  GetImages(Index, Image, Mask);

end;

{*****************************************************************************
 *
 **  H O R I Z O N T A L    D O C K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppHorizontalDock.Create}

constructor TppHorizontalDock.Create(aOwner: TComponent);
begin
  inherited;

  AutoSize := True;
  BevelInner := bvNone;
  BevelKind := bkNone;
  RowSnap := True;

{$IFDEF Delphi7}
  ParentBackground := False;
{$ENDIF}

  OnGetSiteInfo := ehGetSiteInfo;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalDock.ehGetSiteInfo}

procedure TppHorizontalDock.ehGetSiteInfo(Sender: TObject; DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := (DockClient <> nil) and (DockClient is TppToolbar);

end;

{$IFDEF xCodeSite}
{------------------------------------------------------------------------------}
{ TppHorizontalDock.WndProc}

procedure TppHorizontalDock.WndProc(var Message: TMessage);
begin
    inherited;
exit;

  if (Message.Msg = 45359) then
    gCodeSite.Send('Message.Msg = '+ IntToStr(Message.Msg));

  try

  except
{$IFDEF CodeSite}
    gCodeSite.Send('TppHorizontalDock.WndProc - exception thrown');
    gCodeSite.Send('Message.Msg = '+ IntToStr(Message.Msg));
{$ENDIF}
  end;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalDock.CMDrag}

procedure TppHorizontalDock.CMDrag(var Message: TCMDrag);
var
  lsMessage: String;
  lObject: TObject;
begin

  inherited;
  Exit;
  

  try

    case Message.DragMessage of

      dmDragEnter, dmDragLeave, dmDragMove, dmDragDrop:
        begin
          if (Message.DragRec = nil) then
            lsMessage := 'Message.DragRec is nil'

          else if (Message.DragRec.Target = nil) then
            lsMessage := 'Message.DragRec.Target is nil'
          else
            begin
              lObject := Message.DragRec.Target;

              if not (lObject is TControl) then
                lsMessage := 'Message.DragRec.Target is not TControl'

              else
                lsMessage := '???';

            end;
//          else

//          lsMessage := #13#10 + 'dmDragEnter, dmDragLeave, dmDragMove, dmDragDrop';
        end;

      dmFindTarget:
        lsMessage :=  'dmFindTarget';

    end;

    inherited;

  except
{$IFDEF CodeSite}
    gCodeSite.Send('CMDrag exception: ' + lsMessage);
{$ENDIF}
  end;

end;

procedure TppHorizontalDock.DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  try
    inherited;

  except
{$IFDEF CodeSite}
    gCodeSite.Send('TppHorizontalDock.DockOver - exception thrown');
{$ENDIF}
  end;

end;

procedure TppHorizontalDock.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  try
    inherited;

  except
{$IFDEF CodeSite}
    gCodeSite.Send('TppHorizontalDock.DragOver - exception thrown');
{$ENDIF}
  end;

end;

{$ENDIF}


{******************************************************************************
 *
 **  V E R T I C A L   D O C K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppVerticalDock.Create}

constructor TppVerticalDock.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DockSite := True;
  DockOrientation := doHorizontal;
  FSplitter := nil;
  FVisibleWidth := 0;
  Width := 0;
//  DoubleBuffered := True;

  OnDockDrop := ehDockDrop;
  OnDockOver := ehDockOver;
  OnGetSiteInfo := ehGetSiteInfo;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppVerticalDock.Destroy}

destructor TppVerticalDock.Destroy;
begin

  FSplitter := nil;

  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TppVerticalDock.Notification}

procedure TppVerticalDock.Notification(AComponent: TComponent; Operation: TOperation);
begin

  inherited Notification(aComponent, Operation);

  if (aComponent = FSplitter) and (Operation = opRemove) then
    FSplitter := nil;

end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TppVerticalDock.GetVisibleDockClientCount}

function TppVerticalDock.CreateDockManager: IDockManager;
begin
{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppVerticalDock.CreateDockManager');
{$ENDIF}

  if (DockManager = nil) then
    Result := TppVerticalDockTree.Create(Self)
  else
    Result := inherited CreateDockManager;
  
{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppVerticalDock.CreateDockManager');
{$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppVerticalDock.GetVisibleDockClientCount}

function TppVerticalDock.GetVisibleDockClientCount: Integer;
var
  liIndex: Integer;
begin

  Result := 0;

  for liIndex := 0 to DockClientCount-1 do
    if DockClients[liIndex].Visible then
      Inc(Result);

end;

{------------------------------------------------------------------------------}
{ TppVerticalDock.AlignControls}

procedure TppVerticalDock.AlignControls(AControl: TControl; var Rect: TRect);
var
  liVisibleClientCount: Integer;
begin

{$IFDEF CodeSite}
//  gCodeSite.EnterMethod('TppVerticalDock.AlignControls');
{$ENDIF}

  inherited AlignControls(aControl, Rect);

  if not (csDestroying in ComponentState) then
    begin
      liVisibleClientCount := GetVisibleDockClientCount;

      {handle case in which visibility of tool windows is toggled}
      if (liVisibleClientCount = 0) then
        HideDock
      else if (liVisibleClientCount = 1) then
        ShowDock;

    end;


{$IFDEF CodeSite}
//  gCodeSite.ExitMethod('TppVerticalDock.AlignControls');
{$ENDIF}

end;  {procedure, AlignControls}

{------------------------------------------------------------------------------}
{ TppVerticalDock.AddSplitter}

procedure TppVerticalDock.AddSplitter;
begin
{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppVerticalDock.AddSplitter');
{$ENDIF}

  if (FSplitter <> nil) then
    begin
      FSplitter.Enabled := True;
    end
  else
    begin
      FSplitter := TSplitter.Create(nil);
      FSplitter.FreeNotification(Self);
      FSplitter.Parent := Parent;
      FSplitter.Width  := 2;
    end;

  if (Align = alLeft) then
    FSplitter.Left   := Left + FVisibleWidth + 1
  else
    begin
      FSplitter.Left := Left - 1;
      FSplitter.Align := alRight;
    end;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppVerticalDock.AddSplitter');
{$ENDIF}

end;  {procedure, AddSplitter}

{------------------------------------------------------------------------------}
{ TppVerticalDock.RemoveSplitter}

procedure TppVerticalDock.RemoveSplitter;
begin

  if (FSplitter <> nil) then
    FSplitter.Enabled := False;

//  FSplitter.Free;
//  FSplitter := nil;

end;  {procedure, RemoveSplitter}

{------------------------------------------------------------------------------}
{ TppVerticalDock.ehGetSiteInfo}

procedure TppVerticalDock.ehGetSiteInfo(Sender: TObject; DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := (DockClient <> nil) and (DockClient is TppToolWindow);

end;

{------------------------------------------------------------------------------}
{ TppVerticalDock.ehDockOver}

procedure TppVerticalDock.ehDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState;var Accept: Boolean);
var
  liControlWidth: Integer;
  lDockRect: TRect;
begin
{$IFDEF CodeSite}
//  gCodeSite.EnterMethod('TppVerticalDock.ehDockOver');
{$ENDIF}

  Accept := (Source.Control <> nil) and (Source.Control is TppToolWindow);

  if Accept and (GetVisibleDockClientCount = 0) then
    begin
      liControlWidth := Source.Control.Width;

       //Modify Source.DockRect display preview of dock area.
      if Align = alLeft then
        begin
          lDockRect.TopLeft := ClientToScreen(Point(0, 0));
          lDockRect.BottomRight := ClientToScreen(Point(liControlWidth, Height));
        end
      else // if Align = alLeft then
        begin
          lDockRect.TopLeft := ClientToScreen(Point(Width-liControlWidth, 0));
          lDockRect.BottomRight := ClientToScreen(Point(Width, Height));

        end;

      Source.DockRect := lDockRect;
    end;
{$IFDEF CodeSite}
//  gCodeSite.ExitMethod('TppVerticalDock.ehDockOver');
{$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppVerticalDock.ehDockDrop}

procedure TppVerticalDock.ehDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
begin
  //OnDockDrop gets called AFTER the client has actually docked,
  //so we check for DockClientCount = 1 before making the dock panel visible.

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppVerticalDock.ehDockDrop');
{$ENDIF}

  // show the dock panel
  if DockClientCount = 1 then
    begin
      FVisibleWidth := Source.DockRect.Right - Source.DockRect.Left;
      ShowDock;
    end

  else
    // tell dock manager to repaint clients
    DockManager.ResetBounds(True);

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppVerticalDock.ehDockDrop');
{$ENDIF}
end;

{------------------------------------------------------------------------------}
{ TppVerticalDock.ShowDock}

procedure TppVerticalDock.ShowDock;
begin

  if Width > 0 then Exit;

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppVerticalDock.ShowDock');
{$ENDIF}

  DockManager.BeginUpdate;

  Width := FVisibleWidth;
  AddSplitter;
  DockManager.ResetBounds(True);
  DockManager.EndUpdate;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppVerticalDock.ShowDock');
{$ENDIF}
end;

{------------------------------------------------------------------------------}
{ TppVerticalDock.HideDock}

procedure TppVerticalDock.HideDock;
begin
  if Width = 0 then Exit;

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppVerticalDock.HideDock');
{$ENDIF}

  DockManager.BeginUpdate;

  FVisibleWidth := Width;
  Width := 0;
  RemoveSplitter;
  DockManager.EndUpdate;
  DockManager.ResetBounds(True);

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppVerticalDock.HideDock');
{$ENDIF}

end;

{******************************************************************************
 *
 **  V E R T I C A L   D O C K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.Create}

constructor TppVerticalToolbarDock.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DockSite := True;
  DockOrientation := doHorizontal;
  FVisibleWidth := 0;
  Width := 0;
  FDockTree := TppVerticalToolbarDockTree.Create(Self);
  DockManager := FDockTree;

  OnDockDrop := ehDockDrop;
  OnDockOver := ehDockOver;
  OnGetSiteInfo := ehGetSiteInfo;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.Destroy}

destructor TppVerticalToolbarDock.Destroy;
begin

  DockManager := nil;
//  FDockTree.Free;
//  FDockTree := nil;
  
  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.Notification}

procedure TppVerticalToolbarDock.Notification(AComponent: TComponent; Operation: TOperation);
begin

  inherited Notification(aComponent, Operation);


end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.GetVisibleDockClientCount}

function TppVerticalToolbarDock.GetVisibleDockClientCount: Integer;
var
  liIndex: Integer;
begin

  Result := 0;

  for liIndex := 0 to DockClientCount-1 do
    if DockClients[liIndex].Visible then
      Inc(Result);

end;

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.AlignControls}

procedure TppVerticalToolbarDock.AlignControls (AControl: TControl; var Rect: TRect);
var
  liVisibleClientCount: Integer;
begin

  if not (csDestroying in ComponentState) then
    begin
      liVisibleClientCount := GetVisibleDockClientCount;

      {handle case in which visibility of tool windows is toggled}
      if (liVisibleClientCount = 0) then
        HideDock
      else if (liVisibleClientCount = 1) then
        ShowDock;

    end;

  inherited AlignControls(aControl, Rect);

end;  {procedure, AlignControls}


{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.ehGetSiteInfo}

procedure TppVerticalToolbarDock.ehGetSiteInfo(Sender: TObject; DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := DockClient is TppToolbar;

end;

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.ehDockOver}

procedure TppVerticalToolbarDock.ehDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState;var Accept: Boolean);
var
  liControlWidth: Integer;
  lDockRect: TRect;
  liControlHeight: Integer;
  lBoundsRect: TRect;
  lToolBar: TppToolbar;
begin

  Accept := Source.Control is TppToolbar;

  if Accept {and (GetVisibleDockClientCount = 0)} then
    begin
      lToolBar := TppToolBar(Source.Control);

      lBoundsRect := lToolbar.VerticalBoundsRect;
      lDockRect := Source.DockRect;

      liControlWidth := lBoundsRect.Right;
      liControlHeight := lBoundsRect.Bottom;

       //Modify Source.DockRect display preview of dock area.
      if Align = alLeft then
        begin
          lDockRect.TopLeft := ClientToScreen(Point(0, Y));
          lDockRect.Bottom := lDockRect.Top + liControlHeight;
          lDockRect.Right := lDockRect.Left +  liControlWidth;
//          lDockRect.BottomRight := ClientToScreen(Point(liControlWidth, liControlHeight));
        end
      else // if Align = alRight then
        begin
          lDockRect.TopLeft := ClientToScreen(Point(Width-liControlWidth, 0));
          lDockRect.BottomRight := ClientToScreen(Point(Width, Height));

        end;

      Source.DockRect := lDockRect;
    end;

end;

function TppVerticalToolbarDock.GetDockEdge(MousePos: TPoint): TAlign;
begin

  Result := alBottom;
end;

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.ehDockDrop}

procedure TppVerticalToolbarDock.ehDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
var
  liVisibleWidth: Integer;
  lDockRect: TRect;
  lBoundsRect: TRect;
  lToolBar: TppToolbar;
  liControlWidth: Integer;
  liControlHeight: Integer;

begin
  //OnDockDrop gets called AFTER the client has actually docked,
  //so we check for DockClientCount = 1 before making the dock panel visible.

  lDockRect := Source.DockRect;

      lToolBar := TppToolBar(Source.Control);

      lBoundsRect := lToolbar.VerticalBoundsRect;
      lDockRect := Source.DockRect;

      liControlWidth := lBoundsRect.Right;
      liControlHeight := lBoundsRect.Bottom;

  lDockRect.TopLeft := ClientToScreen(Point(0, Y));
  lDockRect.Bottom := lDockRect.Top + liControlHeight;
  lDockRect.Right := lDockRect.Left +  liControlWidth;

  Source.DockRect := lDockRect;


  liVisibleWidth := Source.DockRect.Right - Source.DockRect.Left;

  if liVisibleWidth > FVisibleWidth then
    FVisibleWidth := liVisibleWidth;

  if DockClientCount > 0 then
    Width := FVisibleWidth;

  if DockClientCount = 1 then
    ShowDock
  else
    DockManager.ResetBounds(True); // tell dock manager to repaint clients

end;

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.ShowDock}

procedure TppVerticalToolbarDock.ShowDock;
begin

  if Width > 0 then Exit;

  Width := FVisibleWidth;
  DockManager.ResetBounds(True);

end;

{------------------------------------------------------------------------------}
{ TppVerticalToolbarDock.HideDock}

procedure TppVerticalToolbarDock.HideDock;
begin
  if Width = 0 then Exit;

  FVisibleWidth := Width;
  Width := 0;
  DockManager.ResetBounds(True);

end;

{******************************************************************************
 *
 **  H I N T   T I M E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppHintTimer.Create}

constructor TppHintTimer.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  OnTimer := TimerEvent;

  Enabled := False;

end;  {constructor, Create}

{------------------------------------------------------------------------------}
{ TppHintTimer.Timer}

procedure TppHintTimer.TimerEvent(Sender: TObject);
var
  lObject: TObject;
  lControl: TControl;
begin

  lObject := TObject(Tag);

  if (lObject is TControl) then
    lControl := TControl(lObject)
  else
    lControl := nil;

  if lControl = nil then
    Enabled := False

  else if (lControl <> nil) then

    if (lControl is TppDropDownPanel) then
      begin
        if FTimerType = ttCancel then
          TppDropDownPanel(lControl).DoCancelHint
        else
          TppDropDownPanel(lControl).DoShowHint;
      end;


end;

{******************************************************************************
 *
 **  Global Objects
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ToolImageList}

function ToolImageList: TppToolImageList;
begin

  if (FToolImageList = nil) then
    begin
      FToolImageList := TppToolImageList.Create(nil);
    end;

  Result := FToolImageList;

end; {function, ToolImageList}


{------------------------------------------------------------------------------}
{ CancelHintTimer}

function CancelHintTimer: TppHintTimer;
begin

  if (FCancelHintTimer = nil) then
    begin
      FCancelHintTimer := TppHintTimer.Create(nil);
      FCancelHintTimer.TimerType := ttCancel;
      FCancelHintTimer.Interval  := 100;
    end;

  Result := FCancelHintTimer;

end; {function, CancelHintTimer}


{------------------------------------------------------------------------------}
{ ShowHintTimer}

function ShowHintTimer: TppHintTimer;
begin

  if (FShowHintTimer = nil) then
    begin
      FShowHintTimer := TppHintTimer.Create(nil);
      FShowHintTimer.TimerType := ttShow;
    end;

  Result := FShowHintTimer;

end; {function, ShowHintTimer}


{------------------------------------------------------------------------------}
{ GetHintWindow}

function HintWindow: THintWindow;
begin

  if FHintWindow = nil then
    begin
      FHintWindow := THintWindow.Create(Application);
      FHintWindow.Color := Application.HintColor;
      FHintWindow.Visible := False;
    end;

  Result := FHintWindow;

end; {function, GetHintWindow}

{******************************************************************************
 *
 **  T o o l b a r
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppToolbar.Create}

constructor TppToolbar.Create(AOwner: TComponent);
begin

  inherited Create(aOwner);

  FTimer          := TTimer.Create(nil);
  FTimer.Enabled  := False;
  FTimer.Interval := 1000;
  FTimer.OnTimer  := TimerEvent;

  FInitialized := False;
  FLanguageIndex := 0;

//  DoubleBuffered := True;
  EdgeBorders := [];
  DragKind := dkDock;
  DragMode := dmManual;
  Flat := True;
  Wrapable := True;
//  AutoSize := True;

  FOrientation := toHorizontal;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppToolbar.Destroy}

destructor TppToolbar.Destroy;
begin

  FTimer.Free;
  inherited Destroy;

end;  {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppToolbar.DoDock}

procedure TppToolbar.DoDock(NewDockSite: TWinControl; var ARect: TRect);
begin

  inherited;

  // Delphi 8 bug workaround - toolbar caption is never assigned to floating docksite
  if (NewDockSite <> nil) and (NewDockSite is FloatingDockSiteClass) then
    begin
//TODO Is This needed?      TWinControl(NewDockSite).SetText(Caption);
      TCustomForm(NewDockSite).BorderStyle := bsToolWindow;
      TWinControl(NewDockSite).Invalidate;
//      TCustomForm(NewDockSite).PopupMode := pmAuto;
//      TCustomForm(NewDockSite).PopupParent := Screen.ActiveForm;
      DoOnFloat;
    end;


//  if (NewDockSite is TppVerticalToolbarDock) then
//    SetOrientation(toVertical);
//    SetOrientation(FOrientation);
//  else
//    ShowMessage('OrientHorizontally');

end;

{------------------------------------------------------------------------------}
{ TppToolbar.DoOnFloat}

procedure TppToolbar.DoOnFloat;
begin

  if Assigned(FOnFloat) then FOnFloat(Self);

end;

{------------------------------------------------------------------------------}
{ TppToolbar.DoStartDock}

procedure TppToolbar.DoStartDock(var DragObject: TDragObject);
begin

  inherited;

  //  Delphi 8 - TToolDockObject is buggy
  FDragObject := TppToolbarDragDockObject.Create(Self);
  DragObject := FDragObject;


end;

{------------------------------------------------------------------------------}
{ TppToolbar.DoEndDock}

procedure TppToolbar.DoEndDock(Target: TObject; X, Y: Integer);
begin
  inherited;

  FDragObject.Free;
  FDragObject := nil;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.SetOrientation}

procedure TppToolbar.SetOrientation(const Value: TppToolbarOrientation);
begin
  if (FOrientation <> Value) then
    begin
      FOrientation := Value;
      if FOrientation = toVertical then
        OrientVertically;
    end;
end;

{------------------------------------------------------------------------------}
{ TppToolbar.OrientVertically}

procedure TppToolbar.OrientVertically;
var
  liHorzHeight: Integer;
begin

 if (FOrientation = toVertical) then Exit;

 BeginUpdate;

 try
   FOrientation := toVertical;

   liHorzHeight := Height;
   Height := Width;
   Width := liHorzHeight;

 finally
   EndUpdate;
 end;

 Exit;

 {
try
   if (ControlCount > 0) then
     begin
       lPrevControl := Controls[0];
       Width := lPrevControl.Width + 5;
       Height := lPrevControl.Height + 5;
     end;

   for liIndex := 1 to ControlCount-1 do
     begin
//       lControl := Controls[liIndex];
//       lControl.Top := lPrevControl.Top + lPrevControl.Height + 1;
//       lControl.Left := 0;

       if Width < lControl.Width then
         Width := lControl.Width;

       Height := Height + lControl.Height;

//       lPrevControl := lControl;
     end;

  finally
//    EndUpdate;
  end;
 }
end;


{------------------------------------------------------------------------------}
{ TppToolbar.LoadPreferences}

procedure TppToolbar.LoadPreferences(aIniStorage: TppIniStorage);
begin

  Left := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'Left', Left);
  Top := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'Top', Top);
//  Width := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'Width', Width);
//  Height := aIniStorage.ReadInteger('Toolbar' + Self.Name, 'Height', Height);

end; {procedure, LoadPreferences}

{------------------------------------------------------------------------------}
{ TppToolbar.SavePreferences}

procedure TppToolbar.SavePreferences(aIniStorage: TppIniStorage);
begin

  if Floating then
    begin
      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Left', HostDockSite.Left);
      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Top', HostDockSite.Top);
//      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Width', HostDockSite.Width);
//      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Height', HostDockSite.Height);
    end
  else
    begin
      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Left', Left);
      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Top', Top);
//      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Width', Width);
//      aIniStorage.WriteInteger('Toolbar' + Self.Name, 'Height', Height);
    end;

end; {procedure, SavePreferences}



{------------------------------------------------------------------------------}
{ TppToolbar.GetActive}

function TppToolbar.GetActive: Boolean;
begin
  Result := (FActiveButton <> nil);

end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TppToolbar.SetLanguageIndex}

procedure TppToolbar.SetLanguageIndex(aLanguageIndex: Longint);
begin
  FLanguageIndex := aLanguageIndex;
end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppToolbar.SetParent}

procedure TppToolbar.SetParent(Parent: TWinControl);
begin
  inherited;

  if (Parent <> nil) then
    Initialize;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.Initialize}

procedure TppToolbar.Initialize;
begin

  if FInitialized then Exit;

  Images := ToolImageList;
  CreateControls;

  FInitialized := True;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.BeginUpdate}

procedure TppToolbar.BeginUpdate;
begin
  DisableAlign;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.EndUpdate}

procedure TppToolbar.EndUpdate;
begin
  EnableAlign;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.GetRightMostControl}

function TppToolbar.GetRightMostControl: TControl;
var
  liIndex: Integer;
  lControl: TControl;
begin

  Result := nil;

  for liIndex := 0 to ControlCount-1 do
    begin
      lControl := Controls[liIndex];

      if (Result = nil) or ((lControl.Visible) and (lControl.Left > Result.Left)) then
        Result := lControl;

    end;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.GetRightMostControlPos}

function TppToolbar.GetRightMostControlPos: Integer;
var
  lControl: TControl;
begin

  lControl := GetRightMostControl;

  if (lControl <> nil) then
    Result := lControl.Left + lControl.Width
  else
    Result := 0;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.GetBottomMostControl}

function TppToolbar.GetBottomMostControl: TControl;
var
  liIndex: Integer;
  lControl: TControl;
begin

  Result := nil;

  for liIndex := 0 to ControlCount-1 do
    begin
      lControl := Controls[liIndex];

      if (Result = nil) or ((lControl.Visible) and (lControl.Top > Result.Top)) then
        Result := lControl;

    end;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.GetBottomMostControlPos}

function TppToolbar.GetBottomMostControlPos: Integer;
var
  lControl: TControl;
begin

  lControl := GetBottomMostControl;

  if (lControl <> nil) then
    Result := lControl.Top + lControl.Height
  else
    Result := 0;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.GetHorizontalBoundsRect}

function TppToolbar.GetHorizontalBoundsRect: TRect;
var
  liIndex: Integer;
  liWidth: Integer;
  liHeight: Integer;
  lControl: TControl;
begin

  liWidth  := 0;
  liHeight := 0;

  for liIndex := 0 to ControlCount-1 do
    begin
      lControl := Controls[liIndex];

      liWidth := liWidth + lControl.Width;

      if liHeight < lControl.Height then
        liHeight := lControl.Height;

    end;


  Result := Rect(0, 0, liWidth, liHeight);

end;

{------------------------------------------------------------------------------}
{ TppToolbar.GetVerticalBoundsRect}

function TppToolbar.GetVerticalBoundsRect: TRect;
var
  liIndex: Integer;
  liWidth: Integer;
  liHeight: Integer;
  lControl: TControl;
begin

  liWidth  := 0;
  liHeight := 0;

  for liIndex := 0 to ControlCount-1 do
    begin
      lControl := Controls[liIndex];

      if liWidth < lControl.Width then
        liWidth := lControl.Width + 4;

      liHeight := liHeight + lControl.Height;

    end;


  Result := Rect(0, 0, liWidth, liHeight);


end;

{------------------------------------------------------------------------------}
{ TppToolbar.CreateControls}

procedure TppToolbar.CreateControls;
begin
  {descendants can add code here to create buttons and controls}
end;

{------------------------------------------------------------------------------}
{ TppToolbar.AddControl}

procedure TppToolbar.AddControl(aControl: TControl);
begin
  aControl.Left := GetRightMostControlPos + 1;
  aControl.Parent := Self;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.AlignControls}

procedure TppToolbar.AlignControls(AControl: TControl; var ARect: TRect);
begin
  inherited;

  if (FOrientation = toHorizontal) then
    Width := GetRightMostControlPos
//  else
//    Height := GetBottomMostControlPos;

end;

{------------------------------------------------------------------------------}
{ TppToolbar.ButtonActivateEvent}

procedure TppToolbar.ButtonActivateEvent(Sender: TObject);
begin

  if not (Sender is TppToolbarButton) then Exit;

  if (FActiveButton <> nil) then
    FActiveButton.Active := False;

  FActiveButton  := TppToolbarButton(Sender);

end; {procedure, ButtonActivateEvent}

{------------------------------------------------------------------------------}
{ TppToolbar.ButtonDeactivateEvent}

procedure TppToolbar.ButtonDeactivateEvent(Sender: TObject);
begin
  if (FActiveButton = Sender) then
    FActiveButton := nil;

end; {procedure, ButtonDeactivateEvent}


{------------------------------------------------------------------------------}
{ TppToolbar.ButtonMouseEnterEvent}

procedure TppToolbar.ButtonMouseEnterEvent(Sender: TObject);
begin
  if (FActiveButton = Sender) then
    FTimer.Enabled := False;

end; {procedure, ButtonMouseEnterEvent}


{------------------------------------------------------------------------------}
{ TppToolbar.ButtonMouseLeaveEvent}

procedure TppToolbar.ButtonMouseLeaveEvent(Sender: TObject);
begin
  if (FActiveButton = Sender) then
    FTimer.Enabled := True;
    
end; {procedure, ButtonMouseLeaveEvent}

{------------------------------------------------------------------------------}
{ TppToolbar.TimerEvent}

procedure TppToolbar.TimerEvent(Sender: TObject);
begin

  {set the active button to inactive}
  if (FActiveButton <> nil) then
    begin
      FActiveButton.Active := False;
      FActiveButton := nil;
    end;

  FTimer.Enabled := False;

end; {procedure, TimerEvent}

{------------------------------------------------------------------------------}
{ TppToolbar.WMMove}

procedure TppToolbar.WMMove(var Message: TWMMove);
begin

  inherited;

  if FActiveButton <> nil then
    begin
      FActiveButton.Active := False;
      FActiveButton := nil;
    end;


end; {procedure, WMMove}


{******************************************************************************
 *
 **  T o o l b a r B u t t o n
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppToolbarButton.Create}

constructor TppToolbarButton.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FActive := False;
  FDropDownPanel := nil;

  FOnActivate   := nil;
  FOnDeactivate := nil;
  FOnMouseEnter := nil;
  FOnMouseLeave := nil;

end;  {constructor, Create}


{------------------------------------------------------------------------------}
{ TppToolbarButton.Loaded}

procedure TppToolbarButton.Loaded;
begin
  inherited Loaded;
  if Style = tbsDropDown then
    Grouped := False;
end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppToolbarButton.SetParent}

procedure TppToolbarButton.SetParent(aParent: TWinControl);
var
  lToolbar: TppToolbar;

begin

  inherited SetParent(aParent);

  lToolbar := GetToolbar;


  if (lToolbar = nil) then
    begin
      FOnActivate   := nil;
      FOnDeactivate := nil;
      FOnMouseEnter := nil;
      FOnMouseLeave := nil;
    end
  else
    begin
      FOnActivate   := lToolbar.ButtonActivateEvent;
      FOnDeactivate := lToolbar.ButtonDeactivateEvent;
      FOnMouseEnter := lToolbar.ButtonMouseEnterEvent;
      FOnMouseLeave := lToolbar.ButtonMouseLeaveEvent;
    end;

end;

{------------------------------------------------------------------------------}
{ TppToolbarButton.GetDropDownPanel}

function TppToolbarButton.GetDropDownPanel: TppDropDownPanel;
begin
  {note: descendants can override this behavior}
  Result := FDropDownPanel;

end; {function, GetDropDownPanel}

{------------------------------------------------------------------------------}
{ TppToolbarButton.SetDropdownPanel}

procedure TppToolbarButton.SetDropdownPanel(Value: TppDropDownPanel);
begin
  if (FDropdownPanel = Value) then Exit;

  FDropdownPanel := Value;

  if (FDropdownPanel <> nil) then
    begin

      if not (Style = tbsDropDown) and not(Grouped) then
        begin
          if not AllowAllUp then
            AllowAllUp := True;
        end;

    end;

end; {function, SetDropdownPanel}


{------------------------------------------------------------------------------}
{ TppToolbarButton.GetToolbar}

function TppToolbarButton.GetToolbar: TppToolbar;
begin
  Result := nil;

  if (Parent <> nil) and (Parent is TppToolbar) then
    Result := TppToolbar(Parent);

end; {function, GetToolbar}

{------------------------------------------------------------------------------}
{ TppToolbarButton.SetActive}

procedure TppToolbarButton.SetActive(aValue: Boolean);
begin

  if GetDropDownPanel = nil then Exit;

 FActive := aValue;

  if FActive then
    begin
      if (Style = tbsDropDown) then
        begin
          Down := False;
          MenuIsDown := True;
          ShowDropDownPanel;
          Invalidate;
        end
      else
        begin
          Down := True;
          ShowDropDownPanel;
        end;

    end
  else
    begin
      if (FDropDownPanel <> nil) then
        FDropDownPanel.Visible := False;
      Down := False;
      MenuIsDown := False;
      Invalidate;
    end;


end; {procedure, SetActive}


{------------------------------------------------------------------------------}
{ TppToolbarButton.Click}

procedure TppToolbarButton.Click;
var
  lbTogglePanel: Boolean;

begin

  {determine whether we need to toggle panel (ie. show/hide}
  if Active then
    lbTogglePanel := True

  else if (Style = tbsDropDown) then
    lbTogglePanel := (FMouseDownPos.X >= Width-cDropdownComboWidth) and (GetDropDownPanel <> nil)

  else
    lbTogglePanel := (GetDropDownPanel <> nil);

  if lbTogglePanel then
    SetActive(not FActive)
  else
    inherited Click;
    

end; {procedure, Click}


{------------------------------------------------------------------------------}
{ TppToolbarButton.ShowDropDownPanel}

procedure TppToolbarButton.ShowDropDownPanel;
var
  lPos: TPoint;
  lPopupPoint: TPoint;
  lToolbar: TppToolbar;

begin

  if (csDesigning in ComponentState) then Exit;

  MouseCapture := False;

//TODO remove no longer used  FDropdownPanel.Parent := Parent.Parent;

  {assign event-handlers}
  FDropDownPanel.OnShow := DropDownPanelShowEvent;
  FDropDownPanel.OnHide := DropDownPanelHideEvent;
  FDropDownPanel.OnMouseEnter := DropDownPanelMouseEnterEvent;
  FDropDownPanel.OnMouseLeave := DropDownPanelMouseLeaveEvent;

  {calc position of panel}

  lToolbar := GetToolbar;

  if (lToolbar <> nil) and not(lToolbar.Floating) and (lToolbar.Parent <> nil) then

   case lToolbar.Parent.Align of
      alLeft:   lPopupPoint := Point(Width+1, 0);
      alRight:  lPopupPoint := Point(-(FDropDownPanel.Width+1), 0);
      alTop:    lPopupPoint := (Point(0, Height+1));
      alBottom: lPopupPoint := Point(0, -(FDropDownPanel.Height+1));
    end {case, position}

  else
    lPopupPoint := Point(0, Height+1);


  lPos := ClientToScreen(lPopupPoint);

  if (lPos.Y + FDropDownPanel.Height + 10) > Screen.Height then
    lPopupPoint := Point(lPopupPoint.X, -(FDropDownPanel.Height+1));

  if (lPos.X + FDropDownPanel.Width + 10) > Screen.Width then
    lPopupPoint := Point(-(FDropDownPanel.Width+1), lPopupPoint.Y);


  lPos := ClientToScreen(lPopupPoint);


  FDropDownPanel.Left := lPos.X;
  FDropDownPanel.Top  := lPos.Y;

  {check whether panel fits on screen and adjust if necessary}
  if FDropDownPanel.Top + FDropDownPanel.Height > Screen.Height then
    FDropDownPanel.Top := Screen.Height - FDropDownPanel.Height;

  if FDropDownPanel.Left + FDropDownPanel.Width > Screen.Width then
    FDropDownPanel.Left := Screen.Width - FDropDownPanel.Width;

  if FDropDownPanel.Top < 0 then
    FDropDownPanel.Top := 0;

  if FDropDownPanel.Left < 0 then
    FDropDownPanel.Left := 0;


  FDropDownPanel.Visible := True;

  SetWindowPos(FDropDownPanel.Handle, HWND_TOP, 0, 0, 0, 0,
                SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end; {procedure, ShowDropDownPanel}


{------------------------------------------------------------------------------}
{ TppToolbarButton.DropDownPanelShowEvent}

procedure TppToolbarButton.DropDownPanelShowEvent(Sender: TObject);
begin

  if (Style = tbsDropDown) then
    MenuIsDown := True
  else
    Down := True;

  FActive := True;
  
  if Assigned(FOnActivate) then FOnActivate(Self);

end; {procedure, DropDownPanelShowEvent}

{------------------------------------------------------------------------------}
{ TppToolbarButton.DropDownPanelHideEvent}

procedure TppToolbarButton.DropDownPanelHideEvent(Sender: TObject);
begin

  if (Style = tbsDropDown) then
    MenuIsDown := False
  else
    Down := False;

  FActive := False;

  if Assigned(FOnDeactivate) then FOnDeactivate(Self);


end; {procedure, DropDownPanelHideEvent}

{------------------------------------------------------------------------------}
{ TppToolbarButton.DropDownPanelMouseLeaveEvent}

procedure TppToolbarButton.DropDownPanelMouseLeaveEvent(Sender: TObject);
begin

  DoMouseLeave;

end; {procedure, DropDownPanelMouseLeaveEvent}

{------------------------------------------------------------------------------}
{ TppToolbarButton.DropDownPanelMouseEnterEvent}

procedure TppToolbarButton.DropDownPanelMouseEnterEvent(Sender: TObject);
begin

  DoMouseEnter;

end; {procedure, DropDownPanelMouseLeaveEvent}

procedure TppToolbarButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;

  MouseEntered;

end;

procedure TppToolbarButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;

  MouseLeft;

end;

{------------------------------------------------------------------------------}
{ TppToolbarButton.DoMouseLeave}

procedure TppToolbarButton.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);

end; {procedure, DoMouseLeave}

{------------------------------------------------------------------------------}
{ TppToolbarButton.DoMouseEnter}

procedure TppToolbarButton.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);

end; {procedure, DoMouseEnter}

{------------------------------------------------------------------------------}
{ TppToolbarButton.MouseEntered}

procedure TppToolbarButton.MouseEntered;
var
  lToolbar: TppToolbar;

begin

  lToolbar := GetToolbar;

  if (lToolbar <> nil) and lToolbar.Active then
   SetActive(True);

  DoMouseEnter;

end; {procedure, MouseEntered}


{------------------------------------------------------------------------------}
{ TppToolbarButton.MouseLeft}

procedure TppToolbarButton.MouseLeft;
var
  lPoint: TPoint;
  lPointRect: TRect;
  lIntersectRect: TRect;
  lBoundsRect: TRect;

begin


  if not Active or (FDropDownPanel = nil) then Exit;

  //get cursor position and convert screen coordinates
  GetCursorPos(lPoint);

  lBoundsRect := FDropdownPanel.BoundsRect;
  InflateRect(lBoundsRect, 2, 2);

  lPointRect.TopLeft     := lPoint;
  lPointRect.BottomRight := lPoint;
  InflateRect(lPointRect, 1, 1);

  IntersectRect(lIntersectRect, lPointRect, lBoundsRect);

  if (lIntersectRect.Top = 0) then
    DoMouseLeave;

end; {procedure, MouseLeft}


{------------------------------------------------------------------------------}
{ TppToolbarButton.MouseDown}

procedure TppToolbarButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  FMouseDownPos := Point(X, Y);

  inherited MouseDown(Button, Shift, X, Y);

  {inherited sets MenuIsDown, so need to override the value here}
  if (Style = tbsDropDown) and Active then
    MenuIsDown := True;

end; {procedure, MouseDown}

{******************************************************************************
 *
 ** S E P A R A T O R
 *
{******************************************************************************}

{ TppToolbarSeparator }

constructor TppToolbarSeparator.Create(AOwner: TComponent);
begin
  inherited;

  Style := tbsSeparator;

end;

{******************************************************************************
 *
 ** D r o p D o w n P a n e l
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDropDownPanel.Create}

constructor TppDropDownPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DoubleBuffered := True;

  FToolWindow    := nil;
  FTearAway      := False;
  FActiveCaption := False;

  FOnToolWindowActivate := nil;
  FOnToolWindowCreate := nil;

  FOnMouseEnter := nil;
  FOnMouseLeave := nil;

  FOnShow       := nil;
  FOnHide       := nil;


end;  {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDropDownPanel.Destroy}

destructor TppDropDownPanel.Destroy;
var
  lObject: TObject;
begin

  FreeToolWindow;

 lObject := TObject(CancelHintTimer.Tag);

 if (lObject = Self) then
   CancelHintTimer.Tag := 0;

 lObject := TObject(ShowHintTimer.Tag);

 if (lObject = Self) then
   ShowHintTimer.Tag := 0;


  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{ TppDropDownPanel.CreateParams}

procedure TppDropDownPanel.CreateParams (var Params: TCreateParams);
begin
  inherited CreateParams (Params);

  if csDesigning in ComponentState then Exit;

  Params.Style   := WS_POPUP;

  Params.ExStyle := WS_EX_WINDOWEDGE;

end; {procedure, CreateParams}

{------------------------------------------------------------------------------}
{ TppDropDownPanel.Loaded}

procedure TppDropDownPanel.Loaded;
begin
  Visible := False;

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppDropDownPanel.PaintTitleBar}

procedure TppDropDownPanel.PaintTitleBar;
begin

  Canvas.Brush.Style := bsSolid;

  if FActiveCaption then
    Canvas.Brush.Color := clActiveCaption
  else
    Canvas.Brush.Color := clInactiveCaption;

  Canvas.FillRect(GetTitleBarRect);


end;

{------------------------------------------------------------------------------}
{ TppDropDownPanel.Paint}

procedure TppDropDownPanel.Paint;
begin

  inherited Paint;

  if FTearAway then
    PaintTitleBar;

end; {procedure, Paint}

{------------------------------------------------------------------------------}
{ TppDropDownPanel.SetTearAway}

procedure TppDropDownPanel.SetTearAway(aValue: Boolean);
var
  liControl: Integer;
  liIncrement: Integer;

begin

  if FTearAway = aValue then Exit;

  FTearAway := aValue;

  if (csReading in ComponentState) and (csLoading in ComponentState) then Exit;

  if FTearAway then
    liIncrement := 10
  else
    liIncrement := -10;

  {shift controls}
  for liControl := 0 to ControlCount-1 do
    Controls[liControl].Top  := Controls[liControl].Top +  liIncrement;

  {resize window height}
  Height := Height + liIncrement;


  Invalidate;

end;  {procedure, SetTearAway}


{------------------------------------------------------------------------------}
{ TppDropDownPanel.GetTitleBarRect}

function TppDropDownPanel.GetTitleBarRect: TRect;
begin
  Result := Rect(3, 3, 3 + (Width-6), 3+5);
end;

{------------------------------------------------------------------------------}
{ TppDropDownPanel.WMMouseActivate}

procedure TppDropDownPanel.WMMouseActivate (var Message: TWMMouseActivate);
begin

  if (csDesigning in ComponentState) then
    inherited

  else
    begin
      { do not take focus away from the window that had it }
      Message.Result := MA_NOACTIVATE;

      { Similar to calling BringWindowToTop, but doesn't activate it }
      SetWindowPos (Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
   end;

end;

{------------------------------------------------------------------------------}
{ TppDropDownPanel.CMVisibleChanged}

procedure TppDropDownPanel.CMVisibleChanged (var Message: TMessage);
begin
  inherited;

  if Visible and Assigned(FOnShow) then
    FOnShow(Self)

  else if not Visible and Assigned(FOnHide) then
    FOnHide(Self);

end;  {procedure, CMVisibleChanged}

{------------------------------------------------------------------------------}
{ TppDropDownPanel.CMMouseEnter}

procedure TppDropDownPanel.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);


  if HintWindow.Visible then
     {already in hint mode, show hint for this control}
     DoShowHint
  else
    begin
     {turn on hint timer}
      ShowHintTimer.Enabled := True;

      CancelHintTimer.Enabled := False;
      ShowHintTimer.Tag := Integer(Self);
    end;

end; {procedure, CMMouseEnter}


{------------------------------------------------------------------------------}
{ TppDropDownPanel.CMMouseLeave}

procedure TppDropDownPanel.CMMouseLeave(var Message: TMessage);
var
  lPoint: TPoint;
  lObject: TObject;

begin
  inherited;

  {get cursor position and convert screen coordinates}
  GetCursorPos(lPoint);

  lPoint := ScreenToClient(lPoint);

  {check whether cursor is over a control within the panel}
  if (ControlAtPos(lPoint, True) = nil) then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);

  lObject := TObject(ShowHintTimer.Tag);


  if (lObject = Self) and HintWindow.Visible then
    begin
      ShowHintTimer.Tag := 0;
      CancelHintTimer.Enabled := True;
    end;



end; {procedure, CMMouseLeave}


{------------------------------------------------------------------------------}
{ TppDropDownPanel.MouseMove}

procedure TppDropDownPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  lbActiveCaption: Boolean;

begin

  inherited MouseMove(Shift, X, Y);

  if not FTearAway then Exit;

  lbActiveCaption := IsActiveCaption(Point(X,Y));

  {check for a transition}
  if FActiveCaption <> lbActiveCaption then
    begin

      FActiveCaption := lbActiveCaption;

      {repaint the TitleBar as active}
      if FActiveCaption then
        PaintTitleBar

      {activate the toolwindow - i.e. start dragging it}
      else if (ssLeft in Shift) and not (csDesigning in ComponentState) then
        ActivateToolWindow

      {repaint TitleBar as inactive}
      else 
        PaintTitleBar;

    end;  {if, FActiveCaption <> lbActiveCaption}

end; {procedure, MouseMove}


{------------------------------------------------------------------------------}
{ TppDropDownPanel.IsActiveCaption}

function TppDropDownPanel.IsActiveCaption(aPoint: TPoint): Boolean;
begin

  {determine whether mouse is over the TitleBar}
  Result := FTearAway and PtInRect(GetTitleBarRect, aPoint);

end; {function, IsActiveCaption}


{------------------------------------------------------------------------------}
{ TppDropDownPanel.ToolWindowVisibleChangedEvent}

procedure TppDropDownPanel.ToolWindowVisibleChangedEvent(Sender: TObject);
begin


  if Visible and  Assigned(FOnToolWindowShow) then
     FOnToolWindowShow(FToolWindow)

  else if not Visible and Assigned(FOnToolWindowHide) then
     FOnToolWindowHide(FToolWindow);

end; {procedure, ToolWindowVisibleChangedEvent}


{------------------------------------------------------------------------------}
{ TppDropDownPanel.CreateToolWindow}

procedure TppDropDownPanel.CreateToolWindow;
var
  liControl: Integer;
  lControl: TControl;
  lsSaveName: String;
  lStream: TMemoryStream;
  lNewControl: TControl;

begin

  if (FToolWindow <> nil) then Exit;

  {create the ToolWindow and initialize}
  FToolWindow := TppToolPaletteWindow.Create(Owner);
  FToolWindow.Visible := False;

  FToolWindow.SetBounds(-10000, -10000, FToolWindow.Width, FToolWindow.Height);

//TODO remove  if Owner is TForm then
//    FToolWindow.Parent := TForm(Owner);

  FToolWindow.ClientWidth  := ClientWidth;
  FToolWindow.ClientHeight := ClientHeight-10;

  FToolWindow.OnVisibleChanged := ToolWindowVisibleChangedEvent;


  lStream := TMemoryStream.Create;

  {copy of all the controls }
  for liControl := 0 to ControlCount-1 do
    begin

      lControl := Controls[liControl];

      {make sure class is registered}
      if GetClass(lControl.ClassName) = nil then
        RegisterClass(TPersistentClass(lControl.ClassType));

      lsSaveName := lControl.Name;

      {get a unique name}
      lControl.Name := ppGetUniqueName(FToolWindow,  lControl.ClassName, lControl);

      {write to stream}
      lStream.Clear;
      lStream.WriteComponent(lControl);

      lControl.Name := lsSaveName;

      {create new control and read properties from stream }
      lNewControl := TControlClass(lControl.ClassType).Create(FToolWindow);
      lNewControl.Parent := FToolWindow;

      lStream.Position := 0;
      lStream.ReadComponent(lNewControl);

      {adjust position}
      lNewControl.Left := lNewControl.Left;
      lNewControl.Top  := lNewControl.Top - 8;

    end;


   lStream.Free;

  if Assigned(FOnToolWindowCreate) then FOnToolWindowCreate(Self);


end; {procedure, CreateToolWindow}


{------------------------------------------------------------------------------}
{ TppDropDownPanel.FreeToolWindow}

procedure TppDropDownPanel.FreeToolWindow;
begin
  FToolWindow.Free;
  FToolWindow := nil;
end; {procedure, FreeToolWindow}



{------------------------------------------------------------------------------}
{ TppDropDownPanel.ActivateToolWindow}

procedure TppDropDownPanel.ActivateToolWindow;
begin

  if FToolWindow = nil then
    CreateToolWindow;

  if Assigned(FOnToolWindowActivate) then FOnToolWindowActivate(Self);

  if FToolWindow.Visible then
    FToolWindow.Visible := False;

  EndDrag(False);
  FToolWindow.Left := Left;
  FToolWindow.Top := Top;
  FToolWindow.Visible := True;
  FToolWindow.Repaint; // force repaint to remove artifacts discovered while testing
  FToolWindow.BeginDrag(True, 0);

end;


{------------------------------------------------------------------------------}
{ TppDropDownPanel.DoShowHint}

procedure TppDropDownPanel.DoShowHint;
var
  lPoint : TPoint;
  lHintRect: TRect;
  lHintWindow: THintWindow;
begin

  if (FTitleBarHint = '') then Exit;

  GetCursorPos(lPoint);
  lPoint := ScreenToClient(lPoint);

  {if cursor position NOT over this title bar then cancel hint and exit}
  if not IsActiveCaption(lPoint) then
    begin
      DoCancelHint;
      Exit;
    end;

  ShowHintTimer.Tag   := Integer(Self);
  CancelHintTimer.Tag := Integer(Self);

  ShowHintTimer.Enabled   := False;
  CancelHintTimer.Enabled := True;


  lHintWindow := HintWindow;

  {display hint directly below mouse pos}
  lPoint.Y := 12;

  {convert to screen corrdinates}
  lPoint := ClientToScreen(lPoint);

  {set hint window size & position}
  lHintRect.Left   := lPoint.X;
  lHintRect.Top    := lPoint.Y + 5 ;
  lHintRect.Right  := lHintRect.Left +  lHintWindow.Canvas.TextWidth(FTitleBarHint)  + 6;
  lHintRect.Bottom := lHintRect.Top  +  lHintWindow.Canvas.TextHeight(FTitleBarHint) + 2;

  lHintWindow.Visible := True;
  lHintWindow.ActivateHint(lHintRect, FTitleBarHint);


end; {procedure, DoShowHint}

{------------------------------------------------------------------------------}
{ TppDropDownPanel.DoCancelHint}

procedure TppDropDownPanel.DoCancelHint;
var
  lHintWindow: THintWindow;
  lPoint: TPoint;
begin

  GetCursorPos(lPoint);
  lPoint := ScreenToClient(lPoint);

  {if cursor position over this button then exit}
  if IsActiveCaption(lPoint) then Exit;

  CancelHintTimer.Tag := 0;
  ShowHintTimer.Tag   := 0;

  CancelHintTimer.Enabled  := False;
  ShowHintTimer.Enabled    := False;

  lHintWindow := HintWindow;

  if (lHintWindow <> nil) and lHintWindow.Visible then
    begin

      lHintWindow.Visible := False;

      {hide hint window}
      if lHintWindow.HandleAllocated then
        ShowWindow(lHintWindow.Handle, SW_HIDE);

    end;

end; {procedure, DoCancelHint}

{******************************************************************************
 *
 ** VERTICAL TOOLBAR DOCk TREE
 *
{******************************************************************************}

{ TppVerticalToolbarDockTree }


procedure TppVerticalToolbarDockTree.PaintDockFrame(Canvas: TCanvas; Control: TControl; const ARect: TRect);
const
  GrabberSize = 12;
var
  lFrameRect: TRect;

  procedure DrawGrabberLine(Left, Top, Right, Bottom: Integer);
  begin
    with Canvas do
    begin
      Pen.Color := clBtnHighlight;
      MoveTo(Right, Top);
      LineTo(Left, Top);
      LineTo(Left, Bottom);
      Pen.Color := clBtnShadow;
      LineTo(Right, Bottom);
      LineTo(Right, Top-1);
    end;
  end;




begin
  with ARect do
    if DockSite.Align in [alTop, alBottom, alNone] then
    begin
 //     DrawCloseButton(Left+1, Top+1);
      lFrameRect := aRect;
      InflateRect(lFrameRect, -1, -1);

      DrawGrabberLine(Left+3, Top+GrabberSize+1, Left+5, Bottom-2);
      DrawEdge(DockSite.Handle, lFrameRect, BDR_RAISEDINNER, BF_RECT);

//      DrawGrabberLine(Left+6, Top+GrabberSize+1, Left+8, Bottom-2);
    end
    else
    begin
//      DrawCloseButton(Right-FGrabberSize+1, Top+1);
      DrawGrabberLine(Left+2, Top+3, Right-2, Top+5);
//      DrawGrabberLine(Left+2, Top+6, Right-GrabberSize-2, Top+8);
    end;
end;


procedure TppVerticalToolbarDockTree.PositionDockRect(Client, DropCtl: TControl; DropAlign: TAlign; var DockRect: TRect);
begin

  inherited PositionDockRect(Client, DropCtl, DropAlign, DockRect);

end;

{******************************************************************************
 *
 ** VERTICAL DOCk TREE
 *
{******************************************************************************}

{ TppVerticalDockTree }

const
  cCaptionAreaHeight = 14;

//TODO

{------------------------------------------------------------------------------}
{ TppVerticalDockTree.WndProc}

{procedure TppVerticalDockTree.WndProc(var Message: TMessage);
var
  lbSuppressException: Boolean;
begin

  lbSuppressException := False;

  case Message.Msg of
    CM_DOCKNOTIFICATION:

      with TCMDockNotification.Create(Message) do
        if (NotifyRec.ClientMsg = CM_VISIBLECHANGED) then
          lbSuppressException := True;
    //      ControlVisibilityChanged(Client, Boolean(NotifyRec.MsgWParam));

  end;


  try

    inherited;

  except    }
{$IFDEF CodeSite}
{    gCodeSite.Send('TppVerticalDockTree.WndProc - exception thrown');

    if Message.Msg = CM_DOCKNOTIFICATION then
      gCodeSite.Send('TppVerticalDockTree.WndProc - exception on CM_DOCKNOTIFICATION');}
{$ENDIF}

{    if lbSuppressException then
      // suppress Delphi design-time AV
    else
      raise;

  end;


end;  }

{------------------------------------------------------------------------------}
{ TppVerticalDockTree.PaintDockFrame}


procedure TppVerticalDockTree.PaintDockFrame(Canvas: TCanvas; Control: TControl; const aRect: TRect);
var
  lFrameRect: TRect;
  lFillRect: TRect;
  lTextRect: TRect;
  lsCaption: String;

  procedure DrawCloseButton(aRect: TRect);
  var
    lButtonRect: TRect;
  begin

    // position the close button on the right side of the rectangle
    lButtonRect := Rect(aRect.Right-10, aRect.Top+3, aRect.Right-2, aRect.Top+ 10);

    // configure the pen
    Canvas.Pen.Color := clCaptionText;
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 2;

    // draw diagonal from left,top to right,bottom
    Canvas.MoveTo(lButtonRect.Left, lButtonRect.Top);
    Canvas.LineTo(lButtonRect.Right, lButtonRect.Bottom);

    // draw diagonal from right,top to left,bottom
    Canvas.MoveTo(lButtonRect.Right, lButtonRect.Top);
    Canvas.LineTo(lButtonRect.Left, lButtonRect.Bottom);
  end;

begin

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppVerticalDockTree.PaintDockFrame');
{$ENDIF}


  // draw a frame using clBtnFace
  lFrameRect := Rect(aRect.Left-1, aRect.Top-1, aRect.Right-1, aRect.Top + cCaptionAreaHeight+1);
  Canvas.Brush.Color := clBtnFace;
  Canvas.FrameRect(lFrameRect);

  // get the caption text
  if (Control is TppToolWindow) then
    lsCaption := TppToolWindow(Control).Caption
//TODO  else if (Control <> nil) then
//    lsCaption := Control.Caption
  else
    lsCaption := '';

  // set the brush color
  if (Control is TppToolWindow) and TppToolWindow(Control).Active then
    Canvas.Brush.Color := clActiveCaption
  else
    Canvas.Brush.Color := clInactiveCaption;

  Canvas.Pen.Color := Canvas.Brush.Color;

  // draw the caption rectangle
  lFillRect := Rect(aRect.Left, aRect.Top, aRect.Right-2, aRect.Top + cCaptionAreaHeight);
  Canvas.FillRect(lFillRect);

  // make it appear slightly rounded by drawing shorter lines on each side
  Canvas.MoveTo(lFillRect.Left-1, lFillRect.Top+1);
  Canvas.LineTo(lFillRect.Left-1, lFillRect.Bottom-1);
  Canvas.MoveTo(lFillRect.Right, lFillRect.Top+1);
  Canvas.LineTo(lFillRect.Right, lFillRect.Bottom-1);

  lTextRect := Rect(lFillRect.Left, lFillRect.Top, lFillRect.Right - 12, lFillRect.Bottom);

  // draw the caption
  Canvas.Font.Color := clCaptionText;
  Canvas.TextRect(lTextRect, lFillRect.Left + 3, lFillRect.Top, lsCaption);

  // draw the close button
  DrawCloseButton(lFillRect);

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppVerticalDockTree.PaintDockFrame');
{$ENDIF}
end;

{------------------------------------------------------------------------------}
{ TppVerticalDockTree.AdjustDockRect}

procedure TppVerticalDockTree.AdjustDockRect(Control: TControl; var ARect: TRect);
begin
  { Allocate room for the caption on the left if docksite is horizontally
    oriented, otherwise allocate room for the caption on the top. }
  if DockSite.Align in [alTop, alBottom] then
    Inc(ARect.Left, cCaptionAreaHeight+1)
  else
    Inc(ARect.Top, cCaptionAreaHeight+1);
end;


{******************************************************************************
 *
 ** TOOLBAR DRAG DOCK OBJECT
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppToolbarDragDockObject.Create}

constructor TppToolbarDragDockObject.Create(AControl: TControl);
begin
  inherited Create(AControl);

  GetCursorPos(FCursorPos);

  if not aControl.Floating then
    begin
      aControl.ManualFloat(Bounds(FCursorPos.X - 10, FCursorPos.Y - 10,
                                  aControl.Width, aControl.Height));
    end;

end;

{------------------------------------------------------------------------------}
{ TppToolbarDragDockObject.AdjustDockRect}

procedure TppToolbarDragDockObject.AdjustDockRect(ARect: TRect);
begin
   { Prevent inherited processing }
end;


{------------------------------------------------------------------------------}
{ TppToolbarDragDockObject.DrawDragDockImage}

procedure TppToolbarDragDockObject.DrawDragDockImage;
var
  lForm: TCustomForm;
  lCursorPos: TPoint;
  lDelta: TPoint;
begin

  if not Control.Floating then
    inherited DrawDragDockImage
  else
    begin
      lForm := GetParentForm(Control);

      if lForm <> nil then
        begin

          GetCursorPos(lCursorPos);

          lDelta.X := lCursorPos.X - FCursorPos.X;
          lDelta.Y := lCursorPos.Y - FCursorPos.Y;

          lForm.BoundsRect := Bounds(lForm.Left + lDelta.X, lForm.Top +lDelta.Y, Control.Width, Control.Height);

          FCursorPos.X := lCursorPos.X;
          FCursorPos.Y := lCursorPos.Y;

        end
    end


end;

{------------------------------------------------------------------------------}
{ TppToolbarDragDockObject.EraseDragDockImage}

procedure TppToolbarDragDockObject.EraseDragDockImage;
begin

  if not Control.Floating then
    inherited EraseDragDockImage

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}



initialization

//  RegisterClasses([TppToolbar, TppToolbarButton, TppDropDownPanel]);

  {note: hint window is destroyed automatically by the Application otherwise get a gpf}
  FHintWindow := nil;
  FShowHintTimer := nil;
  FCancelHintTimer := nil;

finalization

//  UnRegisterClasses([TppToolbar, TppToolbarButton, TppDropDownPanel]);

  FToolImageList.Free;
  FToolImageList := nil;

  FShowHintTimer.Free;
  FCancelHintTimer.Free;

  FHintWindow := nil;
  FShowHintTimer := nil;
  FCancelHintTimer := nil;

end.
