---------------------------------------------------------------------------------------------------
---> __CONSTANTS__.lua <---
---------------------------------------------------------------------------------------------------

--- Contenedor global
_G.GPrefix = _G.GPrefix or {}

---------------------------------------------------------------------------------------------------

--- Prefijo a usar en los MODs
GPrefix.name = "zzzYAIM0425"

--- Subgrupos existentes, se usa con frecuencia
if data then GPrefix.subgroups = data.raw["item-subgroup"] end

--- Patrón de identificación
GPrefix.name_pattern = GPrefix.name .. "%-(%d+)%-(.+)"

---------------------------------------------------------------------------------------------------
