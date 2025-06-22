---------------------------------------------------------------------------------------------------
--> data.lua <--
---------------------------------------------------------------------------------------------------

---> Cargar las funciones y constantes
require("Constants")
require("Functions")
require("util")

---------------------------------------------------------------------------------------------------
---> Funciones globales <---
---------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------
---> Funciones internas <--
---------------------------------------------------------------------------------------------------

--- Contenedor de funciones y datos usados
--- unicamente en este archivo
local This_MOD = {}

--- Ejecutar las acciones propias de este archivo
function This_MOD.start()

end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Darle el formato deseado a las opciones
--- de configuración de los mods
function This_MOD.load_setting()
    --- Inicializar el contenedor
    GPrefix.Setting = {}

    --- Recorrer las opciones de configuración
    for key, value in pairs(settings.startup) do
        --- Separar los datos esperados
        local prefix = GPrefix.name .. "%-"
        local id, name = key:match(prefix .. "(%d+)%-(.+)")

        --- Validar los datos obtenidos
        if id and name then
            GPrefix.Setting[id] = GPrefix.Setting[id] or {}
            GPrefix.Setting[id][name] = value
        end
    end
end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Ejecutar las acciones propias de este archivo
This_MOD.start()

---------------------------------------------------------------------------------------------------
