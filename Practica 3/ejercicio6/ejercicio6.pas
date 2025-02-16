{
  Una empresa importadora de microprocesadores desea implementar un sistema de software para analizar la
  información de los productos que mantiene actualmente en stock. Para ello, se conoce la siguiente información de
  los microprocesadores: marca (Intel, AMD, NVidia, etc), línea (Xeon, Core i7, Opteron, Atom, Centrino, etc.),
  cantidad de cores o núcleos de procesamiento (1, 2, 4, 8), velocidad del reloj (medida en Ghz) y tamaño en
  nanómetros (nm) de los transistores (14, 22, 32, 45, etc.). La información de los microprocesadores se lee de
  forma consecutiva por marca de procesador y la lectura finaliza al ingresar un procesador con 0 cores (que no
  debe procesarse). Se pide implementar un programa que lea información de los microprocesadores de la empresa
  importadora e informe:
  ● Marca y línea de todos los procesadores de más de 2 cores con transistores de a lo sumo 22 nm.
  ● Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm.
  ● Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de
    al menos 2 Ghz.
}
program ejercicio6;
type
  cpu = record
    marca, linea: string;
    cores: integer;
    ghz: real;
    tamanoTransi: integer;
  end;

procedure leerProcesador(var mp: cpu);
begin
  write('Ingrese cores: ');readln(mp.cores);
  if (mp.cores <> 0) then begin
    write('Ingrese marca: ');readln(mp.marca);
    write('Ingrese linea: ');readln(mp.linea);
    write('Ingrese ghz: ');readln(mp.ghz);
    write('Ingrese tamano de los transitores: ');readln(mp.tamanoTransi);
    writeln();
  end;
end;

procedure calcularMarcaMaxMPS14nm(marcaAct: string; cantMPS14nm: integer;var marcaMax1, marcaMax2: string;var mps14nmMax1, mps14nmMax2: integer);
begin
  if (cantMPS14nm > mps14nmMax1) then begin
    mps14nmMax2 := mps14nmMax1;
    marcaMax2 := marcaMax1;
    marcaMax1 := marcaAct;
    mps14nmMax1 := cantMPS14nm;
  end
  else begin
    if (cantMPS14nm > mps14nmMax2) then begin
      marcaMax2 := marcaAct;
      mps14nmMax2 := cantMPS14nm;
    end;
  end;
end;

var
  mp: cpu;
  marcaAct, marcaMax1, marcaMax2: string;
  cantMPS14nm, mps14nmMax1, mps14nmMax2, mpsMultiCoreIntelAmdSup2ghz: integer;
begin
  mps14nmMax1 := -1; mps14nmMax2 := -1; mpsMultiCoreIntelAmdSup2ghz := 0;
  leerProcesador(mp); 
  while (mp.cores <> 0) do begin
    marcaAct := mp.marca; cantMPS14nm := 0;
    while (mp.cores <> 0) and (marcaAct = mp.marca) do begin
      if (mp.tamanoTransi = 14) then
        cantMPS14nm := cantMPS14nm + 1;
      if (mp.cores > 2) and (mp.tamanoTransi <= 22) then
        writeln(mp.marca ,' ', mp.linea , ' tiene mas de 2 cores con transistores de a lo sumo 22 nm');
      if (mp.cores > 1) and ((mp.marca = 'Intel') or (mp.marca = 'AMD')) and (mp.ghz >= 2) then
        mpsMultiCoreIntelAmdSup2ghz := mpsMultiCoreIntelAmdSup2ghz + 1;
      leerProcesador(mp);
    end;
    calcularMarcaMaxMPS14nm(marcaAct, cantMPS14nm, marcaMax1, marcaMax2, mps14nmMax1, mps14nmMax2);
  end;
  if (marcaMax1 <> '') then
    writeln('Las dos marcas con mas procesadores con transitores de 14 nm son: ', marcaMax1 ,' y ', marcaMax2);
  writeln('Cantidad de procesadores multicore de Intel o AMD con al menos 2 Ghz de velocidad: ', mpsMultiCoreIntelAmdSup2ghz);
end.