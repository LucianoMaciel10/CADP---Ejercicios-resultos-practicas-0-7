{
  Una compañía de venta de insumos agrícolas desea procesar la información de las empresas a las que
  les provee sus productos. De cada empresa se conoce su código, nombre, si es estatal o privada,
  nombre de la ciudad donde está radicada y los cultivos que realiza (a lo sumo 20). Para cada cultivo
  de la empresa se registra: tipo de cultivo (trigo, maíz, soja, girasol, etc.), cantidad de hectáreas
  dedicadas y la cantidad de meses que lleva el ciclo de cultivo.
  a.  Realizar un programa que lea la información de las empresas y sus cultivos. Dicha información
      se ingresa hasta que llegue una empresa con código -1 (la cual no debe procesarse). Para cada
      empresa se leen todos sus cultivos, hasta que se ingrese un cultivo con 0 hectáreas (que no
      debe procesarse).
  Una vez leída y almacenada la información, calcular e informar:
  b.  Nombres de las empresas radicadas en “San Miguel del Monte” que cultivan trigo y cuyo código
      de empresa posee al menos dos ceros.
  c.  La cantidad de hectáreas dedicadas al cultivo de soja y qué porcentaje representa con respecto al total de hectáreas.
  d.  La empresa que dedica más tiempo al cultivo de maíz
  e.  Realizar un módulo que incremente en un mes los tiempos de cultivos de girasol de menos de 5
      hectáreas de todas las empresas que no son estatales.
}
program ejercicio10;
const
  tipos: array[1..20] of string = (
    'maiz', 'trigo', 'girasol', 'soja', 'cebada', 
    'avena', 'centeno', 'sorgo', 'lenteja', 'garbanzos', 
    'arroz', 'mani', 'papa', 'batata', 'tomate', 
    'cania de azucar', 'algodon', 'zanahoria', 'remolacha', 'habas'
  );
  dimF = 20;
  sanMiguel = 'San Miguel del Monte';

type
  cultivo = record
    tipo: string;
    cantH, cantM: integer;
  end;
  vecCultivos = array[1..dimF] of cultivo;
  empresa = record
    nom, nomCiudad: string;
    esEstatal: boolean;
    cultivos: vecCultivos;
    cod, dimL: integer;
  end;
  lista = ^nodo;
  nodo = record
    dato: empresa;
    sig: lista;
  end;
  tipoTipos = array[1..20] of string; // esto no es necesario, solo se usa para automatizar pruebas

procedure cargarLista(var l: lista);

  procedure leerEmpresa(var e: empresa);

    procedure leerCultivo(var c: cultivo; dimL: integer);
    begin
      if (Random(6) = 0) and (dimL > 0) then
        c.cantH := 0 
      else
        c.cantH := Random(15) + 1; 
      if (c.cantH <> 0) then begin
        c.cantM := Random(10) + 1;
        c.tipo := tipos[Random(20) + 1];
      end;
    end;

    procedure cargarCultivos(var v: vecCultivos; var dimL: integer);
    var
      i: integer;
      c: cultivo;
      existe: boolean;
    begin
      dimL := 0;
      leerCultivo(c, dimL);
      while (dimL < dimF) and (c.cantH <> 0) do begin
        repeat
          existe := false;
          for i := 1 to dimL do 
            if (v[i].tipo = c.tipo) then begin
              existe := true;
              leerCultivo(c, dimL);
            end;
        until not existe;
        dimL := dimL + 1;
        v[dimL] := c;
        leerCultivo(c, dimL);
      end;
    end;

  var
    caracteres, strRandom: string;
    i: integer;
    esEstatal, num: integer;
  begin
    if (Random(6) = 0) and (e.dimL > 0) then
      e.cod := -1 
    else
      e.cod := Random(32000) + 1; 
    if (e.cod <> -1) then begin
      caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      strRandom := '';
      for i := 1 to 8 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
      num := Random(100) + 1;
      if (num > 70) then
        e.nomCiudad := sanMiguel
      else
        e.nomCiudad := strRandom;
      strRandom := '';
      for i := 1 to 8 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
      e.nom := strRandom;
      esEstatal := Random(2);
      e.esEstatal := (esEstatal = 0);
      cargarCultivos(e.cultivos, e.dimL);
    end;
  end;
  
  procedure agregarAdelante(var l: lista; e: empresa);
  var
    nue: lista;
  begin
    new(nue); nue^.dato := e;
    nue^.sig := l;
    l := nue;
  end;

var
  e: empresa;
begin
  leerEmpresa(e);
  while (e.cod <> -1) do begin
    agregarAdelante(l, e);
    leerEmpresa(e);
  end;
end;

procedure recorrerLista(l: lista);

  function cultivaTrigo(e: empresa): boolean;
  var
    i: integer;
    ok: boolean;
  begin
    ok := false;
    for i := 1 to e.dimL do
      if (e.cultivos[i].tipo = 'trigo') then begin
        ok := true;
        break;
      end;
    cultivaTrigo := ok;
  end;

  function descomponerCodigo(cod: integer): boolean;
  var
    ceros, dig: integer;
  begin
    ceros := 0;
    while (cod <> 0) do begin
      dig := cod MOD 10;
      if (dig = 0) then
        ceros := ceros + 1;
      cod := cod DIV 10;
    end;
    descomponerCodigo := (ceros >= 2);
  end;

  function calcularTotalH(e: empresa): integer;
  var
    i, total: integer;
  begin
    total := 0;
    for i := 1 to e.dimL do
      total := total + e.cultivos[i].cantH;
    calcularTotalH := total;
  end;

  function calcularHsoja(e: empresa): integer;
  var
    i, total: integer;
  begin
    total := 0;
    for i := 1 to e.dimL do
      if (e.cultivos[i].tipo = 'soja') then
        total := total + e.cultivos[i].cantH;
    calcularHsoja := total;
  end;

  procedure calcularMaxEmpresaMaiz(e: empresa; var max: integer; var nomMax: string);
  var
    i: integer;
  begin
    for i := 1 to e.dimL do 
      if (e.cultivos[i].tipo = 'maiz') then begin
        if (e.cultivos[i].cantM > max) then begin
          max := e.cultivos[i].cantM;
          nomMax := e.nom;
        end;
        break;
      end;
  end;

var
  cantHsoja, totalH, max: integer;
  nomMax: string;
begin
  cantHsoja := 0; totalH := 0; max := -1; nomMax := '';
  writeln('Empresas radicadas en San Miguel del Monte que cultivan trigo y cuyo codigo de empresa posee al menos dos ceros');
  while (l <> nil) do begin
    if (l^.dato.nomCiudad = 'San Miguel del Monte') and (cultivaTrigo(l^.dato)) and (descomponerCodigo(l^.dato.cod)) then
      writeln('Empresa: ', l^.dato.nom);
    totalH := totalH + calcularTotalH(l^.dato);
    cantHsoja := cantHsoja + calcularHsoja(l^.dato);
    calcularMaxEmpresaMaiz(l^.dato, max, nomMax);
    l := l^.sig;
  end;
  writeln();
  writeln('La cantidad de hectareas totales que son de soja es: ', cantHsoja);
  if (totalH > 0) then
    writeln('El ', ((cantHsoja / totalH) * 100):0:2 ,'% de hectareas son de soja');
  writeln('La empresa que gasta mas tiempo en cultivar maiz es: ', nomMax);
end;

procedure incrementarEmpresas(var l: lista);
var
  aux: lista;
  i: integer;
begin
  aux := l;
  while (aux <> nil) do begin
    if (not aux^.dato.esEstatal) then
      for i := 1 to aux^.dato.dimL do
        if (aux^.dato.cultivos[i].tipo = 'girasol') and (aux^.dato.cultivos[i].cantH < 5) then
          aux^.dato.cultivos[i].cantM := aux^.dato.cultivos[i].cantM + 1;
    aux := aux^.sig;
  end;
end;

procedure imprimirEmpresas(l: lista);
var
  i: integer;
begin
  writeln();
  while (l <> nil) do begin
    writeln('Nombre: ', l^.dato.nom,' | Codigo: ', l^.dato.cod,' | Es estatal?: ', l^.dato.esEstatal,' | Nombre de la cuidad: ', l^.dato.nomCiudad);
    writeln('Cultivos');
    for i := 1 to l^.dato.dimL do
      writeln('Tipo: ', l^.dato.cultivos[i].tipo ,' | Cantidad de hectareas: ', l^.dato.cultivos[i].cantH,' | Cantidad de meses de ciclo de cultivo: ', l^.dato.cultivos[i].cantM);
    writeln();
    l := l^.sig;
  end;
  writeln();
end;

var
  l: lista;
begin
  Randomize;
  l := nil;
  cargarLista(l);
  imprimirEmpresas(l);
  recorrerLista(l);
  incrementarEmpresas(l);
  imprimirEmpresas(l);
end.