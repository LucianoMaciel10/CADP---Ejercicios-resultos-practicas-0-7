{
  La empresa distribuidora de una app móvil para corredores ha organizado una competencia mundial, en
  la que corredores de todos los países participantes salen a correr en el mismo momento en distintos puntos
  del planeta. La app registra, para cada corredor, el nombre y apellido, la distancia recorrida (en kilómetros), el
  tiempo (en minutos) durante el que corrió, el país y la ciudad desde donde partió, y la ciudad donde finalizó
  su recorrido. Realizar un programa que permita leer y almacenar toda la información registrada durante la
  competencia. La lectura finaliza al ingresar la distancia -1. Una vez que se han almacenado todos los datos,
  informar:
  o La cantidad total de corredores, la distancia total recorrida y el tiempo total de carrera de todos
    los corredores.
  o El nombre de la ciudad que convocó la mayor cantidad de corredores y la cantidad total de
    kilómetros recorridos por los corredores de esa ciudad.
  o La distancia promedio recorrida por corredores de Brasil.
  o La cantidad de corredores que partieron de una ciudad y finalizaron en otra ciudad.
  o El paso (cantidad de minutos por km) promedio de los corredores de la ciudad de Boston.
}
program ejercicio16;
type
  corredor = record
    nom, ape, pais, ciudadInicio, ciudadFin: string;
    dist, tiempo: integer;
  end;
  lista = ^nodo;
  nodo = record
    dato: corredor;
    sig: lista;
  end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln('Cuidad en la que empezo: ', l^.dato.ciudadInicio);
    l := l^.sig;
  end;
end;

procedure cargarLista(var l: lista);

  procedure leerCorredor(var c: corredor);
  begin
    write('Ingrese distancia recorrida: ');readln(c.dist);
    if (c.dist <> -1) then begin
      write('Ingrese nombre: ');readln(c.nom);
      write('Ingrese apellido: ');readln(c.ape);
      write('Ingrese pais: ');readln(c.pais);
      write('Ingrese tiempo corrido: ');readln(c.tiempo);
      write('Ingrese cuidad en la que empezo: ');readln(c.ciudadInicio);
      write('Ingrese cuidad en la que finalizo: ');readln(c.ciudadFin);
      writeln();
    end;
  end;

  procedure insertarOrdenado(var l: lista; c: corredor);
  var
    nue, ant, act: lista;
  begin
    new(nue); nue^.dato := c;
    ant := l; act := l;
    while (act <> nil) and (act^.dato.ciudadInicio <> c.ciudadInicio) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else 
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  c: corredor;
begin
  leerCorredor(c);
  while (c.dist <> -1) do begin
    insertarOrdenado(l, c);
    leerCorredor(c);
  end;
  writeln();
end;

procedure recorrerLista(l: lista);

  procedure calcularMaxCuidad(cantPorCuidad: integer; ciudad: string; var max: integer; var maxCiudad: string; kmPorCuidad: integer; var maxKmPorCuidad: integer);
  begin
    if (cantPorCuidad > max) then begin
      max := cantPorCuidad;
      maxCiudad := ciudad;
      maxKmPorCuidad := kmPorCuidad;
    end;
  end;

var
  cantCorredoresDistintasCuidades, cantBrasileros, totalCorredores, distTotal, tiempoTotal, max, cantPorCuidad, kmPorCuidad, maxKmPorCuidad, kmPorBrasileros, pasosCorredoresBoston, corredoresBoston: integer;
  maxCiudad, cuidadAct: string;
begin 
  totalCorredores := 0; distTotal := 0; tiempoTotal := 0; max := -1; cantBrasileros := 0; cantCorredoresDistintasCuidades := 0;
  pasosCorredoresBoston := 0; corredoresBoston := 0;
  while (l <> nil) do begin
    cuidadAct := l^.dato.ciudadInicio; cantPorCuidad := 0; kmPorCuidad := 0;
    while (l <> nil) and (l^.dato.ciudadInicio = cuidadAct) do begin
      cantPorCuidad := cantPorCuidad + 1;
      kmPorCuidad := kmPorCuidad + l^.dato.dist;
      tiempoTotal := tiempoTotal + l^.dato.tiempo;
      if (cuidadAct = 'Boston') then begin
        pasosCorredoresBoston := pasosCorredoresBoston + (l^.dato.dist * l^.dato.tiempo);
        corredoresBoston := corredoresBoston + 1;
      end;
      distTotal := distTotal + l^.dato.dist;
      if (l^.dato.ciudadInicio <> l^.dato.ciudadFin) then
        cantCorredoresDistintasCuidades := cantCorredoresDistintasCuidades + 1;
      totalCorredores := totalCorredores + 1;
      if (l^.dato.pais = 'brasil') or (l^.dato.pais = 'Brasil') then begin
        cantBrasileros := cantBrasileros + 1;
        kmPorBrasileros := kmPorBrasileros + l^.dato.dist;
      end;
      l := l^.sig;
    end;
    calcularMaxCuidad(cantPorCuidad, cuidadAct, max, maxCiudad, kmPorCuidad, maxKmPorCuidad);
  end;
  writeln('El total de corredores que participaron fueron: ', totalCorredores);
  writeln('La distancia total que recorrieron todos los corredores es: ', distTotal);
  writeln('El tiempo total corrido por todos los corredores es: ', tiempoTotal);
  writeln('La cuidad que convoca mas cantidad de corredores es: ', maxCiudad);
  writeln('La cantidad de kilometros recorridos por los corredores de la cuidad ', maxCiudad ,' es: ', maxKmPorCuidad);
  if (cantBrasileros > 0) then 
    writeln('El promedio de kilometros recorridos por corredores brasileros es: ', (kmPorBrasileros / cantBrasileros):0:2);
  writeln('La cantidad de corredores que iniciaron en una cuidad y finalizaron en otra es: ', cantCorredoresDistintasCuidades);
  if (corredoresBoston > 0) then
    writeln('El promedio de pasos hechos por corredores de Boston es: ', (pasosCorredoresBoston / corredoresBoston):0:2); 
end;

var
  l: lista;
begin
  l := nil;
  cargarLista(l);
  recorrerLista(l);
end.