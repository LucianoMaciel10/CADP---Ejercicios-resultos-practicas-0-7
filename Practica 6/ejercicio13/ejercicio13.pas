{
  El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte de
  los usuarios. Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal. De cada
  usuario se conoce su email, su rol (1: Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que participa y cantidad de días desde el último acceso.
  a. Imprimir el email y la cantidad de días desde el último acceso de todos los usuarios de la
  revista Económica. El listado debe ordenarse a partir de la cantidad de días desde el último acceso (orden
  ascendente).
  b. Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
  c. Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.
}
program ejercicio13;
const
  maxUsuarios = 5; { 3600 }

type
  tipoRol = 1..4;
  usuario = record
    ultAcc: integer;
    email, rev: string;
    rol: tipoRol;
  end;
  vUsuarios = array[1..maxUsuarios] of usuario;
  cantRoles = array[tipoRol] of integer;
  lista = ^nodo;
  nodo = record
    dato: usuario;
    sig: lista;
  end;

procedure cargarUsuarios(var v: vUsuarios);

  procedure leerUsuario(var u: usuario);
  begin
    write('Ingrese email: ');readln(u.email);
    write('Ingrese rol(1-4): ');readln(u.rol);
    write('Ingrese revista: ');readln(u.rev);
    write('Ingrese cantidad de dias del ultimo ingreso: ');readln(u.ultAcc);
    writeln();
  end;

var
  i: integer;
  u: usuario;
begin
  for i := 1 to maxUsuarios do begin
    leerUsuario(u);
    v[i] := u;
  end;
end;

procedure informarIncisoA(v: vUsuarios);
var
  i: integer;
  l, nue, act, ant: lista;
begin
  l := nil;
  for i := 1 to maxUsuarios do begin
    if (v[i].rev = 'Economia') or (v[i].rev = 'economia') then begin
      new(nue); nue^.dato := v[i]; nue^.sig := nil;
      act := l; ant := l;
      while (act <> nil) and (act^.dato.ultAcc < v[i].ultAcc) do begin
        ant := act;
        act := act^.sig;
      end;
      if (act = ant) then
        l := nue
      else
        ant^.sig := nue;
      nue^.sig := act;
    end;
  end;
  if (l <> nil) then begin
    writeln('Usuarios de la revista "Economia"');
    while (l <> nil) do begin
      writeln('Email: ', l^.dato.email ,' | Cantidad de dias desde el ultimo acceso: ', l^.dato.ultAcc);
      l := l^.sig;
    end;
    writeln();
  end;
end;

procedure informarIncisoB(v: vUsuarios);

  procedure inicializarVector(var v: cantRoles);
  var
    i: integer;
  begin
    for i := 1 to 4 do 
      v[i] := 0;
  end;

var
  i: integer;
  vCantRoles: cantRoles;
begin
  inicializarVector(vCantRoles);
  for i := 1 to maxUsuarios do
    vCantRoles[v[i].rol] := vCantRoles[v[i].rol] + 1;
  writeln('Cantidad de usuarios para cada rol');
  for i := 1 to 4 do
    writeln('Rol ', i ,': ', vCantRoles[i]);
  writeln();
end;

procedure informarIncisoC(v: vUsuarios);

  procedure calcularMaximos(u: usuario; var max1, max2: integer;var maxEmail1, maxEmail2: string);
  begin
    if (u.ultAcc > max1) then begin
      max2 := max1;
      maxEmail2 := maxEmail1;
      max1 := u.ultAcc;
      maxEmail1 := u.email;
    end
    else begin
      if (u.ultAcc > max2) then begin
        max2 := u.ultAcc;
        maxEmail2 := u.email;
      end
    end;
  end;

var
  maxEmail1, maxEmail2: string;
  i, max1, max2: integer;
begin
  max1 := -1; max2 := -1;
  for i := 1 to maxUsuarios do
    calcularMaximos(v[i], max1, max2, maxEmail1, maxEmail2);
  writeln('Los usuarios que no entran al portal hace mas dias son: ', maxEmail1 ,' y ', maxEmail2);
end;

var
  v: vUsuarios;
begin
  cargarUsuarios(v);
  informarIncisoA(v);
  informarIncisoB(v);
  informarIncisoC(v);
end.