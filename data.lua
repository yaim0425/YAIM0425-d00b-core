---------------------------------------------------------------------------------------------------
---> data.lua <---
---------------------------------------------------------------------------------------------------

--- Validar si se cargó antes
if GPrefix and GPrefix.name then return end

---------------------------------------------------------------------------------------------------
---> Cargar las funciones y constantes <---
---------------------------------------------------------------------------------------------------

require("Constants")
require("Functions")
require("util")

---------------------------------------------------------------------------------------------------
---> Funciones globales <---
---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------
---> Funciones internas <---
---------------------------------------------------------------------------------------------------

--- Contenedor de funciones y datos usados
--- unicamente en este archivo
local This_MOD = {}

--- Ejecutar las acciones propias de este archivo
function This_MOD.start()
    --- Darle formato a lo minado
    This_MOD.format_results()

    --- Clasificar la información de data.raw
    This_MOD.filter_data()
end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Darle formato a lo minado
function This_MOD.format_results()
    for _, values in pairs(data.raw) do
        for _, value in pairs(values) do
            local minable = value.minable
            if minable and minable.result then
                --- Dar el formato deseado
                minable.results = { {
                    type = "item",
                    name = minable.result,
                    amount = minable.count or 1
                } }

                --- Borrar
                minable.result = nil
                minable.count = nil
            end
        end
    end
end

--- Clasificar la información de data.raw
function This_MOD.filter_data()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Contenedores finales
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    GPrefix.Items = {}
    GPrefix.Tiles = {}
    GPrefix.Fluids = {}
    GPrefix.Recipes = {}
    GPrefix.Entities = {}
    GPrefix.Equipments = {}

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Otras funciones
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar si está oculta
    local function is_hidde(array)
        local Hidden = array.hidden
        Hidden = Hidden or GPrefix.get_key(array.flags, "hidden")
        Hidden = Hidden or GPrefix.get_key(array.flags, "spawnable")
        if Hidden then return true end
        return false
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Agrega las Recetas, Suelos y Objetos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Agregar la receta a GPrefix.Recipes
    local function add_recipe(recipe)
        --- Receta oculta
        if is_hidde(recipe) then return end

        --- No es usable
        if recipe.parameter then return end

        --- Recorrer los resultados
        for _, result in pairs(recipe.results or {}) do
            --- Espacio a usar
            local Recipes = GPrefix.Recipes[result.name] or {}
            GPrefix.Recipes[result.name] = Recipes

            --- Agregar la receta si no se encuentra
            local Found = GPrefix.get_table(Recipes, "name", recipe.name)
            if not Found then table.insert(Recipes, recipe) end

            --- Guardar referencia del resultado
            if result.type == "item" then GPrefix.Items[result.name] = true end
            if result.type == "fluid" then GPrefix.Fluids[result.name] = true end
        end

        --- Guardar referencia de los ingredientes
        for _, ingredient in pairs(recipe.ingredients or {}) do
            if ingredient.type == "item" then GPrefix.Items[ingredient.name] = true end
            if ingredient.type == "fluid" then GPrefix.Fluids[ingredient.name] = true end
        end
    end

    --- Agregar el suelo a GPrefix.Tiles
    local function add_tile(tile)
        --- El suelo no se puede quitar
        if not tile.minable then return end
        if not tile.minable.results then return end

        --- Verificar cada resultado
        for _, result in pairs(tile.minable.results) do
            --- El suelo no tiene receta
            if not GPrefix.Items[result.name] then
                GPrefix.Items[result.name] = true
            end

            --- Espacio a usar
            local Titles = GPrefix.Tiles[result.name] or {}
            GPrefix.Tiles[result.name] = Titles

            --- Agregar el suelo si no se encuentra
            local Found = GPrefix.get_table(Titles, "name", tile.name)
            if not Found then table.insert(Titles, tile) end
        end
    end

    --- Agregar el item a GPrefix.Items
    local function add_item(item)
        --- Objeto no apilable
        if not item.stack_size then return end

        --- Objeto oculto
        if is_hidde(item) then return end

        --- No es usable
        if item.parameter then return end

        --- Guardar objeto
        GPrefix.Items[item.name] = item

        --- Guardar suelo de no estarlo
        if item.place_as_tile and not GPrefix.Tiles[item.name] then
            local tile = data.raw.tile[item.place_as_tile.result]
            GPrefix.Tiles[item.name] = GPrefix.Tiles[item.name] or {}
            table.insert(GPrefix.Tiles[item.name], tile)
        end

        --- Valores a evaluar
        local Values = {}
        Values.Entities = "place_result"
        Values.Equipments = "place_as_equipment_result"

        --- Validar las propiedades
        for index, property in pairs(Values) do
            if item[property] then
                --- Objeto de igual nombre que el resultado
                if item.name == item[property] then
                    GPrefix[index][item.name] = true
                end

                --- Objeto de distinto nombre que el resultado
                if item.name ~= item[property] then
                    GPrefix[index][item[property]] = true
                    GPrefix[index][item.name] = item[property]
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Cargar las Recetas, Suelos, Fluidos y Objetos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Recorrer las recetas
    for _, recipe in pairs(data.raw.recipe) do
        add_recipe(recipe)
    end

    --- Cargar los fluidos
    for name, _ in pairs(GPrefix.Fluids) do
        local Fluid = data.raw.fluid[name]
        if Fluid then GPrefix.Fluids[name] = Fluid end
    end

    --- Cargar los suelos
    for _, tile in pairs(data.raw.tile) do
        add_tile(tile)
    end

    --- Cargar los objetos
    for _, array in pairs(data.raw) do
        for _, item in pairs(array) do
            add_item(item)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Buscar y cargar las Entidades y los Equipos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Evitar estos tipos
    local ignore_types = {}
    table.insert(ignore_types, "tile")
    table.insert(ignore_types, "fluid")
    table.insert(ignore_types, "recipe")

    --- Elementos a cargar
    local Values = {}
    Values["Entities"] = GPrefix.Entities
    Values["Equipments"] = GPrefix.Equipments

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Recorrer los elementos
    for Key, Value in pairs(Values) do
        --- Cargar de forma directa
        for name, value in pairs(Value) do
            --- Buscar el valor a evaluar
            if GPrefix.is_string(value) then
                goto jump_string
            end

            --- Buscar el elemento
            for _, element in pairs(data.raw) do
                element = element[name]

                --- Validación
                if not element then goto jump_entity end
                if GPrefix.get_key(ignore_types, element.type) then goto jump_entity end
                if Key == "Entities" then
                    if not element.minable then goto jump_entity end
                    if not element.minable.results then goto jump_entity end
                end
                if Key == "Equipments" then
                    if not element.shape then goto jump_entity end
                    if not element.sprite then goto jump_entity end
                end

                --- Guardar entidad
                Value[name] = element
                if true then break end

                --- Recepción del salto
                :: jump_entity ::
            end

            --- Recepción del salto
            :: jump_string ::
        end

        --- Cargar las entidades de forma indirecta
        for name, value in pairs(Value) do
            if GPrefix.is_string(value) then
                Value[name] = Value[value]
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Eliminar los elementos que no se pudieron cargar
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Variable contenedora
    local Info = ""
    local Delete = {}
    local Array = {}

    --- Valores a evaluar
    Array.Item = GPrefix.Items
    Array.Tile = GPrefix.Tiles
    Array.Fluid = GPrefix.Fluids
    Array.Entity = GPrefix.Entities
    Array.Equipment = GPrefix.Equipments

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Identificar valores vacios
    for iKey, elemnts in pairs(Array) do
        for jKey, elemnt in pairs(elemnts) do
            if GPrefix.is_boolean(elemnt) then
                Info = Info .. "\n\t\t"
                Info = Info .. iKey .. " not found or hidden: " .. jKey
                table.insert(Delete, jKey)
            end
        end
    end

    --- Eliminar valores vacios
    for _, list in pairs(Array) do
        for _, value in pairs(Delete) do
            list[value] = nil
        end
    end

    --- Imprimir un informe de lo eliminados
    if #Delete >= 1 then log(Info) end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Ejecutar las acciones propias de este archivo
This_MOD.start()

---------------------------------------------------------------------------------------------------
