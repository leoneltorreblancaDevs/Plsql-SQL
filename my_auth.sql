create or replace FUNCTION my_auth (p_username in VARCHAR2, p_password in VARCHAR2) return BOOLEAN is
l_password varchar2(4000);
l_stored_password varchar2(4000);
l_count number;
begin
   -- Primero, verificar que el usuario existe en la tabla
   select count(*) into l_count from nombretabla where usuario = p_username;  
   
   -- password generico de ser deseado
   /*if p_password in ('Leonel') then
      return true;
    end if;*/
   if l_count > 0 then
      -- Recuperar la contraseña hash almacenada
      select CLAVE into l_stored_password
      from nombretabla where usuario = p_username;
 
      -- Aplicar la función hash al password
      l_password := MY_HASH(p_username, p_password);
      -- Comparar y ver si son los mismos y retornar VERDADERO o FALSO
      if l_password = l_stored_password then
         return true;
      else
         return false;
      end if;
   else
      -- El nombre de usuario provisto no se encuentra en la tabla MY_USERS
      return false;
   end if;

end;
/