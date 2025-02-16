{
  En astrofísica, una galaxia se identifica por su nombre, su tipo (1. elíptica; 2. espiral; 3. lenticular; 4.
  irregular), su masa (medida en kg) y la distancia en pársecs (pc) medida desde la Tierra. La Unión
  Astronómica Internacional cuenta con datos correspondientes a las 53 galaxias que componen el Grupo
  Local. Realizar un programa que lea y almacene estos datos y, una vez finalizada la carga, informe:
  a)  la cantidad de galaxias de cada tipo.
  b)  la masa total acumulada de las 3 galaxias principales (la Vía Láctea, Andrómeda y Triángulo) y el
      porcentaje que esto representa respecto a la masa de todas las galaxias.
  c)  la cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc.
  d)  el nombre de las dos galaxias con mayor masa y el de las dos galaxias con menor masa.
}
program ejercicio12;
const
  maxGalaxias = 5; { 53 }
  
type
  rangoTipoGalaxia = 1..4;
  galaxia = record
    nom: string;
    tipo: rangoTipoGalaxia;
    masa, dist: integer;
  end;
  vecGalaxias = array[1..maxGalaxias] of galaxia;

procedure leerGalaxia(var g: galaxia);
begin
  write('Ingrese nombre: ');readln(g.nom);
  write('Ingrese tipo (1-4): ');readln(g.tipo);
  write('Ingrese masa: ');readln(g.masa);
  write('Ingrese distancia a la tierra: ');readln(g.dist);
  writeln();
end;

procedure cargarGalaxias(var v: vecGalaxias);
var
  i: integer;
  g: galaxia;
begin
  for i := 1 to maxGalaxias do begin
    leerGalaxia(g);
    v[i] := g;
  end;
end;

procedure imprimirCantGalaxiasPorTipo(v: vecGalaxias);
var
  cantTipo1, cantTipo2, cantTipo3, cantTipo4, i: integer;
begin
  cantTipo1 := 0; cantTipo2 := 0; cantTipo3 := 0; cantTipo4 := 0;
  for i := 1 to maxGalaxias do
    case v[i].tipo of
      1:  cantTipo1 := cantTipo1 + 1;
      2:  cantTipo2 := cantTipo2 + 1;
      3:  cantTipo3 := cantTipo3 + 1;
      4:  cantTipo4 := cantTipo4 + 1;
    end;
  writeln('La cantidad de galaxias de tipo eliptica es: ', cantTipo1);
  writeln('La cantidad de galaxias de tipo espiral es: ', cantTipo2);
  writeln('La cantidad de galaxias de tipo lenticular es: ', cantTipo3);
  writeln('La cantidad de galaxias de tipo irregular es: ', cantTipo4);
end;

procedure calcularMasaTotalGalaxiasPrincipales(v: vecGalaxias;var masa3GP: integer;var porceMasa3GP: real);
var
  masaTotal, i: integer;
begin
  masaTotal := 0;
  for i := 1 to maxGalaxias do begin
    if (v[i].nom = 'Via Lactea') or (v[i].nom = 'Andromeda') or (v[i].nom = 'Triangulo') then
      masa3GP := masa3GP + v[i].masa;
    masaTotal := masaTotal + v[i].masa;
  end;
  porceMasa3GP := (masa3GP / masaTotal) * 100;
end;

function cantNoIrreMen1Mpc(v: vecGalaxias): integer;
var
  i, cant: integer;
begin
  cant := 0;
  for i := 1 to maxGalaxias do
    if (v[i].tipo <> 4) and (v[i].dist < 1000) then
      cant := cant + 1;
  cantNoIrreMen1Mpc := cant;
end;

procedure calcularMaxYminGalaxiasPorMasa(v: vecGalaxias;var max1, max2, min1, min2: integer;var nomMax1, nomMax2, nomMin1, nomMin2: string);
var
  i: integer;
begin
  for i := 1 to maxGalaxias do begin
    if (v[i].masa > max1) then begin
      max2 := max1;
      nomMax2 := nomMax1;
      max1 := v[i].masa;
      nomMax1 := v[i].nom;
    end
    else
      if (v[i].masa > max2) then begin
        max2 := v[i].masa;
        nomMax2 := v[i].nom;
      end;
    if (v[i].masa < min1) then begin
      min2 := min1;
      nomMin2 := nomMin1;
      min1 := v[i].masa;
      nomMin1 := v[i].nom;
    end
    else
      if (v[i].masa < min2) then begin
        min2 := v[i].masa;
        nomMin2 := v[i].nom;
      end;
  end;
end;

var
  v: vecGalaxias;
  masa3GP, max1, max2, min1, min2: integer;
  nomMax1, nomMax2, nomMin1, nomMin2: string;
  porceMasa3GP: real;
begin
  masa3GP := 0; max1:= -1; max2:= -1; min1:= 32767; min2:= 32767;
  cargarGalaxias(v);
  imprimirCantGalaxiasPorTipo(v);
  calcularMasaTotalGalaxiasPrincipales(v, masa3GP, porceMasa3GP);
  writeln('Masa total de las 3 galaxias principales (la Via Lactea, Andromeda y Triangulo) es: ', masa3GP);
  writeln('Porcentaje de la masa de las 3 principales galaxias respecto a todas: ', porceMasa3GP:0:2);
  writeln('Cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc: ', cantNoIrreMen1Mpc(v));
  calcularMaxYminGalaxiasPorMasa(v, max1, max2, min1, min2, nomMax1, nomMax2, nomMin1, nomMin2);
  writeln('Las dos galaxias con mas masa son: ', nomMax1 ,' y ', nomMax2);
  writeln('Las dos galaxias con menos masa son: ', nomMin1 ,' y ', nomMin2);
end.