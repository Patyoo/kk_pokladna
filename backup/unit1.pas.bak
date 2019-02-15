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
    Button10: TButton;
    Button11: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getDate();
    procedure Label1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Vypis();


  private
    { private declarations }
  public
    { public declarations }
  end;
const N=100;
var
  Form1: TForm1;
  myDate,today : TDateTime;
  CurrentTime,meno,medzera:string;
  subor,subor2:TextFile;
  celkovySucet:real;
  zrusit,reklamacia:boolean;
  pocet,pocetVybranych,verzia:integer;
  poleKod:array[1..N] of integer;
  poleMnozstvo:array[1..N] of integer;
  poleTovar:array[1..N] of String;
  poleCena:array[1..N] of real;
  poleKategorie:array[1..4] of String;
  poleAktivita:array[1..N] of integer;
  poleMnozstvoPovodne:array[1..N] of integer;


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

reklamacia:=false;
zrusit:=false;
pocetVybranych:=0;
verzia:=0;
Label5.Caption:='0.00€';
{AssignFile(subor2, 'STATISTIKY_'+IntToStr(verzia)+'.txt');
Rewrite(subor2);
DeleteFile('STATISTIKY_'+IntToStr(verzia)+'.txt');
}
meno:='';
celkovySucet:=0;
While(meno='') DO meno:= inputbox('Prosím zadajte meno pokladníka', 'Vaše meno:', '');
Label1.caption:='Meno pokladníka: '+meno;

assignFile(subor,'Kategorie.txt');
reset(subor);
FOR i:=1 to 4 DO
begin
Readln(subor,poleKategorie[i]);
end;
closeFile(subor);
Button3.Caption:=poleKategorie[1];
Button4.Caption:=poleKategorie[2];
Button5.Caption:=poleKategorie[3];
Button6.Caption:=poleKategorie[4];

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
  poleMnozstvoPovodne[pomocna]:=StrToInt(COPY(slovo,pozicia+1,length(slovo)));
  end;
closeFile(subor);

assignFile(subor,'Cennik.txt');
reset(subor);
readln(subor,pocet);
FOR i:=1 to pocet DO
begin
  readln(subor,slovo);
  IF(length(slovo)<4) THEN
    begin
    FOR y:=1 to pocet DO IF(StrToInt(slovo)=poleKod[y]) THEN pomocna:=y;
    poleAktivita[pomocna]:=0;
    poleCena[pomocna]:=0;
    end
  ELSE
    begin
    pozicia:=POS(';',slovo);
    pomocna:=StrToInt(COPY(slovo,1,pozicia-1));
    slovo:=COPY(slovo,pozicia+1,length(slovo));
    pozicia:=POS(';',slovo);
    FOR y:=1 to pocet DO IF(pomocna=poleKod[y]) THEN pomocna:=y;
    poleCena[pomocna]:=StrToFloat(COPY(slovo,pozicia+1,length(slovo))) /100;
    poleAktivita[pomocna]:=1;
    end;
end;
closeFile(subor);

FOR i:=1 to pocet DO
begin
  IF((poleAktivita[i])=0)THEN slovo:=poleTovar[i]+'*'
  ELSE slovo:=poleTovar[i];
  slovo:=slovo+StringOfChar(' ',10-Length(slovo));
  slovo:=slovo+IntToStr(poleKod[i]);
  ListBox1.Items.Add(slovo);
end;

Vypis();
 end;
procedure TForm1.Button7Click(Sender: TObject);
var i:integer;
begin
IF MessageDlg('Ste si istý, že chcete zrušiť účet?', mtConfirmation,[mbYes, mbNo], 0) = mrYes THEN
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
  Label5.Font.Color:=clRed;
  Timer2.enabled:=true;
  end
ELSE exit;
//zrusit ucet
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  zrusit:=true;
  reklamacia:=false;
  //zrusit polozku
end;

procedure TForm1.Button9Click(Sender: TObject);
var FirstItem,SecondItem,i,temp2,temp3,temp6,temp7,lastI:integer;
temp1,slovo:string;
temp4:real;
begin
ListBox1.Clear;
FOR FirstItem := pocet DOWNTO 2 DO
begin
  lastI:=1;
  FOR SecondItem:=1 TO FirstItem DO
  IF(poleTovar[SecondItem]>poleTovar[lastI]) THEN lastI:= SecondItem;

  temp1:=poleTovar[FirstItem];
  temp2:=poleKod[FirstItem];
  temp3:=poleMnozstvo[FirstItem];
  temp4:=poleCena[FirstItem];
  temp6:=poleAktivita[FirstItem];
  temp7:=poleMnozstvoPovodne[FirstItem];

  poleTovar[FirstItem] := poleTovar[lastI];
  poleKod[FirstItem]:=poleKod[lastI];
  poleMnozstvo[FirstItem]:=poleMnozstvo[lastI];
  poleCena[FirstItem]:=poleCena[lastI];
  poleAktivita[FirstItem]:=poleAktivita[lastI];
  poleMnozstvoPovodne[FirstItem]:=poleMnozstvoPovodne[lastI];

  poleTovar[lastI]:=temp1;
  poleKod[lastI]:=temp2;
  poleMnozstvo[lastI]:=temp3;
  poleCena[lastI]:=temp4;
  poleAktivita[lastI]:=temp6;
  poleMnozstvoPovodne[lastI]:=temp7;
end;

FOR i:=1 to pocet DO
begin
  slovo:=poleTovar[i];
  IF(poleAktivita[i]=0) THEN slovo:=slovo+'*';
  slovo:=slovo+StringOfChar(' ',10-Length(slovo));
  slovo:=slovo+IntToStr(poleKod[i]);
  ListBox1.Items.Add(slovo);
end;

end;
procedure TForm1.Button1Click(Sender: TObject);
var i,y,id:integer;
riadok,pom,pom1:string;
c:char;
skladList: TStringList;
begin
IF(pocetVybranych=0) THEN exit;
IF MessageDlg('Ste si istý, že váš nákup je dokončený?', mtConfirmation,[mbYes, mbNo], 0) = mrYes THEN
begin





  skladList:=TStringList.Create;
  skladList.LoadFromFile('Sklad.txt');

  FOR i:=1 to pocetVybranych DO
  begin
    FOR y:=1 to pocet DO
    begin

      IF(poleKod[y]=poleVybraneKod[i]) THEN
      begin
        pom:=IntToStr(poleKod[y])+';'+IntToStr(poleMnozstvo[y]+poleVybraneMnozstvo[i]);
        pom1:=IntToStr(poleKod[y])+';'+IntToStr(poleMnozstvo[y]);

        IF(poleMnozstvo[y]<0) THEN
        begin
          poleMnozstvo[y]:=0;
          pom1:=IntToStr(poleKod[y])+';'+IntToStr(poleMnozstvo[y]);
        end;


        IF((poleMnozstvoPovodne[y]>poleMnozstvo[y]) AND (poleMnozstvo[y]=0) )THEN
        begin
         poleMnozstvo[y]:=poleMnozstvoPovodne[y];
         pom:=IntToStr(poleKod[y])+';'+IntToStr(poleMnozstvo[y]);
        end;
        skladList.Text:=StringReplace(skladList.Text,pom,pom1,[rfIgnoreCase]);
        poleMnozstvoPovodne[y]:=poleMnozstvo[y];

      end;
    end;



  end;

  skladList.SaveToFile('Sklad.txt');
  skladList.Free;
  Vypis();
  getDate();
  id:=random(100000000)+1;
  c:='P';
  AssignFile(subor2, 'STATISTIKY_'+IntToStr(verzia)+'.txt');
  Rewrite(subor2);
  assignFile(subor,'Statistiky.txt');
  append(subor);

  FOR i:=1 to pocetVybranych DO
  Writeln(subor,c+';'+IntToStr(id)+';'+IntToStr(poleVybraneKod[i])+';'+IntTOStr(poleVybraneMnozstvo[i])+';'+FloatToStr(poleVybraneCena[i]* 100) +';'+CurrentTime);
  closeFile(subor);
  closeFile(subor2);
  DeleteFile('STATISTIKY_'+IntToStr(verzia)+'.txt');

  AssignFile(subor, 'Uctenka '+IntToStr(id)+'.txt');
  Rewrite(subor);
  riadok:=StringOfChar('-',25);
  riadok:=riadok+'KinderGarten';
  riadok:=riadok+StringOfChar('-',25);
  Writeln(subor,riadok);
  Writeln(subor,'ID:'+IntToStr(id));
  Writeln(subor,'Obsluhujúci pokladník: '+meno);
  Writeln(subor,DateToStr(today)+' , '+TimeToStr(today));
  Writeln(subor);

  For i:=1 to pocetVybranych DO
  begin
  Memo2.append(IntToStr(i)+':'+IntToStr(poleVybraneMnozstvo[i]));
   Memo2.append(IntToStr(i)+':'+FloatToStr(poleVybraneMnozstvo[i]*poleVybraneCena[i]));
    Memo2.append(IntToStr(i)+':'+IntToStr(poleVybraneMnozstvo[i])+'ks  '+'x   '+FloatToStr(poleVybraneCena[i]));

    riadok:=IntToStr(poleVybraneMnozstvo[i])+'ks '+poleVybraneTovar[i];
    riadok:=riadok+StringOfChar(' ',50-Length(riadok));
    riadok:=riadok+FloatToStr(poleVybraneMnozstvo[i]*poleVybraneCena[i])+'€';
    Writeln(subor,riadok);
    riadok:=IntToStr(poleVybraneMnozstvo[i])+'ks  '+'x   '+FloatToStr(poleVybraneCena[i])+' €';
    Writeln(subor,riadok);
    Writeln(subor);
  end;

  riadok:=StringOfChar(' ',30);
  riadok:=riadok+'Spolu: '+FloatToStr(celkovySucet)+'€';
  Writeln(subor,riadok);
  riadok:=StringOfChar('-',62);
  Writeln(subor,riadok);
  closeFile(subor);

  FOR i:=1 to pocetVybranych DO
  begin
    poleVybraneKod[i]:=0;
    poleVybraneMnozstvo[i]:=0;
    poleVybraneCena[i]:=0;
  end;

  pocetVybranych:=0;
  celkovySucet:=0;
  Label5.caption:=FloatToStr(celkovySucet)+'€';
  listbox2.Items.Clear();
end

else exit;
 //vytlacit ucet
end;
procedure TForm1.Button10Click(Sender: TObject);
var i,pom,index:integer;
slovo:string;
begin
index:=0;
ListBox1.Clear;

IF FileExists('TOP.txt') THEN
begin
assignFile(subor,'TOP.txt');
reset(subor);
While not eof(subor) DO
begin
inc(index);
readln(subor,pom);
FOR i:=1 to pocet DO
begin
IF(poleKod[i]=pom) THEN
begin
IF((poleAktivita[i])=0)THEN slovo:=poleTovar[i]+'*'
ELSE slovo:=poleTovar[i];
slovo:=slovo+StringOfChar(' ',10-Length(slovo));
slovo:=slovo+IntToStr(poleKod[i]);
ListBox1.Items.Add(slovo);
end;

end;
end;
end
ELSE exit;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
IF(ListBox2.Items.count=0) THEN
begin
  reklamacia:=true;
  zrusit:=false;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var answer,answer2,riadok,pom1,pom2:string;
  hladanyKod,i,y,mnozstvo,pom:integer;
  opakovane,najdene,success:boolean;
  skladList: TStringList;
begin
najdene:=false;
opakovane:=false;
IF InputQuery('Zadajte prosím hladaný kód tovaru','Váš kód:',Answer) = True then
begin



  success:=TryStrToInt(Answer, hladanyKod);
  IF not success then
  begin
    showmessage('Neplatný kód');
    exit;
  end;

  FOR i:=1 to pocet DO
  begin
    IF(poleKod[i]=hladanyKod) THEN
    begin

      najdene:=true;
      IF(poleAktivita[i]=0) THEN
      begin
        showmessage(poleTovar[i]+' sa nedá kúpiť');
        exit;
      end;

      IF InputQuery('Tovar:'+poleTovar[i],'Vaše požadované množstvo:',Answer2) = True THEN
      begin

        success:=TryStrToInt(Answer2, mnozstvo);
        IF not success then
        begin
          showmessage('Neplatné množstvo');
          exit;
        end;

        IF(mnozstvo<=0) THEN
        begin
          showmessage('Neplatné množstvo');
          exit;
        end;


            FOR y:=1 to pocetVybranych DO
            IF(poleVybraneKod[y]=hladanyKod) THEN
            begin
              opakovane:=true;
              pom:=y;
            end;
            celkovySucet:=celkovySucet+(mnozstvo*poleCena[i]);

            IF(opakovane=true) THEN
            begin

              poleVybraneMnozstvo[pom]:=poleVybraneMnozstvo[pom]+mnozstvo;
             skladList:=TStringList.Create;
             skladList.LoadFromFile('Sklad.txt');

        pom1:=IntToStr(poleKod[pom])+';'+IntToStr(poleMnozstvoPovodne[pom]);
        pom2:=IntToStr(poleKod[pom])+';'+IntToStr(poleVybraneMnozstvo[pom]);
        Memo2.append('pom1:'+pom1+',pom2:'+pom2+'*');
        skladList.Text:=StringReplace(skladList.Text,pom1,pom2,[rfIgnoreCase]);
        skladList.SaveToFile('Sklad.txt');
        skladList.Free;

         poleMnozstvoPovodne[pom]:= poleMnozstvoPovodne[pom]+mnozstvo;
         poleMnozstvo[pom]:=poleMnozstvo[pom]+mnozstvo;


              riadok:=poleVybraneTovar[pom];
              riadok:=riadok+StringOfChar(' ',15-Length(riadok));
              riadok:=riadok+IntToStr(poleVybraneMnozstvo[pom]);
              riadok:=riadok+StringOfChar(' ',25-Length(riadok));
              riadok:=riadok+FloatToStr(poleVybraneCena[pom]);
              riadok:=riadok+StringOfChar(' ',50-Length(riadok));
              riadok:=riadok+FloatToStr(poleVybraneMnozstvo[pom]*poleVybraneCena[pom]);
              ListBox2.Items[pom-1] := riadok;
              Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';
              Label5.Font.Color:=clGreen;
              Timer2.enabled:=true;
            end

            ELSE
            begin

            inc(pocetVybranych);
            poleVybraneKod[pocetVybranych]:=poleKod[i];
            poleVybraneTovar[pocetVybranych]:=poleTovar[i];
            poleVybraneMnozstvo[pocetVybranych]:=mnozstvo;            //poleMnozstvo[i];
            poleVybraneCena[pocetVybranych]:=poleCena[i];
            Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';
            IF(poleMnozstvo[i]<mnozstvo) THEN
            begin

            //poleVybraneMnozstvo[i]:=poleVybraneMnozstvo[i]+mnozstvo;
             skladList:=TStringList.Create;
             skladList.LoadFromFile('Sklad.txt');

             pom1:=IntToStr(poleKod[i])+';'+IntToStr(poleMnozstvo[i]);
             pom2:=IntToStr(poleKod[i])+';'+IntToStr(mnozstvo);
              Memo2.append('pom1:'+pom1+',pom2:'+pom2+'*');
              skladList.Text:=StringReplace(skladList.Text,pom1,pom2,[rfIgnoreCase]);
              skladList.SaveToFile('Sklad.txt');
              skladList.Free;

              poleMnozstvoPovodne[i]:=mnozstvo;
               poleMnozstvo[i]:=mnozstvo;

            end;



        // poleMnozstvoPovodne[i]:= poleMnozstvoPovodne[i]+mnozstvo;
         //poleMnozstvo[i]:=poleMnozstvo[i]+mnozstvo;

            riadok:=poleTovar[i];
            riadok:=riadok+StringOfChar(' ',15-Length(riadok));
            riadok:=riadok+IntToStr(mnozstvo);
            riadok:=riadok+StringOfChar(' ',25-Length(riadok));
            riadok:=riadok+FloatToStr(poleCena[i]);
            riadok:=riadok+StringOfChar(' ',50-Length(riadok));
            riadok:=riadok+FloatToStr(mnozstvo*poleCena[i]);

            ListBox2.Items.Add(riadok);
            Label5.Font.Color:=clGreen;
            Timer2.enabled:=true;
            exit;
            end;



{
        ELSE
        begin

        FOR y:=1 to pocetVybranych DO
        IF(poleVybraneKod[y]=hladanyKod) THEN
        begin
          opakovane:=true;
          pom:=y;
        end;
        celkovySucet:=celkovySucet+(mnozstvo*poleCena[i]);
 }  //toto budem POTREBOVAT
        {IF(opakovane=true) THEN
        begin
          poleVybraneMnozstvo[pom]:=poleVybraneMnozstvo[pom]+mnozstvo;
          //

          skladList:=TStringList.Create;
          skladList.LoadFromFile('Sklad.txt');

        pom1:=IntToStr(poleKod[pom])+';'+IntToStr(poleMnozstvoPovodne[pom]);
        pom2:=IntToStr(poleKod[pom])+';'+IntToStr( poleVybraneMnozstvo[pom]);
        Memo2.append('pom1:'+pom1+',pom2:'+pom2+'*');
        skladList.Text:=StringReplace(skladList.Text,pom1,pom2,[rfIgnoreCase]);
        skladList.SaveToFile('Sklad.txt');
        skladList.Free;

         poleMnozstvoPovodne[pom]:= poleMnozstvoPovodne[pom]+mnozstvo;
         poleMnozstvo[pom]:=poleMnozstvo[pom]+mnozstvo;


          riadok:=poleVybraneTovar[pom];
          riadok:=riadok+StringOfChar(' ',15-Length(riadok));
          riadok:=riadok+IntToStr(poleVybraneMnozstvo[pom]);
          riadok:=riadok+StringOfChar(' ',25-Length(riadok));
          riadok:=riadok+FloatToStr(poleVybraneCena[pom]);
          riadok:=riadok+StringOfChar(' ',50-Length(riadok));
          riadok:=riadok+FloatToStr(poleVybraneMnozstvo[pom]*poleVybraneCena[pom]);

          ListBox2.Items[pom-1] := riadok;
          Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';
          Label5.Font.Color:=clGreen;
          Timer2.enabled:=true;
        end }

        {else
        begin
          inc(pocetVybranych);
          poleVybraneKod[pocetVybranych]:=poleKod[i];
          poleVybraneTovar[pocetVybranych]:=poleTovar[i];
          poleVybraneMnozstvo[pocetVybranych]:=poleMnozstvo[i];
          poleVybraneCena[pocetVybranych]:=poleCena[i];
          Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';
          poleMnozstvo[i]:=mnozstvo;

          riadok:=poleTovar[i];
          riadok:=riadok+StringOfChar(' ',15-Length(riadok));
          riadok:=riadok+IntToStr(mnozstvo);
          riadok:=riadok+StringOfChar(' ',25-Length(riadok));
          riadok:=riadok+FloatToStr(poleCena[i]);
          riadok:=riadok+StringOfChar(' ',50-Length(riadok));
          riadok:=riadok+FloatToStr(mnozstvo*poleCena[i]);

          ListBox2.Items.Add(riadok);
          Label5.Font.Color:=clGreen;
          Timer2.enabled:=true;
          exit;
        end; }
        end;
      end     //
      ELSE exit;
    end;
  end;

  IF(najdene=false) THEN
  begin
    showmessage('Váš kód sa nezhoduje so žiadnym tovarom');
    exit;
  end;

  // TIEZ BUDEM POTREBOVATend

  //Ked je neaktivny tovar
end;

procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
slovo:string;
begin
//1 kod
ListBox1.Clear;
FOR i:=1 to pocet DO
IF((poleKod[i]<200)) THEN
begin
  IF((poleAktivita[i])=0)THEN slovo:=poleTovar[i]+'*'
  ELSE slovo:=poleTovar[i];
  slovo:=slovo+StringOfChar(' ',10-Length(slovo));
  slovo:=slovo+IntToStr(poleKod[i]);
  ListBox1.Items.Add(slovo);
end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var i:integer;
slovo:string;
begin
ListBox1.Clear;
FOR i:=1 to pocet DO
IF((poleKod[i]>199) AND (poleKod[i]<300) ) THEN
begin
  IF((poleAktivita[i])=0)THEN slovo:=poleTovar[i]+'*'
  ELSE slovo:=poleTovar[i];
  slovo:=slovo+StringOfChar(' ',10-Length(slovo));
  slovo:=slovo+IntToStr(poleKod[i]);
  ListBox1.Items.Add(slovo);
end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var i:integer;
slovo:string;
begin
ListBox1.Clear;
FOR i:=1 to pocet DO
IF((poleKod[i]>299) AND (poleKod[i]<400) ) THEN
begin
  IF((poleAktivita[i])=0)THEN slovo:=poleTovar[i]+'*'
  ELSE slovo:=poleTovar[i];
  slovo:=slovo+StringOfChar(' ',10-Length(slovo));
  slovo:=slovo+IntToStr(poleKod[i]);
  ListBox1.Items.Add(slovo);
end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var i:integer;
slovo:string;
begin
ListBox1.Clear;
FOR i:=1 to pocet DO
IF((poleKod[i]>399)) THEN
begin
  IF((poleAktivita[i])=0)THEN slovo:=poleTovar[i]+'*'
  ELSE slovo:=poleTovar[i];
  slovo:=slovo+StringOfChar(' ',10-Length(slovo));
  slovo:=slovo+IntToStr(poleKod[i]);
  ListBox1.Items.Add(slovo);
end;
end;

procedure TForm1.getDate();
begin
myDate:= StrToDate(DateToStr(now));
DateTimeToString(CurrentTime,'yymmdd', myDate);
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
IF(ListBox2.Items.count=0) THEN
begin
  meno:='';
  celkovySucet:=0;
  While(meno='') DO meno:= inputbox('Prosím zadajte nové meno pokladníka', 'Vaše meno:', '');
  Label1.caption:='Meno pokladníka: '+meno;
  end
ELSE exit;

end;

procedure TForm1.ListBox1Click(Sender: TObject);
var ItemIndex,mnozstvo,i,pom,pozicia,index:integer;
answer,slovo,riadok,pom1,pom2:string;
opakovane,success:boolean;
skladList: TStringList;
begin

opakovane:=false;
ItemIndex := ListBox1.ItemIndex;

IF((ListBox1.Items.count>0) AND (ItemIndex > -1)) THEN
begin

  slovo:=ListBox1.Items[ItemIndex];
  pozicia:=POS(' ',slovo);
  slovo:=COPY(slovo,1,pozicia-1);
  IF( (POS('*',slovo)<>0) ) THEN slovo:=COPY(slovo,0,length(slovo)-1);
  FOR i:=1 TO pocet DO IF(poleTovar[i]=slovo) THEN index:=i;

  IF(poleAktivita[index]=0) THEN
  begin
    showmessage( poleTovar[index]+' sa žiaľ nedá nakúpiť.');
    exit;
  end;

  IF InputQuery('Zadajte prosím množstvo','Vaše požadované množstvo',Answer) = True THEN
  begin
    success:=TryStrToInt(Answer, mnozstvo);
    IF not success THEN
    begin
      showmessage('Neplatné množstvo');
      exit;
    end;
  end
  ELSE exit;

  IF(mnozstvo<=0) THEN
  begin
    showmessage('Neplatné množstvo');
    exit;
  end;

      FOR i:=1 to pocetVybranych DO
      IF(poleVybraneTovar[i]=slovo) THEN
      begin
        opakovane:=true;
        pom:=i;
      end;

      IF(opakovane=true) THEN
      begin
        poleVybraneMnozstvo[pom]:=poleVybraneMnozstvo[pom]+mnozstvo;

             skladList:=TStringList.Create;
             skladList.LoadFromFile('Sklad.txt');

        pom1:=IntToStr(poleKod[pom])+';'+IntToStr(poleMnozstvoPovodne[pom]);
        pom2:=IntToStr(poleKod[pom])+';'+IntToStr( poleVybraneMnozstvo[pom]);
        Memo2.append('pom1:'+pom1+',pom2:'+pom2+'*');
        skladList.Text:=StringReplace(skladList.Text,pom1,pom2,[rfIgnoreCase]);
        skladList.SaveToFile('Sklad.txt');
        skladList.Free;

         poleMnozstvoPovodne[pom]:= poleMnozstvoPovodne[pom]+mnozstvo;
         poleMnozstvo[pom]:=poleMnozstvo[pom]+mnozstvo;


        riadok:=poleVybraneTovar[pom];
        riadok:=riadok+StringOfChar(' ',15-Length(riadok));
        riadok:=riadok+IntToStr(poleVybraneMnozstvo[pom]);
        riadok:=riadok+StringOfChar(' ',25-Length(riadok));
        riadok:=riadok+FloatToStr(poleVybraneCena[pom]);
        riadok:=riadok+StringOfChar(' ',50-Length(riadok));
        riadok:=riadok+FloatToStr(poleVybraneMnozstvo[pom]*poleVybraneCena[pom]);

        ListBox2.Items[pom-1] :=riadok;
        celkovySucet:=celkovySucet+(mnozstvo*poleVybraneCena[pom]);
        Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';
        Label5.Font.Color:=clGreen;
        Timer2.enabled:=true;
      end

      ELSE
      begin
        FOR i:=1 TO pocet DO IF(poleTovar[i]=slovo) THEN index:=i;
        celkovySucet:=celkovySucet+(mnozstvo*poleCena[index]);

        //
        IF(poleMnozstvo[index]<mnozstvo) THEN
         begin

    skladList:=TStringList.Create;
    skladList.LoadFromFile('Sklad.txt');

        pom1:=IntToStr(poleKod[index])+';'+IntToStr(poleMnozstvo[index]);
        pom2:=IntToStr(poleKod[index])+';'+IntToStr(mnozstvo);
        Memo2.append('pom1:'+pom1+',pom2:'+pom2);
        skladList.Text:=StringReplace(skladList.Text,pom1,pom2,[rfIgnoreCase]);
        skladList.SaveToFile('Sklad.txt');
        skladList.Free;

         poleMnozstvoPovodne[index]:=mnozstvo;
         poleMnozstvo[index]:=mnozstvo;
        end;
        //

        poleMnozstvo[index]:= poleMnozstvo[index]-mnozstvo;         //davam dole mnozstvo,neviem ci to treba
        Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';

        riadok:=poleTovar[index];
        riadok:=riadok+StringOfChar(' ',15-Length(riadok));
        riadok:=riadok+IntToStr(mnozstvo);
        riadok:=riadok+StringOfChar(' ',25-Length(riadok));
        riadok:=riadok+FloatToStr(poleCena[index]);
        riadok:=riadok+StringOfChar(' ',50-Length(riadok));
        riadok:=riadok+FloatToStr(mnozstvo*poleCena[index]);
        ListBox2.Items.Add(riadok);

        inc(pocetVybranych);
        poleVybraneKod[pocetVybranych]:=poleKod[index];
        poleVybraneTovar[pocetVybranych]:=poleTovar[index];
        poleVybraneMnozstvo[pocetVybranych]:=mnozstvo;
        poleVybraneCena[pocetVybranych]:=poleCena[index];
        Memo1.append(IntToStr(poleVybraneKod[pocetVybranych])+' '+IntToStr(poleVybraneMnozstvo[pocetVybranych])+' '+FloatToStr(poleVybraneCena[pocetVybranych]));
        Label5.Font.Color:=clGreen;
        Timer2.enabled:=true;
      end;
end;

  ListBox2.ItemIndex:=-1;
  ListBox1.ItemIndex:=-1;
  Vypis();
end;



procedure TForm1.ListBox2Click(Sender: TObject);
var ItemIndex,mnozstvo,i,y,pozicia,index:integer;
answer,riadok,slovo,pom,pom1:string;
success:boolean;
skladList: TStringList;
begin

IF((ListBox2.Items.count>0) AND (ListBox2.ItemIndex > -1) AND (zrusit=false) AND (reklamacia=false)) THEN
begin
  IF InputQuery('Zadajte prosím nové množstvo','Vaše zbrusunové množstvo',Answer) = True THEN
  begin
    success:=TryStrToInt(Answer, mnozstvo);
    IF not success THEN
    begin
      showmessage('Neplatné množstvo');
      exit;
    end;
  end
  ELSE exit;


  ItemIndex := ListBox2.ItemIndex;

  slovo:=ListBox2.Items[ItemIndex];
  pozicia:=POS(' ',slovo);
  slovo:=COPY(slovo,1,pozicia-1);
  IF( (POS('*',slovo)<>0) ) THEN slovo:=COPY(slovo,0,length(slovo)-1);
  FOR i:=1 TO pocet DO IF(poleTovar[i]=slovo) THEN index:=i;
  poleMnozstvo[index]:=poleMnozstvoPovodne[index];

  IF(mnozstvo<=0) THEN
  begin
    showmessage('Neplatné množstvo');
    exit;
  end;


  FOR i:=1 to pocetVybranych DO
  begin
    FOR y:=1 to pocet DO
    begin
      IF(poleKod[y]=poleVybraneKod[i]) THEN
      begin
        IF(poleMnozstvo[y]<mnozstvo) THEN
        begin

        skladList:=TStringList.Create;
        skladList.LoadFromFile('Sklad.txt');

        pom:=IntToStr(poleKod[y])+';'+IntToStr(poleMnozstvo[y]);
        pom1:=IntToStr(poleKod[y])+';'+IntToStr(mnozstvo);
        Memo2.append('pom:'+pom+',pom1:'+pom1);
        skladList.Text:=StringReplace(skladList.Text,pom,pom1,[rfIgnoreCase]);
        skladList.SaveToFile('Sklad.txt');
        skladList.Free;

         poleMnozstvoPovodne[y]:=mnozstvo;
         poleMnozstvo[y]:=mnozstvo;
        end;
      end;
    end;
  end;


  celkovySucet:=celkovySucet+ (mnozstvo*poleVybraneCena[ItemIndex+1]) -poleVybraneMnozstvo[ItemIndex+1]*poleVybraneCena[ItemIndex+1];
  poleVybraneMnozstvo[ItemIndex+1]:=mnozstvo;
  poleMnozstvo[index]:=poleMnozstvo[index]-mnozstvo;
  ListBox2.Items.Delete (ItemIndex);

  riadok:=poleVybraneTovar[ItemIndex+1];
  riadok:=riadok+StringOfChar(' ',15-Length(riadok));
  riadok:=riadok+IntToStr(mnozstvo);
  riadok:=riadok+StringOfChar(' ',25-Length(riadok));
  riadok:=riadok+FloatToStr(poleVybraneCena[ItemIndex+1]);
  riadok:=riadok+StringOfChar(' ',50-Length(riadok));
  riadok:=riadok+FloatToStr(mnozstvo*poleVybraneCena[ItemIndex+1]);
  ListBox2.Items.Add(riadok);

  ListBox2.ItemIndex:=-1;
  Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';
  Label5.Font.Color:=clGreen;
  Timer2.enabled:=true;
 Vypis();
end;

//zrusit ucet

IF((ListBox2.Items.count>0) AND (ListBox2.ItemIndex > -1) AND (zrusit=true) AND (reklamacia=false)) THEN
begin
  ItemIndex := ListBox2.ItemIndex;
  i:=ItemIndex+1;

  IF MessageDlg('Ste si istý, že chcete zrušiť '+poleVybraneTovar[i]+'?', mtConfirmation,[mbYes, mbNo], 0) = mrYes THEN
  begin
    celkovySucet:=celkovySucet-(poleVybraneMnozstvo[ItemIndex+1]*poleVybraneCena[ItemIndex+1]);
    Label5.caption:=FormatFloat('0.##',(celkovySucet))+'€';

  slovo:=ListBox2.Items[ItemIndex];
  pozicia:=POS(' ',slovo);
  slovo:=COPY(slovo,1,pozicia-1);
  IF( (POS('*',slovo)<>0) ) THEN slovo:=COPY(slovo,0,length(slovo)-1);
  FOR i:=1 TO pocet DO IF(poleTovar[i]=slovo) THEN index:=i;
  poleMnozstvo[index]:=poleMnozstvoPovodne[index];

    FOR i:=ItemIndex+1 TO (pocetVybranych-1) DO
    begin
      poleVybraneKod[i]:=poleVybraneKod[i+1];
      poleVybraneTovar[i]:=poleVybraneTovar[i+1];
      poleVybraneMnozstvo[i]:= poleVybraneMnozstvo[i+1];
      poleVybraneCena[i]:=poleVybraneCena[i+1];

      riadok:=poleVybraneTovar[i];
      riadok:=riadok+StringOfChar(' ',15-Length(riadok));
      riadok:=riadok+IntToStr(poleVybraneMnozstvo[i]);
      riadok:=riadok+StringOfChar(' ',25-Length(riadok));
      riadok:=riadok+FloatToStr(poleVybraneCena[i]);
      riadok:=riadok+StringOfChar(' ',50-Length(riadok));
      riadok:=riadok+FloatToStr(poleVybraneMnozstvo[i]*poleVybraneCena[i]);
      ListBox2.Items[i-1]:=riadok;
    end;

    ListBox2.Items.Delete(pocetVybranych-1);
    poleVybraneKod[pocetVybranych]:=0;
    poleVybraneTovar[pocetVybranych]:='';
    poleVybraneMnozstvo[pocetVybranych]:=0;
    poleVybraneCena[pocetVybranych]:=0;
    pocetVybranych:=pocetVybranych-1;
    zrusit:=false;
    Vypis();
  end;
  exit;
end;

ListBox2.ItemIndex:=-1;
ListBox1.ItemIndex:=-1;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
today := Now;
Label6.caption:=DateToStr(today)+' , '+TimeToStr(today);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
Label5.Font.Color:=clBlack;
Timer2.enabled:=false;
end;

procedure TForm1.Vypis();
var x:integer;
begin
Memo1.clear();

FOR x:=1 TO pocet DO
begin
  Memo1.append('Normalne hodnoty:');
  Memo1.append('Kod:'+IntToStr(poleKod[x]));
  Memo1.append('Mnozstvo:'+IntToStr(poleMnozstvo[x]));
  Memo1.append('Tovar:'+poleTovar[x]);
  Memo1.append('Cena:'+FloatToStr(poleCena[x]));
  Memo1.append('Aktivita:'+ IntToStr(poleAktivita[x]));
  Memo1.append('Povodne Mnozstvo:'+IntToStr(poleMnozstvoPovodne[x]));
  Memo1.append('*');
end;

FOR x:=1 TO pocetVybranych DO
begin
  Memo1.append('selected hodnoty:');
  Memo1.append('Kod:'+IntToStr(poleVybraneKod[x]));
  Memo1.append('Mnozstvo:'+IntToStr(poleVybraneMnozstvo[x]));
  Memo1.append('Tovar:'+poleVybraneTovar[x]);
  Memo1.append('Cena:'+FloatToStr(poleVybraneCena[x]));
  Memo1.append('---');
end;

end;

end.

