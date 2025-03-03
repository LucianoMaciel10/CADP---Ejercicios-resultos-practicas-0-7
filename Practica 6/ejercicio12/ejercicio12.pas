{
  Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de
  todos los dispositivos que poseen sus juegos instalados. De cada dispositivo se conoce la versión de Android
  instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee (medida en GB).
  La información disponible se encuentra ordenada por versión de Android. Realizar un programa que procese
  la información disponible de todos los dispositivos e informe:
  a. La cantidad de dispositivos para cada versión de Android.
  b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
  c. El tamaño promedio de las pantallas de todos los dispositivos.
}
program ejercicio12;
type
  dispositivo = record
    ver, tam: real;
    ram: integer;
  end;
  lista = ^nodo;
  nodo = record 
    dato: dispositivo;
    sig: lista;
  end;

procedure leerDispositivo(var d: dispositivo);
begin
  write('Ingrese version: ');readln(d.ver);
  if (d.ver <> -1) then begin
    write('Ingrese cantidad de RAM: ');readln(d.ram);
    write('Ingrese tamanio de la pantalla: ');readln(d.tam);
    writeln();
  end;
end;

procedure cargarLista(var l: lista; d: dispositivo);
var
  ant, act, nue: lista;
begin
  new(nue); nue^.dato := d;
  ant := l; act := l;
  while (act <> nil) and (act^.dato.ver < d.ver) do begin
    ant := act;
    act := act^.sig;
  end;
  if (ant = act) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln('Version: ', l^.dato.ver:0:2);
    l := l^.sig;
  end;
end;

procedure imprimirIncisosABC(l: lista);
var
  act, totalPant: real;
  cantVer, totalDisp, total: integer;
begin
  total := 0; totalDisp := 0; totalPant := 0;
  while (l <> nil) do begin
    cantVer := 0; act := l^.dato.ver;
    while (l <> nil) and (act = l^.dato.ver) do begin
      cantVer := cantVer + 1; totalDisp := totalDisp + 1; totalPant := totalPant + l^.dato.tam;
      if (l^.dato.ram > 3) and (l^.dato.tam <= 5) then
        total := total + 1;
      l := l^.sig;
    end;
    writeln('La cantidad de dispositivos de la version ', act:0:2 ,' es: ', cantVer);
  end;
  writeln();
  if (totalDisp <> 0) then begin
    writeln('El total de dispositivos con mas de 3GB de RAM y una pantalla de a lo sumo 5 pulgadas es: ', total);
    writeln('El promedio de pantalla de los dispositivos es: ', (totalPant / totalDisp):0:2);
  end;
end;

var
  l: lista;
  d: dispositivo;
begin
  l := nil;
  leerDispositivo(d);
  while (d.ver <> -1) do begin
    cargarLista(l, d);
    leerDispositivo(d);
  end;
  writeln();
  // imprimirLista(l);
  imprimirIncisosABC(l);
end.