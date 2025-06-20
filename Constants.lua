---------------------------------------------------------------------------------------------------
---> Constants.lua <---
---------------------------------------------------------------------------------------------------

--- Contenedor global del MOD
---@type table
_G.GPrefix   = _G.GPrefix or {}

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Unidades de energia
GPrefix.Unit = {}

--- Creat el directorio
for Digits, Unit in pairs({ "", "k", "M", "G", "T", "P", "E", "Z", "Y", "R", "Q" }) do
    GPrefix.Unit[Unit] = 3 * (Digits - 1)
end

--- Invertir valores
for Key, Value in pairs(GPrefix.Unit) do
    GPrefix.Unit[Value] = Key
end

--- Prefijo a usar en los MODs
GPrefix.name = "zzzYAIM0425"

---------------------------------------------------------------------------------------------------
