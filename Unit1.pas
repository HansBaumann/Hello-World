unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Bind.Components,
  Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.Buttons, System.Actions,
  Vcl.ActnList, Vcl.StdActns, System.ImageList, Vcl.ImgList, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    ImageList1: TImageList;
    ActionList1: TActionList;
    FileExit1: TFileExit;
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
    BindingsList1: TBindingsList;
    LinkControlToPropertyTextHint: TLinkControlToProperty;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure UpdateWord(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private-Deklarationen }
    str_MainWord : string;
    procedure UpdateFields;
    procedure InitializeStyles;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
  Vcl.Themes
  ;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  s: string;
begin
  s := ComboBox1.Text;
  TStyleManager.TrySetStyle(s);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  str_MainWord := 'Hello World';
  UpdateFields;
  InitializeStyles;
end;

procedure TForm1.InitializeStyles;
var
  i: Integer;
  s: string;
begin
  // fetch all installed styles
  ComboBox1.Visible := TStyleManager.Enabled;
  if ComboBox1.Visible then
  begin
    // insert style names into combobox
    for i := 0 to length(TStyleManager.StyleNames) - 1 do
    begin
      ComboBox1.Items.Add( TStyleManager.StyleNames[i] );
    end;
    s := TStyleManager.ActiveStyle.Name;
    ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(s);
  end;

end;

procedure TForm1.UpdateFields;
begin
  // update all Text
  Label1.Caption := str_MainWord;
  if str_MainWord<>Edit1.Text then
  begin
    Edit1.OnChange := NIL;
    Edit1.Text := str_MainWord;
    Edit1.OnChange := UpdateWord;
  end;
  if str_MainWord<>Memo1.Text then
  begin
    Memo1.OnChange := NIL;
    Memo1.Text := str_MainWord;
    Memo1.OnChange := UpdateWord;
  end;
end;

procedure TForm1.UpdateWord(Sender: TObject);
begin
  // do that word
  if Sender is TEdit then
    str_MainWord := Edit1.Text;
  if Sender is TMemo then
    str_MainWord := Memo1.Text;
  UpdateFields;
end;

end.
