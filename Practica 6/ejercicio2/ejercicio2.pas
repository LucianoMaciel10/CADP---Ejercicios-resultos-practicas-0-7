{
  Dado el siguiente código que lee información de personas hasta que se ingresa la persona con dni 0 y luego
  imprime dicha información en el orden inverso al que fue leída, identificar los 9 errores.
}
program ejercicio2;
type
  lista = ^nodo;
  persona = record
    dni: integer;
    nombre: string;
    apellido: string;
  end;
  nodo = record
    dato: persona;
    sig: lista;
  end;

procedure leerPersona(p: persona); { 4. la persona no esta siendo pasada por referencia}
begin
  read(p.dni);
  if (p.dni <> 0)then begin
    read(p.nombre);
    read(p.apellido);
  end;
end;

{Agrega un nodo a la lista}
procedure agregarAdelante(l:lista; p:persona); { 5. la lista no esta siendo pasada por referencia }
var
  aux: lista;
begin
  { 6. falta reservar memoria para el nuevo puntero (new(aux))}
  aux^.dato:= p;
  aux^.sig:= l;
  l:= aux;
end;

{Carga la lista hasta que llega el dni 0}
procedure generarLista(var l:lista);
var
  p:nodo; { 2. no debe ser de tipo nodo, debe ser de tipo persona}
begin
  leerPersona(p);
  while (p.dni <> 0) do begin
    agregarAdelante(l,p);
    { 3. falta seguir leyendo personas en el bucle }
  end;
end;

procedure imprimirInformacion(var l:lista); { 7. la lista no debe ser pasada por referencia }
begin
  while (l <> nil) do begin
    writeln('DNI: ', l^.dato.dni, 'Nombre:', l^.nombre, 'Apellido:', l^.apellido); { 8. se ingresa mal al dato nombre y al dato apellido }
    l:= l^.sig;
  end;
end;

{Programa principal}
var
  l:lista;
begin
  { 1. la lista no fue inicializada con nil }
  generarLista(l);
  imprimirInformacion(l);
  { 9. no se libera la memoria de la lista }
end.