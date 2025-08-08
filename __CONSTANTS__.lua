---------------------------------------------------------------------------------------------------
---> __CONSTANTS__.lua <---
---------------------------------------------------------------------------------------------------

--- Contenedor global
_G.GPrefix = _G.GPrefix or {}

---------------------------------------------------------------------------------------------------

--- Prefijo a usar en los MODs
GPrefix.name = "zzzYAIM0425"

---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------
---> Constantes adicionales <---
---------------------------------------------------------------------------------------------------

--- Validación
local Flag = data and true or nil
Flag = Flag and data.raw and true or nil

--- Subgrupos existentes, se usa con frecuencia
if Flag and data.raw["item-subgroup"] then
    GPrefix.subgroups = data.raw["item-subgroup"]
end


--- Colores para el fondo de los indicadres
if Flag and data.raw["virtual-signal"] then
    GPrefix.color = {}
    GPrefix.color.red = data.raw["virtual-signal"]["signal-red"].icon
    GPrefix.color.green = data.raw["virtual-signal"]["signal-green"].icon
    GPrefix.color.blue = data.raw["virtual-signal"]["signal-blue"].icon
    GPrefix.color.cyan = data.raw["virtual-signal"]["signal-cyan"].icon
    GPrefix.color.pink = data.raw["virtual-signal"]["signal-pink"].icon
    GPrefix.color.yellow = data.raw["virtual-signal"]["signal-yellow"].icon
    GPrefix.color.white = data.raw["virtual-signal"]["signal-white"].icon
    GPrefix.color.grey = data.raw["virtual-signal"]["signal-grey"].icon
    GPrefix.color.black = data.raw["virtual-signal"]["signal-black"].icon
end

---------------------------------------------------------------------------------------------------
