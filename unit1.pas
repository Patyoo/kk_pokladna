unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

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
    Label6: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getDate();
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
const N=100;
var
  Form1: TForm1;
  myDate,today : TDateTime;
  CurrentTime,meno:string;
  subor,subor2:TextFile;
  celkovySucet:real;
  pocet,pocetVybranych,verzia:integer;
  poleKod:array[1..N] of integer;
  poleMnozstvo:array[1..N] of integer;
  poleTovar:array[1..N] of String;
  poleCena:array[1..N] of real;

  poleVybraneKod:array[1..N] of integer;
  poleVybraneTovar:array[1..N] of string;
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
   verzia:=0;

   {AssignFile(subor2, 'STATISTIKY_'+IntToStr(verzia)+'.txt');
   Rewrite(subor2);
   DeleteFile('STATISTIKY_'+IntToStr(verzia)+'.txt');
   }

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

  if MessageDlg('Ste si istý,že chcete zrušiť účet?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes Then
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
    end
  else
    exit;





  //zrusit ucet
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,id:integer;
  c:char;
begin

  if MessageDlg('Ste si istý,že váš nákup je dokončený?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes Then
        begin

           getDate();
           id:=random(100000000)+1;
           c:='P';
           AssignFile(subor2, 'STATISTIKY_'+IntToStr(verzia)+'.txt');
           Rewrite(subor2);
           assignFile(subor,'Statistiky.txt');
           append(subor);
           FOR i:=1 to pocetVybranych DO
           Writeln(subor,c+';'+IntToStr(id)+';'+IntToStr(poleVybraneKod[i])+';'+IntTOStr(poleVybraneMnozstvo[i])+';'+FloatToStr(poleVybraneCena[i])+';'+CurrentTime);
           closeFile(subor);
           closeFile(subor2);
           DeleteFile('STATISTIKY_'+IntToStr(verzia)+'.txt');

            AssignFile(subor, 'Uctenka '+IntToStr(id)+'.txt');
            Rewrite(subor);
            Writeln(subor,IntToStr(id));
            For i:=1 to pocetVybranych DO
            begin
              Writeln(subor,poleVybraneTovar[i]+';'+IntToStr(poleVybraneMnozstvo[i])+';'+FloatToStr(poleVybraneCena[i]));
            end;
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

        end
  else
      exit;



 //vytlacit ucet
end;

procedure TForm1.Button2Click(Sender: TObject);
var answer,answer2:string;
  hladanyKod,i,mnozstvo:integer;
begin


   IF InputQuery('Zadajte prosím hladaný kód','Váš kód:',Answer) = True then
     begin
       hladanyKod:=StrToInt(answer);
       FOR i:=1 to pocet DO
       begin
         IF(poleKod[i]=hladanyKod) THEN
         begin
           if InputQuery('Zadajte prosím množstvo','Vaše požadované množstvo',Answer2) = True then
           begin
             mnozstvo:=StrToInt(answer2);
             inc(pocetVybranych);
             poleVybraneKod[pocetVybranych]:=poleKod[i];
             poleVybraneTovar[pocetVybranych]:=poleTovar[i];
             poleVybraneMnozstvo[pocetVybranych]:=poleMnozstvo[i];
             poleVybraneCena[pocetVybranych]:=poleCena[i];
             celkovySucet:=celkovySucet+(mnozstvo*poleCena[i]);
             poleMnozstvo[i]:=mnozstvo;
             ListBox2.Items.Add( poleTovar[i]+' Množstvo:'+IntToStr(mnozstvo)+' Cena za kus'+FloatToStr(poleCena[i])+'(Celkovo:'+FloatToStr(mnozstvo*poleCena[i])+')');
             Label5.caption:=FloatToStr(celkovySucet)+'$';
             exit;
           end
           else exit;
         end
         else
         begin
           showmessage('Vaše kód sa nezhoduje so žiadnym tovarom');
           exit;
         end;
       end;
     end
   ELSE
   exit;

  //Vyhladat kod tovaru a pridat mnozstvo
end;

procedure TForm1.getDate();
begin
    myDate:= StrToDate(DateToStr(now));
    DateTimeToString(CurrentTime,'ddmmyy', myDate);
  // DateTimeToString(CurrentTime,'yymmdd', myDate);   talex

end;

procedure TForm1.ListBox1Click(Sender: TObject);
var ItemIndex,mnozstvo:integer;
  ItemIndexText,answer:string;
begin



 if((ListBox1.Items.count>0) AND (ListBox1.ItemIndex > -1)) then
  begin

    if InputQuery('Zadajte prosím množstvo','Vaše požadované množstvo',Answer) = True then mnozstvo:=StrToInt(answer)
    else exit;

  ItemIndex := ListBox1.ItemIndex;
  ItemIndexText:=ListBox1.Items[ListBox1.ItemIndex];
  celkovySucet:=celkovySucet+(mnozstvo*poleCena[ItemIndex+1]);
  poleMnozstvo[ItemIndex+1]:=mnozstvo;
  ListBox2.Items.Add( poleTovar[ItemIndex+1]+' Množstvo:'+IntToStr(mnozstvo)+' Cena za kus:'+FloatToStr(poleCena[ItemIndex+1])+' (Celkovo:'+FloatToStr(mnozstvo*poleCena[ItemIndex+1])+')');
  Label5.caption:=FloatToStr(celkovySucet)+'$';

  inc(pocetVybranych);
  poleVybraneKod[pocetVybranych]:=poleKod[ItemIndex+1];
  poleVybraneTovar[pocetVybranych]:=poleTovar[Itemindex+1];
  poleVybraneMnozstvo[pocetVybranych]:=poleMnozstvo[ItemIndex+1];
  poleVybraneCena[pocetVybranych]:=poleCena[ItemIndex+1];
  Memo1.append(IntToStr(poleVybraneKod[pocetVybranych])+' '+IntToStr(poleVybraneMnozstvo[pocetVybranych])+' '+FloatToStr(poleVybraneCena[pocetVybranych]));

  ListBox1.ItemIndex:=-1;

  end;
end;

procedure TForm1.ListBox2Click(Sender: TObject);
var ItemIndex,mnozstvo:integer;
  ItemIndexText,answer:string;
begin

   if((ListBox2.Items.count>0) AND (ListBox2.ItemIndex > -1)) then
  begin

  if InputQuery('Zadajte prosím nové množstvo','Vaše zbrusunové množstvo',Answer) = True then mnozstvo:=StrToInt(answer)
    else exit;

  ItemIndex := ListBox2.ItemIndex;
  ItemIndexText:=ListBox2.Items[ListBox2.ItemIndex];
  celkovySucet:=celkovySucet+ (mnozstvo*poleVybraneCena[ItemIndex+1]) -poleVybraneMnozstvo[ItemIndex+1]*poleVybraneCena[ItemIndex+1];
  poleVybraneMnozstvo[ItemIndex+1]:=mnozstvo;
  ListBox2.Items.Delete (ItemIndex);
  ListBox2.Items.Add( poleTovar[ItemIndex+1]+' Množstvo:'+IntToStr(mnozstvo)+' Cena za kus'+FloatToStr(poleCena[ItemIndex+1])+'(Celkovo:'+FloatToStr(mnozstvo*poleCena[ItemIndex+1])+')');
  ListBox2.ItemIndex:=-1;
  Label5.caption:=FloatToStr(celkovySucet)+'$';

  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  today := Now;
  Label6.caption:=DateToStr(today)+' , '+TimeToStr(today);
end;


end.

