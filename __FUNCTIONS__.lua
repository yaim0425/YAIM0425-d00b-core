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
        return nil
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
    if not GPrefix.is_table(array) then return nil end
    if GPrefix.is_nil(value) then return nil end

    --- Buscar el valor
    for Key, Value in pairs(array) do
        if value == Value then
            return Key
        end
    end

    --- No se encontrado
    return nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Cuenta la cantidad de caracteres en el valor dado
--- @param value integer # __Ejemplo:__ _123_
--- @return any # __Ejemplo:__ _3_
function GPrefix.digit_count(value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if not GPrefix.is_number(value) then return nil end
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
    if not GPrefix.is_table(array) then return nil end
    if GPrefix.is_nil(key) then return nil end

    --- Buscar el valor
    for _, element in pairs(array) do
        if GPrefix.is_table(element) then
            if element[key] and element[key] == value then
                return element
            end
        end
    end

    --- No se encontrado
    return nil

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
        --- --- --- --- --- --- --- --- --- --- --- --- ---

        for _, element in pairs(e) do
            if GPrefix.is_table(element) then
                if element[key] == value then
                    table.insert(Result, element)
                else
                    get_table(element)
                end
            end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar la respuesta
    get_table(array)
    return #Result > 0 and Result or nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Muestra información detallada de las variables dadas
--- @param ... any
function GPrefix.var_dump(...)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Renombrar los parametros dados
    local args = { ... }
    if #args == 0 then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Contendor del texto de salida
    local Output = {}

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
                return "[[" .. value .. "]]"
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
            table.insert(Items, indent .. "  " .. Key_str .. " = " .. Val_str .. ",")
        end

        --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Permite reutilizar la tabla en otras ramas sin error
        seen[value] = nil

        --- Tabla vicia
        if not Has_items then
            return "{ }"
        end

        return "{\n" .. table.concat(Items, "\n") .. "\n" .. indent .. "}"

        --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    -- Recorrer los valores dados
    for i, v in ipairs(args) do
        local Name = (type(v) == "table" and type(v.name) == "string") and "'" .. v.name .. "'" or "" .. i
        local Result = "[" .. Name .. "] = " .. to_string(v, "", {}, Name)
        table.insert(Output, Result)
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    log("\n>>>\n" .. table.concat(Output, "\n") .. "\n<<<")

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------
