unit Biblioteca;

interface

uses Winapi.Windows, System.SysUtils;

procedure EliminarProcessos;

implementation

procedure EliminarProcessos;
var
  PID_adm: UInt32;
  PID_adm_int: Integer;
  processo_eliminar: THandle;
begin
  try
    PID_adm := GetCurrentProcessId;
    PID_adm_int := StrToInt(UIntToStr(PID_adm));
    processo_eliminar := OpenProcess(PROCESS_TERMINATE, False, PID_adm_int);
    TerminateProcess(processo_eliminar, 0);
  except
    //Não faz nada
  end;
end;

end.
