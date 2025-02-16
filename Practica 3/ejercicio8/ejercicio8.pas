{
  La Comisión Provincial por la Memoria desea analizar la información de los proyectos presentados en el programa
  Jóvenes y Memoria durante la convocatoria 2020. Cada proyecto posee un código único, un título, el docente
  coordinador (DNI, nombre y apellido, email), la cantidad de alumnos que participan del proyecto, el nombre de la
  escuela y la localidad a la que pertenecen. Cada escuela puede presentar más de un proyecto. La información se
  ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela. Realizar un programa que
  lea la información de los proyectos hasta que se ingrese el proyecto con código -1 (que no debe procesarse), e
  informe:
  ● Cantidad total de escuelas que participan en la convocatoria 2020 y cantidad de escuelas por cada localidad.
  ● Nombres de las dos escuelas con mayor cantidad de alumnos participantes.
  ● Título de los proyectos de la localidad de Daireaux cuyo código posee igual cantidad de dígitos pares e impares.
}
program ejercicio8;
type
  docente = record
    dni: longint;
    nom, ape, email: string;
  end;
  proyecto = record
    doce: docente;
    cod, cantAlum: integer;
    titulo, nomEscu, local: string;
  end;

procedure leerDocente(var dni: longint;var ape, email, nom: string);
begin
  write('Ingrese nombre de docente a cargo: ');readln(nom);
  write('Ingrese apellido de docente a cargo: ');readln(ape);
  write('Ingrese email de docente a cargo: ');readln(email);
  write('Ingrese dni de docente a cargo: ');readln(dni);
end;

procedure leerProyecto(var p: proyecto);
begin
  write('Ingrese codigo: ');readln(p.cod);
  if (p.cod <> -1) then begin
    write('Ingrese nombre de la escuela: ');readln(p.nomEscu);
    write('Ingrese titulo: ');readln(p.titulo);
    write('Ingrese localidad: ');readln(p.local);
    write('Ingrese cantidad de alumnos: ');readln(p.cantAlum);
    leerDocente(p.doce.dni, p.doce.ape, p.doce.email, p.doce.nom);
    writeln();
  end;
end;

procedure escuelasMaxAlums(cantAluEscu: integer; escuAct: string;var maxAlum1, maxAlum2: integer;var maxEscu1, maxEscu2: string);
begin
  if (cantAluEscu > maxAlum1) then begin
    maxAlum2 := maxAlum1;
    maxEscu2 := maxEscu1;
    maxAlum1 := cantAluEscu;
    maxEscu1 := escuAct;
  end
  else if (cantAluEscu > maxAlum2) then begin
    maxAlum2 := cantAluEscu;
    maxEscu2 := escuAct;
  end;
end;

function esLocalDaireauxCodParImpar(localidad: string; codigo: integer): boolean;
var
  dig, par, impar: integer;
begin
  if (localidad <> 'Daireaux') then
    esLocalDaireauxCodParImpar := false
  else begin
    par := 0; impar := 0;
    while (codigo <> 0) do begin
      dig := codigo MOD 10;
      if (dig MOD 2 = 0) then
        par := par + 1
      else
        impar := impar + 1;
      codigo := codigo DIV 10;
    end;
    esLocalDaireauxCodParImpar := (impar = par);
  end;
end;

var
  p: proyecto;
  localAct, escuAct, maxEscu1, maxEscu2: string;
  totalEscuelas, cantEscuPorLocal, cantAluEscu, maxAlum1, maxAlum2: integer;
begin
  totalEscuelas := 0; maxAlum1 := -1; maxAlum2 := -1;
  leerProyecto(p);
  while (p.cod <> -1) do begin
    localAct := p.local; cantEscuPorLocal := 0;
    while (p.cod <> -1) and (localAct = p.local) do begin
      escuAct := p.nomEscu; cantAluEscu := 0;
      totalEscuelas := totalEscuelas + 1;
      cantEscuPorLocal := cantEscuPorLocal + 1;
      while (p.cod <> -1) and (localAct = p.local) and (escuAct = p.nomEscu) do begin
        cantAluEscu := cantAluEscu + p.cantAlum;
        if (esLocalDaireauxCodParImpar(p.local, p.cod)) then
          writeln(p.titulo,' es de la localidad de Daireaux y su codigo posee igual cantidad de digitos pares e impares');
        leerProyecto(p);
      end;
      escuelasMaxAlums(cantAluEscu, escuAct, maxAlum1, maxAlum2, maxEscu1, maxEscu2);
    end;
    writeln('La cantidad de escuelas de la localidad ', localAct, ' es: ', cantEscuPorLocal);
  end;
  writeln('Total de escuelas que participaron: ', totalEscuelas);
  writeln('Las dos escuelas con mas alumnos participando son: ', maxEscu1,' y ', maxEscu2);
end.