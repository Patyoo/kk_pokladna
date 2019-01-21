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
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getDate();
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
const N=100;
var
  Form1: TForm1;
  myDate : TDateTime;
  CurrentTime,meno:string;
  subor:TextFile;
  celkovySucet:real;
  pocet,pocetVybranych:integer;
  poleKod:array[1..N] of integer;
  poleMnozstvo:array[1..N] of integer;
  poleTovar:array[1..N] of String;
  poleCena:array[1..N] of real;

  poleVybraneKod:array[1..N] of integer;
  poleVybraneMnozstvo:array[1..N] of integer;
  poleVybraneCena:array[1..N] of real;




implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i,y,pozicia,pomocna:integer;
  slovo:string;
begin
   pocetVybranych:=0;
 {meno:='';
 celkovySucet:=0;
 While(meno='') DO meno:= inputbox('Prosím zadajte meno pokladníka', 'Vaše meno:', '');
 Label1.caption:='Meno pokladníka: '+meno;
 }
  assignFile(subor,'Tovar.txt');
  reset(subor);
  readln(subor,pocet);
  FOR i:=1 to pocet DO
  begin
  readln(subor,slovo);
  pozicia:=POS(';',slovo);
  poleKod[i]:=StrToInt(COPY(slovo,1,pozicia-1));
  poleTovar[i]:=COPY(slovo,pozicia+1,length(slovo));
  end;
  closeFile(subor);


  assignFile(subor,'Sklad.txt');
  reset(subor);
  readln(subor);
  FOR i:=1 to pocet DO
  begin
  readln(subor,slovo);
  pozicia:=POS(';',slovo);
  pomocna:=StrToInt(COPY(slovo,1,pozicia-1));
  FOR y:=1 to pocet DO IF(pomocna=poleKod[y]) THEN pomocna:=y;
  poleMnozstvo[pomocna]:=StrToInt(COPY(slovo,pozicia+1,length(slovo)));
  end;
  closeFile(subor);

  assignFile(subor,'Cennik.txt');
  reset(subor);
  readln(subor,pocet);
  FOR i:=1 to pocet DO
  begin
  readln(subor,slovo);
  pozicia:=POS(';',slovo);
  pomocna:=StrToInt(COPY(slovo,1,pozicia-1));
    FOR y:=1 to pocet DO IF(pomocna=poleKod[y]) THEN pomocna:=y;
  slovo:=COPY(slovo,pozicia+1,length(slovo));
  pozicia:=POS(';',slovo);
  poleCena[pomocna]:=StrToFloat(COPY(slovo,pozicia+1,length(slovo)));
  end;

  closeFile(subor);

   FOR i:=1 to pocet DO
   ListBox1.Items.Add(poleTovar[i]+' '+IntToStr(poleKod[i]));







end;

procedure TForm1.Button7Click(Sender: TObject);
var i:integer;
begin

 FOR i:=1 to pocetVybranych DO
begin
  poleVybraneKod[i]:=0;
  poleVybraneMnozstvo[i]:=0;
  poleVybraneCena[i]:=0;
end;
 pocetVybranych:=0;
 celkovySucet:=0;
 Label5.caption:=FloatToStr(celkovySucet)+'$';
 listbox2.Items.Clear();
  //zrusit ucet
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,nahodne:integer;
  c:char;
begin
 getDate();
 nahodne:=random(100000000)+1;
 c:='P';
 assignFile(subor,'Statistiky.txt');
 append(subor);
 FOR i:=1 to pocetVybranych DO
 Writeln(subor,c+';'+IntToStr(nahodne)+';'+IntToStr(poleVybraneKod[i])+';'+IntTOStr(poleVybraneMnozstvo[i])+';'+FloatToStr(poleVybraneCena[i])+';'+CurrentTime);
 closeFile(subor);

 FOR i:=1 to pocetVybranych DO
begin
  poleVybraneKod[i]:=0;
  poleVybraneMnozstvo[i]:=0;
  poleVybraneCena[i]:=0;
end;
 pocetVybranych:=0;
 celkovySucet:=0;
 Label5.caption:=FloatToStr(celkovySucet)+'$';
 listbox2.Items.Clear();
 //vytlacit ucet
end;

procedure TForm1.getDate();
begin
    myDate:= StrToDate(DateToStr(now));
    DateTimeToString(CurrentTime,'dd/mm/yy', myDate);

end;

procedure TForm1.ListBox1Click(Sender: TObject);
var ItemIndex,mnozstvo:integer;
  ItemIndexText:string;
begin
 if((ListBox1.Items.count>0) AND (ListBox1.ItemIndex > -1)) then
  begin
  ItemIndex := ListBox1.ItemIndex;
  ItemIndexText:=ListBox1.Items[ListBox1.ItemIndex];
  mnozstvo := StrToInt(inputbox('Zadajte prosím želaný počet tovaru', 'Vaše množstvo:', '1'));
  celkovySucet:=celkovySucet+(mnozstvo*poleCena[ItemIndex+1]);
  poleMnozstvo[ItemIndex+1]:=mnozstvo;
  ListBox2.Items.Add( poleTovar[ItemIndex+1]+' Množstvo:'+IntToStr(mnozstvo)+' Cena za kus:'+FloatToStr(poleCena[ItemIndex+1])+' (Celkovo:'+FloatToStr(mnozstvo*poleCena[ItemIndex+1])+')');
  Label5.caption:=FloatToStr(celkovySucet)+'$';

  inc(pocetVybranych);
  poleVybraneKod[pocetVybranych]:=poleKod[ItemIndex+1];
  poleVybraneMnozstvo[pocetVybranych]:=poleMnozstvo[ItemIndex+1];
  poleVybraneCena[pocetVybranych]:=poleCena[ItemIndex+1];
  Memo1.append(IntToStr(poleVybraneKod[pocetVybranych])+' '+IntToStr(poleVybraneMnozstvo[pocetVybranych])+' '+FloatToStr(poleVybraneCena[pocetVybranych]));

  ListBox1.ItemIndex:=-1;

  end;
end;

procedure TForm1.ListBox2Click(Sender: TObject);
var ItemIndex,mnozstvo:integer;
  ItemIndexText:string;
begin

   if((ListBox2.Items.count>0) AND (ListBox2.ItemIndex > -1)) then
  begin
  ItemIndex := ListBox2.ItemIndex;
  ItemIndexText:=ListBox2.Items[ListBox2.ItemIndex];
  mnozstvo := StrToInt(inputbox('Zadajte prosím nový počet ', 'Vaše nové množstvo:', '1'));
  celkovySucet:=celkovySucet+ (mnozstvo*poleVybraneCena[ItemIndex+1]) -poleVybraneMnozstvo[ItemIndex+1]*poleVybraneCena[ItemIndex+1];
  poleVybraneMnozstvo[ItemIndex+1]:=mnozstvo;
  ListBox2.Items.Delete (ItemIndex);
  ListBox2.Items.Add( poleTovar[ItemIndex+1]+' Množstvo:'+IntToStr(mnozstvo)+' Cena za kus'+FloatToStr(poleCena[ItemIndex+1])+'(Celkovo:'+FloatToStr(mnozstvo*poleCena[ItemIndex+1])+')');
  ListBox2.ItemIndex:=-1;
  Label5.caption:=FloatToStr(celkovySucet)+'$';

  end;
end;


end.

