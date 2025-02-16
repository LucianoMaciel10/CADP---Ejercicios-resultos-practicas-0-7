{
  Realizar un programa que lea información de centros de investigación de Universidades Nacionales. De cada
  centro se lee su nombre abreviado (ej. LIDI, LIFIA, LINTI), la universidad a la que pertenece, la cantidad de
  investigadores y la cantidad de becarios que poseen. La información se lee de forma consecutiva por universidad y
  la lectura finaliza al leer un centro con 0 investigadores, que no debe procesarse. Informar:
  ● Cantidad total de centros para cada universidad.
  ● Universidad con mayor cantidad de investigadores en sus centros.
  ● Los dos centros con menor cantidad de becarios.
}
program ejercicio7;
type
  centro = record
    nom, uni: string;
    cantInv, cantBec: integer;
  end;

procedure leerCentro (var c: centro);
begin
  write('Ingresar cantidad de investigadores: ');readln(c.cantInv);
  if (c.cantInv <> 0) then begin
    write('Ingresar nombre: ');readln(c.nom);
    write('Ingresar universidad a la que pertenece: ');readln(c.uni);
    write('Ingresar cantidad de becarios: ');readln(c.cantBec);
    writeln();
  end;
end;

procedure calcularMaxInvPorUni(uniAct: string; totalInvUni: integer;var maxInv: integer;var maxUni: string);
begin
  if (totalInvUni > maxInv) then begin
    maxInv := totalInvUni;
    maxUni := uniAct;
  end;
end;

procedure calcularCentrosMinBecarios(nom: string; cantBec: integer;var minBec1, minBec2: integer;var minCen1, minCen2: string);
begin
  if (cantBec < minBec1) then begin
    minBec2 := minBec1;
    minCen2 := minCen1;
    minBec1 := cantBec;
    minCen1 := nom;
  end
  else begin
    if (cantBec < minBec2) then begin
      minBec2 := cantBec;
      minCen2 := nom;
    end;
  end;
end;

var
  c: centro;
  uniAct, maxUni, minCen1, minCen2: string;
  totalCentroPorUni, maxInv, totalInvUni, minBec1, minBec2: integer;
begin
  minBec1 := 32767; minBec2 := 32767; maxInv := 0;
  leerCentro(c);
  while (c.cantInv <> 0) do begin
    uniAct := c.uni; totalCentroPorUni := 0; totalInvUni := 0;
    while (c.cantInv <> 0) and (uniAct = c.uni) do begin
      totalCentroPorUni := totalCentroPorUni + 1;
      totalInvUni := totalInvUni + c.cantInv;
      calcularCentrosMinBecarios(c.nom, c.cantBec, minBec1, minBec2, minCen1, minCen2);
      leerCentro(c);
    end;
    calcularMaxInvPorUni(uniAct, totalInvUni, maxInv, maxUni);
    writeln('La cantidad total de centros de la universidad ', uniAct ,' es: ', totalCentroPorUni);
  end;
  if (maxUni <> '') then
    writeln('La universidad con mas investigadores es: ', maxUni);
  if (minCen1 <> '') then
    writeln('Los dos centro con menos becarios son: ', minCen1,' y ', minCen2);
end.