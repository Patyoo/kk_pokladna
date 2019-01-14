unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure getDate();
    procedure ListBox1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
const N=100;
var
  Form1: TForm1;
  myDate : TDateTime;
  CurrentTime:string;
  subor:TextFile;
  poleKod:array[1..N] of integer;
  poleMnozstvo:array[1..N] of integer;
  poleTovar:array[1..N] of String;
  poleCena:array[1..N] of real;



implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var pocet,i,pozicia:integer;
  slovo:string;
begin

  assignFile(subor,'Sklad.txt');
  reset(subor);
  readln(subor,pocet);
  FOR i:=1 to pocet DO
  begin
  readln(subor,slovo);
  pozicia:=POS(';',slovo);
  poleKod[i]:=StrToInt(COPY(slovo,1,pozicia-1));
  poleMnozstvo[i]:=StrToInt(COPY(slovo,pozicia+1,length(slovo)));
  ListBox1.Items.Add(IntToStr(poleMnozstvo[i]));
  end;

  assignFile(subor,'Tovar.txt');
  reset(subor);
  readln(subor,pocet);
   FOR i:=1 to pocet DO
  begin
  readln(subor,slovo);
  pozicia:=POS(';',slovo);
  poleKod[i]:=StrToInt(COPY(slovo,1,pozicia-1));
  poleTovar[i]:=COPY(slovo,pozicia+1,length(slovo));
  ListBox1.Items.Add(poleTovar[i]);
  end;
  closeFile(subor);


  assignFile(subor,'Cennik.txt');
  reset(subor);
  readln(subor,pocet);
  FOR i:=1 to pocet DO
  begin
 // readln(subor,slovo);
 // pozicia:=POS(';',slovo);
  //poleKod[i]:=StrToInt(COPY(slovo,1,pozicia-1));
  //slovo:=COPY(slovo,pozicia+1,length(slovo));
 // pozicia:=POS(';',slovo);
 // poleCena[i]:=StrToFloat(COPY(slovo,pozicia+1,length(slovo)));
 // ListBox1.Items.Add(FloatToStr(poleCena[i]));
  end;
  closeFile(subor);


  //
  getDate();
  Memo1.append(CurrentTime);


end;
procedure TForm1.getDate();
begin
    myDate:= StrToDate(DateToStr(now));
    DateTimeToString(CurrentTime,'dd/mm/yy', myDate);

end;

procedure TForm1.ListBox1Click(Sender: TObject);
var ItemIndex,quantity:integer;
  ItemIndexText,value:string;
begin
 if((ListBox1.Items.count>0) AND (ListBox1.ItemIndex > -1)) then
  begin
  ItemIndex := ListBox1.ItemIndex;
  ItemIndexText:=ListBox1.Items[ListBox1.ItemIndex];
  value := inputbox('Test program', 'Please type your mnozstvo', '0');
  quantity:=StrToInt(value);
  Memo1.append('Slovo: '+ItemIndexText+',Index: '+IntToStr(ItemIndex)+',mnozstvo: '+IntToStr(quantity));
  ListBox1.ItemIndex:=-1;
  end;
end;




end.

