---------------------------------------------------------------------------------------------------
---> __FUNCTIONS__.lua <---
---------------------------------------------------------------------------------------------------





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





---------------------------------------------------------------------------------------------------
---> Funciones avanzadas <---
---------------------------------------------------------------------------------------------------

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
    return Output > 0 and Output

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
--- @param value string # Valor a buscar
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
--- @param key string # propiedad a buscar
--- @param value string # Valor a buscar
--- @return any #
---- Array con las tablas que contienen el key y value dado
---- o nil si no lo encuentra
function GPrefix.get_tables(array, key, value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Valores a devolver
    local Result = {}

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Hacer la busqueda
    local function get_table(e)
        for _, element in pairs(e) do
            if GPrefix.is_table(element) then
                if element[key] == value then
                    table.insert(Result, element)
                else
                    get_table(element)
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar la respuesta
    get_table(array)
    return #Result > 0 and Result

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Obtiener información del nombre de la carpeta
--- that_mod.id
--- that_mod.name
--- that_mod.prefix
function GPrefix.split_name_folder(that_mod)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- nivel 2 si llamas desde otra función
    local info = debug.getinfo(2, "S")
    local source = info.source

    --- Elimina el prefijo @ si viene de un archivo
    local path = source:sub(1, 1) == "@" and source:sub(2) or source

    --- Objetener el nombre del directorio
    local mod_name = path:match("__([^/]+)__")
    if not mod_name then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Dividir el nombre por guiones
    local id, name = mod_name:match(GPrefix.name_pattern .. "(.+)")

    --- Información propia del mod
    that_mod.id = id
    that_mod.name = name
    that_mod.prefix = GPrefix.name .. "-" .. id .. "-"

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
    local number, prefix, unit = split_string()

    --- Validar si la cadena es un numero valido
    if not number then return nil, nil end
    if not is_valid_number(number) then return nil, nil end

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
    return tonumber(number) * (10 ^ Units[prefix]), unit
end

--- Muestra información detallada de las variables dadas
--- @param ... any
function GPrefix.var_dump(...)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Renombrar los parametros dados
    local Args = { ... }
    if #Args == 0 then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Convierte una variable a string legible
    --- @param value any
    --- @param indent string|nil
    --- @param seen table<table, string>  -- Guarda referencias ya vistas y sus rutas
    --- @param path string
    local function to_string(value, indent, seen, path)
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Variables a usar
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        indent = indent or ""
        seen = seen or {}
        path = path or "<root>"

        local Type = type(value)

        --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Timpo de valor simple
        --- --- --- --- --- --- --- --- --- --- --- --- ---

        if Type == "string" then
            if string.find(value, "\n") then
                value = value:match("^%s*(.-)%s*$")
                value = value:gsub("\t", "")
                value = value:gsub("  ", " ")
                value = "[[\n\t" .. value .. "\n]]"
                for i = 1, GPrefix.get_length(seen), 1 do
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

        --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Tablas
        --- --- --- --- --- --- --- --- --- --- --- --- ---

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

        --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Permite reutilizar la tabla en otras ramas sin error
        seen[value] = nil

        --- Tabla vicia
        if not Has_items then
            return "{ }"
        end

        return "{" .. table.concat(Items, ",") .. "\n" .. indent .. "}"

        --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Contendor del texto de salida
    local Output = {}

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    -- Recorrer los valores dados
    for i, v in ipairs(Args) do
        local Name = (type(v) == "table" and type(v.name) == "string") and "'" .. v.name .. "'" or "" .. i
        local Result = "[" .. Name .. "] = " .. to_string(v, "", {}, Name)
        table.insert(Output, Result)
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    log("\n>>>\n" .. table.concat(Output, "\n") .. "\n<<<")

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------
