---------------------------------------------------------------------------------------------------
---> Functions.lua <---
---------------------------------------------------------------------------------------------------

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
--- @param array table
--- @return any #
---- Conteo de los elementos de la tabla
---- o nil si se poduce un error o la tabla esta vacia
function GPrefix.get_length(array)
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
end

--- Devuelve el key que le corresponde al valor dado
--- @param array table
--- @param value any
--- @return any #
---- __integer:__ Posición de la primera coincidencia con el valor
---- __nil:__ El valor dado no es valido
function GPrefix.get_key(array, value)
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
end

--- Cuenta la cantidad de números en el valor dado
--- @param value integer # __Ejemplo:__ _123_
--- @return any # __Ejemplo:__ _3_
function GPrefix.digit_count(value)
    if not GPrefix.is_number(value) then return nil end
    return string.len(tostring(value))
end

--- Agrega ceros a la izquierda hasta completar los digitos
--- @param digits integer # __Ejemplo:__ _5_
--- @param value integer # __Ejemplo:__ _123_
--- @return string # __Ejemplo:__ _00123_
function GPrefix.pad_left(digits, value)
    if not GPrefix.is_number(digits) then return "" end
    if not GPrefix.is_number(value) then return "" end
    return string.format("%0" .. digits .. "d", value)
end

--- Devuelve el elemento cuyo key y value se igual al dado
--- @param array table # Tabla en la cual buscar
--- @param key string # propiedad a buscar
--- @param value string # Valor a buscar
--- @return any #
---- Array de la primera coincidencia con los valores dados
---- o nil si se poduce un error o no lo encuentra
function GPrefix.get_table(array, key, value)
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
end

--- Busca de forma recursiva el key y value en la tabla dada
--- @param array table # Tabla en la cual buscar
--- @param key string # propiedad a buscar
--- @param value string # Valor a buscar
--- @return any #
---- Array con las tablas que contienen el key y value dado
---- o nil si no lo encuentra
function GPrefix.get_tables(array, key, value)
    --- Valores a devolver
    local Result = {}

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

    --- Validar la respuesta
    get_table(array)
    return #Result > 0 and Result or nil
end

--- Escribe en factorio-current.log la informacion contenida
--- en la variable dada
function GPrefix.log(...)
    --- Variable contenedora
    local Values = { ... }

    --- Validación básica
    if GPrefix.get_length(Values) == 0 then return end

    --- Variable de salida
    local Output = ""
    local log_index = {}
    local log_printed = {}

    --- Devuelve la información dada en formato lua
    --- evita los ciclos infinitos
    --- @param value any
    --- @return string
    local function to_string(value)
        --- Variables a usar
        local Types = {}
        local varType = type(value)

        --- Variables atomica
        Types = { "function", "thread" }
        if GPrefix.get_key(Types, varType) then
            return varType .. "( ) end"
        end

        Types = { "userdata" }
        if GPrefix.get_key(Types, varType) then
            return varType
        end

        Types = { "string" }
        if GPrefix.get_key(Types, varType) then
            value = string.gsub(value, "'", '"')
            if string.find(value, "\n") then
                return "[[" .. value .. "]]"
            end
            return "'" .. value .. "'"
        end

        Types = { "number" }
        if GPrefix.get_key(Types, varType) then
            return value
        end

        Types = { "boolean", "nil" }
        if GPrefix.get_key(Types, varType) then
            return tostring(value)
        end

        --- La variable es desconocida
        Types = { "table" }
        if not GPrefix.get_key(Types, varType) then
            return "unknown"
        end

        --- Detectar Impreso
        local Key = GPrefix.get_key(log_printed, value)
        if Key then
            return "'This is: " .. Key .. "'"
        end

        --- Variables a usar
        local Table = {}
        local String = ""

        --- Guardar la referencia de la tabla
        log_printed[table.concat(log_index, ".")] = value

        --- Recorrer los valores de la table
        for key, element in pairs(value) do
            --- Evitar las variables en uso
            local Flag = false
            Flag = Flag or element == log_index
            Flag = Flag or element == log_printed
            if Flag then goto JumpLog end

            --- Guardar el indice de la variable
            Key = "[ " .. to_string(key) .. " ]"
            table.insert(log_index, Key)

            --- Convertir la variable en cadena
            String = to_string(element)
            String = " = " .. string.gsub(String, "\n", "\n\t")
            String = Key .. String

            --- Guardar la variable convertida en cadena
            table.insert(Table, String)

            --- Eliminar el indice de la tabla
            table.remove(log_index, #log_index)

            --- Recepción del salto
            :: JumpLog ::
        end

        --- La tabla esta vacia
        if #Table == 0 then return "{ }" end

        --- Valor de salida
        String = table.concat(Table, "," .. "\n\t")
        String = "{" .. "\n\t" .. String .. "\n" .. "}"
        return String
    end

    --- Convertir las variables
    for Index, Value in pairs(Values) do
        --- Establecer el nombre de la variable
        local String = nil
        if GPrefix.is_table(Value) and Value.name then
            String = Value.name
        end
        if not String then String = Index end

        --- Variable para evitar la reimpresión
        table.insert(log_index, String)

        --- Convertir la variable en cadena
        String = "[ " .. to_string(String) .. " ]"
        String = String .. " = " .. to_string(Value)

        --- Guardar la variable convertida en cadena
        Output = Output .. "\n" .. String

        --- Remover el indice
        table.remove(log_index, #log_index)
    end

    --- Mostrar el resultado
    log("\n>>>" .. Output .. "\n<<<")
end

---------------------------------------------------------------------------------------------------
