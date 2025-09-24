<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> __FUNCTIONS__.lua <---
---------------------------------------------------------------------------------------------------
=======
---------------------------------------------------------------------------
---[ __FUNCTIONS__.lua ]---
---------------------------------------------------------------------------
>>>>>>> nuevo/main





<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> Funciones basicas <---
---------------------------------------------------------------------------------------------------

function GPrefix.is_nil(value) return type(value) == "nil" end

function GPrefix.is_table(value) return type(value) == "table" end

function GPrefix.is_string(value) return type(value) == "string" end

function GPrefix.is_number(value) return type(value) == "number" end

function GPrefix.is_boolean(value) return type(value) == "boolean" end

function GPrefix.is_function(value) return type(value) == "function" end

function GPrefix.is_userdata(value) return type(value) == "userdata" end

---------------------------------------------------------------------------------------------------
=======
---------------------------------------------------------------------------
---[ Valiación ]---
---------------------------------------------------------------------------

--- Validar si se cargó antes
if GMOD.copy then return end

---------------------------------------------------------------------------
>>>>>>> nuevo/main





<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> Funciones avanzadas <---
---------------------------------------------------------------------------------------------------

--- Deep copy simple (cada tabla se copia siempre, sin compartir referencias)
--- @param orig any
--- @return any
function GPrefix.copy(orig)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación
    if type(orig) ~= "table" then
        return orig
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Variable de salida
    local Copy = {}

    --- Copiar la información
    for k, v in pairs(orig) do
        local New_key = (type(k) == "table") and GPrefix.copy(k) or k
        local New_val = (type(v) == "table") and GPrefix.copy(v) or v
        Copy[New_key] = New_val
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Devolver la copia
    return Copy

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Contar los elementos en la tabla
---- __ADVERTENCIA:__ El conteo NO es recursivo
--- @param array table # Tabla en la cual buscar
--- @return any #
---- Conteo de los elementos de la tabla
---- o nil si se poduce un error o la tabla esta vacia
function GPrefix.get_length(array)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación
    if not GPrefix.is_table(array) then
        return
    end

    --- Variable de salida
    local Output = 0

    --- Contar campos
    for _ in pairs(array) do
        Output = Output + 1
    end

    --- Devolver el resultado
    return Output > 0 and Output or nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Devuelve el key que le corresponde al valor dado
--- @param array table # Tabla en la cual buscar
--- @param value any # Valor a buscar
--- @return any #
---- __integer:__ Posición de la primera coincidencia con el valor
---- __nil:__ El valor dado no es valido
function GPrefix.get_key(array, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación
    if not GPrefix.is_table(array) then return end
    if GPrefix.is_nil(value) then return end

    --- Buscar el valor
    for Key, Value in pairs(array) do
        if value == Value then
            return Key
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Cuenta la cantidad de caracteres en el valor dado
--- @param value integer # __Ejemplo:__ _123_
--- @return any # __Ejemplo:__ _3_
function GPrefix.digit_count(value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if not GPrefix.is_number(value) then return end
    return string.len(tostring(value))

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Agrega ceros a la izquierda hasta completar los digitos
--- @param digits integer # __Ejemplo:__ _5_
--- @param value integer # __Ejemplo:__ _123_
--- @return string # __Ejemplo:__ _00123_
function GPrefix.pad_left_zeros(digits, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if not GPrefix.is_number(digits) then return "" end
    if not GPrefix.is_number(value) then return "" end
    return string.format("%0" .. digits .. "d", value)

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Devuelve el elemento cuyo key y value se igual al dado
--- @param array table # Tabla en la cual buscar
--- @param key string # propiedad a buscar
--- @param value any # Valor a buscar
--- @return any #
---- Array de la primera coincidencia con los valores dados
---- o nil si se poduce un error o no lo encuentra
function GPrefix.get_table(array, key, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación
    if not GPrefix.is_table(array) then return end
    if GPrefix.is_nil(key) then return end

    --- Buscar el valor
    for _, element in pairs(array) do
        if GPrefix.is_table(element) then
            if element[key] and element[key] == value then
                return element
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Busca de forma recursiva el key y value en la tabla dada
--- @param array table # Tabla en la cual buscar
--- @param key any # propiedad a buscar
--- @param value any # Valor a buscar
--- @return any #
---- Array con las tablas que contienen el key y value dado
---- o nil si no lo encuentra
function GPrefix.get_tables(array, key, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if not GPrefix.is_table(array) then return end
    if key == nil and value == nil then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
---------------------------------------------------------------------------
---[ Funciones globales ]---
---------------------------------------------------------------------------

--- Obtiener información del nombre de la carpeta
--- that_mod.id
--- that_mod.name
--- that_mod.prefix
function GMOD.get_id_and_name(value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if type(value) ~= "nil" then
        if type(value) ~= "string" then
            return
        end
    else
        --- Nivel 2 porque se llama desde otra función
        local Info = debug.getinfo(2, "S")
        local Source = Info.source

        --- Elimina el prefijo @ si viene de un archivo
        local Path = Source:sub(1, 1) == "@" and Source:sub(2) or Source

        --- Objetener el nombre del directorio
        value = Path:match("__([^/]+)__")
        if not value then return end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Separa de la cadena dada los IDs y el resto del nombre
    --- @param full_name string
    --- @return table|nil # IDs encontrados como lista
    --- @return string|nil # Nombre sin los IDs ni el prefijo
    local function get_id_and_name(full_name)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Contenedor del nombre en partes
        local Parts = {}

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        -- Dividir en partes separadas por guiones
        for segment in string.gmatch(full_name, "[^%-]+") do
            if segment ~= GMOD.name then
                table.insert(Parts, segment)
            end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        -- Extraer los IDs válidos
        local IDs, Rest_parts = {}, {}
        for _, Part in ipairs(Parts) do
            if Part:match("^i%dMOD%d%d$") then
                table.insert(IDs, Part)
            else
                table.insert(Rest_parts, Part)
            end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- No hay IDs
        if #IDs == 0 then return end

        --- El MOD no tiene nombre
        local Rest = nil
        if #Rest_parts > 0 then Rest = table.concat(Rest_parts, "-") end
        if not Rest then return end
        if Rest == "" then return end

        --- Devolver IDs y resto del nombre
        return IDs, Rest

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Dividir el nombre por guiones
    local IDs, Name = get_id_and_name(value)

    --- No es un mod valido
    if not IDs then return end

    --- Información propia del mod
    local Output = {}
    Output.id = IDs[#IDs]
    Output.ids = "-" .. table.concat(IDs, "-") .. "-"
    Output.name = Name
    Output.prefix = GMOD.name .. "-" .. Output.id .. "-"
    return Output

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------

--- Devuelve el elemento cuyo key y value se igual al dado
--- @param array table # Tabla en la cual buscar
--- @param key string|nil # propiedad a buscar
--- @param value any|nil # Valor a buscar
--- @return any #
---- Array con las tablas que contienen el key y value dado
---- o nil si no lo encuentra
function GMOD.get_tables(array, key, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if type(array) ~= "table" then return end
    if key == nil and value == nil then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Coincidencias encontradas
    local Results = {}
    local Added_results = {}

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Buscar las coincidencia
    local function recursive_search(tbl)
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Buscar las coincidencia
    local function Search(tbl)
>>>>>>> nuevo/main
        local Found = false

        -- Caso: key y value
        if key ~= nil and value ~= nil then
            if tbl[key] == value then
                Found = true
            end
        end

        -- Caso: solo key
        if key ~= nil and value == nil then
            if tbl[key] ~= nil then
                Found = true
            end
        end

        -- Caso: solo value
        if key == nil and value ~= nil then
            for _, v in pairs(tbl) do
                if v == value then
                    Found = true
                    break
                end
            end
        end

        --- Agregar la tabla
        if Found then
            if Added_results[tbl] == nil then
                table.insert(Results, tbl)
            end
        end

        --- Buscar en las subtablas
        for _, v in pairs(tbl) do
<<<<<<< HEAD
            if GPrefix.is_table(v) then
                recursive_search(v)
=======
            if type(v) == "table" then
                Search(v)
>>>>>>> nuevo/main
            end
        end
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Iniciar la busqueda
    recursive_search(array)

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Iniciar la busqueda
    Search(array)

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Devolver el resultado
    return #Results > 0 and Results or nil

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Obtiener información del nombre de la carpeta
--- that_mod.id
--- that_mod.name
--- that_mod.prefix
function GPrefix.split_name_folder(that_mod)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- nivel 2 si llamas desde otra función
    local Info = debug.getinfo(2, "S")
    local Source = Info.source

    --- Elimina el prefijo @ si viene de un archivo
    local Path = Source:sub(1, 1) == "@" and Source:sub(2) or Source

    --- Objetener el nombre del directorio
    local Mod_name = Path:match("__([^/]+)__")
    if not Mod_name then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Dividir el nombre por guiones
    local IDs, Name = GPrefix.get_id_and_name(Mod_name)

    --- Información propia del mod
    that_mod.id = IDs and IDs[1] or nil
    that_mod.name = Name
    that_mod.prefix = GPrefix.name .. "-" .. IDs .. "-"

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Separa de la cadena dada los IDs y el resto del nombre
--- @param full_name string
--- @return table|nil # IDs encontrados como lista
--- @return string|nil # Nombre sin los IDs ni el prefijo
function GPrefix.get_id_and_name(full_name)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    -- Dividir en partes separadas por guiones
    local Parts = {}
    for segment in string.gmatch(full_name, "[^%-]+") do
        if segment ~= GPrefix.name then
            table.insert(Parts, segment)
        end
    end

    -- Extraer los IDs válidos
    local IDs, Rest_Parts = {}, {}
    for _, Part in ipairs(Parts) do
        if Part:match("^[a-z]%d[A-Z]%d[a-z]$") then
            table.insert(IDs, Part)
        else
            table.insert(Rest_Parts, Part)
        end
    end

    -- No hay IDs → no se puede separar
    if #IDs == 0 then return nil, nil end

    -- Devolver IDs y resto del nombre directamente
    return IDs, #Rest_Parts > 0 and table.concat(Rest_Parts, "-") or nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Elimina el indicador del nombre dado
--- @param name string # __Ejemplo:__ prefix-0000-0200-name
--- @return string # __Ejemplo:__ #
---- __name,__ si se cumple el patron
---- o el nombre dado si no es así
function GPrefix.delete_prefix(name)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    return name:gsub(GPrefix.name .. "%-", "") or name

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Valida si el nombre contiene el id indicado
--- @param name string
--- @param id string
--- @return boolean
function GPrefix.has_id(name, id)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    return name:find("%-" .. id .. "%-") ~= nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Separa el número de la cadena teninedo encuenta
--- indicadores tipo k, M, G y unidades como J, W
--- @param string string # __Ejemplo:__ 0.3Mw
--- @return any, any #
---- __Ejemplo:__ 300000 W
function GPrefix.number_unit(string)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar si la cadena es un numero valido
    local function is_valid_number(str)
        return string.match(str, "^[-]?%d*%.?%d+$") ~= nil or
            string.match(str, "^[-]?%.%d+$") ~= nil
    end

    --- Separar la cadena en tres parte
    local function split_string()
        local Parts = {
            "([-]?[%d%.]+)",   -- Valor numerico
            "([kMGTPEZYRQ]?)", -- Unidades de valores posible
            "([JW]?)"          -- Unidades de energia posible
        }
        local Pattern = "^" .. table.concat(Parts) .. "$"
        return string.match(string, Pattern)
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Separar la cadena en tres parte
    local Number, Prefix, Unit = split_string()

    --- Validar si la cadena es un numero valido
    if not Number then return nil, nil end
    if not is_valid_number(Number) then return nil, nil end

    --- Inidesdes posibles
    local Units = {}
    Units[""] = 0
    Units["k"] = 3
    Units["M"] = 6
    Units["G"] = 9
    Units["T"] = 12
    Units["P"] = 15
    Units["E"] = 18
    Units["Z"] = 21
    Units["Y"] = 24
    Units["R"] = 27
    Units["Q"] = 30

    --- Devuelve el resultado
    return tonumber(Number) * (10 ^ Units[Prefix]), Unit
end

--- Acorta un número grande usando sufijos como K, M, G, etc.
--- @param number number # Número a abreviar
--- @return any Cadena # abreviada, por ejemplo: 300000 → "300K"
function GPrefix.short_number(number)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación básica
    if not GPrefix.is_number(number) then return nil end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inidesdes posibles
    local Units = {}
    Units[0] = ""
    Units[3] = "k"
    Units[6] = "M"
    Units[9] = "G"
    Units[12] = "T"
    Units[15] = "P"
    Units[18] = "E"
    Units[21] = "Z"
    Units[24] = "Y"
    Units[27] = "R"
    Units[30] = "Q"

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Dar le el formato deseado al valor
    local function format(text)
        local A, B = string.match(text, "^(%-?%d+)%.(%d)")
        if not (A and B) then return text end
        if B == "0" then return A end
        return A .. "." .. B
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Acortar el número
    local Digits = math.floor(#tostring(number) / 3)
    if #tostring(number) % 3 == 0 then Digits = Digits - 1 end
    local Output = tostring(number * (10 ^ (-3 * Digits)))
    return format(Output) .. Units[3 * Digits]

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Contar los elementos en la tabla
---- __ADVERTENCIA:__ El conteo NO es recursivo
--- @param array table # Tabla en la cual buscar
--- @return any #
---- Conteo de los elementos de la tabla
---- o nil si la tabla esta vacia
function GMOD.get_length(array)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación
    if type(array) ~= "table" then
        return
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Variable de salida
    local Output = 0

    --- Contar campos
    for _ in pairs(array) do
        Output = Output + 1
    end

    --- Devolver el resultado
    return Output > 0 and Output or nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Devuelve el key que le corresponde al valor dado
--- @param array table # Tabla en la cual buscar
--- @param value any # Valor a buscar
--- @return any #
---- __integer:__ Posición de la primera coincidencia con el valor
---- __nil:__ El valor dado no es valido
function GMOD.get_key(array, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación
    if type(array) ~= "table" then return end
    if type(value) == "nil" then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Buscar el valor
    for Key, Value in pairs(array) do
        if value == Value then
            return Key
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Cuenta la cantidad de caracteres en el valor dado
--- @param value integer # __Ejemplo:__ _123_
--- @return any # __Ejemplo:__ _3_
function GMOD.digit_count(value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if type(value) ~= "number" then return end
    return string.len(tostring(value))

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Agrega ceros a la izquierda hasta completar los digitos
--- @param digits integer # __Ejemplo:__ _5_
--- @param value integer # __Ejemplo:__ _123_
--- @return string # __Ejemplo:__ _00123_
function GMOD.pad_left_zeros(digits, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if type(digits) ~= "number" then return "" end
    if type(value) ~= "number" then return "" end
    return string.format("%0" .. digits .. "d", value)

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------

--- Copia cada tabla se copia siempre, sin compartir referencias
--- @param value any
--- @return any
function GMOD.copy(value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valdación
    if type(value) ~= "table" then
        return value
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Variable de salida
    local Copy = {}

    --- Copiar la información
    for k, v in pairs(value) do
        local New_key = (type(k) == "table") and GMOD.copy(k) or k
        local New_val = (type(v) == "table") and GMOD.copy(v) or v
        Copy[New_key] = New_val
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Devolver la copia
    return Copy

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main
end

--- Muestra información detallada de las variables dadas
--- @param ... any
<<<<<<< HEAD
function GPrefix.var_dump(...)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
function GMOD.var_dump(...)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Renombrar los parametros dados
    local Args = { ... }
    if #Args == 0 then return end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Convierte una variable a string legible
    --- @param value any
    --- @param indent string|nil
    --- @param seen table<table, string>  -- Guarda referencias ya vistas y sus rutas
    --- @param path string
    local function to_string(value, indent, seen, path)
<<<<<<< HEAD
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Variables a usar
        --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---[ Variables a usar
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

>>>>>>> nuevo/main
        indent = indent or ""
        seen = seen or {}
        path = path or "<root>"

        local Type = type(value)

<<<<<<< HEAD
        --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main





<<<<<<< HEAD
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Timpo de valor simple
        --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---[ Timpo de valor simple
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

        if Type == "string" then
            if string.find(value, "\n") then
                value = value:match("^%s*(.-)%s*$")
                value = value:gsub("\t", "")
                value = value:gsub("  ", " ")
                value = "[[\n\t" .. value .. "\n]]"
<<<<<<< HEAD
                for i = 1, GPrefix.get_length(seen), 1 do
=======
                for i = 1, GMOD.get_length(seen), 1 do
>>>>>>> nuevo/main
                    value = value:gsub("\n", "\n\t")
                end
                return value
            else
                return "'" .. string.gsub(value, "'", '"') .. "'"
            end
        end

        if Type == "number" or Type == "boolean" or Type == "nil" then
            return tostring(value)
        end

        if Type == "function" or Type == "thread" then
            return Type .. "( ) end"
        end

        if Type == "userdata" then
            return Type
        end

        if Type ~= "table" then
            return '"<unknown>"'
        end

<<<<<<< HEAD
        --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main





<<<<<<< HEAD
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Tablas
        --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---[ Tablas
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

        --- Evitar referencias circular
        if seen[value] then
            return '"<circular reference to ' .. seen[value] .. '>"'
        end

        --- Ruta hata este valor
        seen[value] = path

        --- Convertir los valores de la taba dada
        local Items = {}
        local Has_items = false
        for k, v in pairs(value) do
            Has_items = true
            local Key_str = "[" .. to_string(k, nil, seen, path .. "." .. tostring(k)) .. "]"
            local New_path = path .. "." .. tostring(k)
            local Val_str = to_string(v, indent .. "  ", seen, New_path)
            Val_str = "\n" .. indent .. "  " .. Key_str .. " = " .. Val_str
            table.insert(Items, Val_str)
        end

<<<<<<< HEAD
        --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

        --- Permite reutilizar la tabla en otras ramas sin error
        seen[value] = nil

        --- Tabla vicia
        if not Has_items then
            return "{ }"
        end

<<<<<<< HEAD
        return "{" .. table.concat(Items, ",") .. "\n" .. indent .. "}"

        --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
        --- Devolver el resultado
        return "{" .. table.concat(Items, ",") .. "\n" .. indent .. "}"

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Contendor del texto de salida
    local Output = {}

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    -- Recorrer los valores dados
=======
    --- Recorrer los valores dados
>>>>>>> nuevo/main
    for i, v in ipairs(Args) do
        local Name = (type(v) == "table" and type(v.name) == "string") and "'" .. v.name .. "'" or "" .. i
        local Result = "[" .. Name .. "] = " .. to_string(v, "", {}, Name)
        table.insert(Output, Result)
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    log("\n>>>\n" .. table.concat(Output, "\n") .. "\n<<<")

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------
=======
    ---[ Mostrar el resultado
    log("\n>>>\n" .. table.concat(Output, "\n") .. "\n<<<")

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------
>>>>>>> nuevo/main
