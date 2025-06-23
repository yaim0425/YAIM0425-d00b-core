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
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Darle formato a lo minado
    for _, values in pairs(data.raw) do
        for _, value in pairs(values) do
            This_MOD.format_results(value)
            This_MOD.format_icons(value)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Clasificar la información de data.raw
    --- Crearción de:
    --- GPrefix.Items
    --- GPrefix.Tiles
    --- GPrefix.Fluids
    --- GPrefix.Recipes
    --- GPrefix.Entities
    --- GPrefix.Equipments
    This_MOD.filter_data()

    --- Clasificar la información de settings.startup
    --- Crearción de:
    --- GPrefix.Setting
    This_MOD.load_setting()

    --- Clasificar la información de data.raw.technology
    --- Crearción de:
    --- GPrefix.Tech
    This_MOD.load_technology()

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Crear espacios entre los elementos
    This_MOD.change_orders()

    --- Establecer traducción en todos los elementos
    This_MOD.set_localised()

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Darle formato a lo minado
function This_MOD.format_results(element)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar
    local minable = element.minable
    if not minable then return end
    if not minable.result then return end

    --- Dar el formato deseado
    minable.results = { {
        type = "item",
        name = minable.result,
        amount = minable.count or 1
    } }

    --- Borrar
    minable.result = nil
    minable.count = nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Dale el formato a los icons
function This_MOD.format_icons(element)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar
    if element.icons then return end
    if not element.icon then return end

    --- Dar el formato deseado
    element.icons = { {
        icon = element.icon,
        icon_size = element.icon_size ~= 64 and element.icon_size or nil
    } }

    --- Borrar
    element.icon_size = nil
    element.icon = nil

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------

--- Clasificar la información de data.raw
--- Crearción de:
--- GPrefix.Items
--- GPrefix.Tiles
--- GPrefix.Fluids
--- GPrefix.Recipes
--- GPrefix.Entities
--- GPrefix.Equipments
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

--- Clasificar la información de settings.startup
--- Crearción de:
--- GPrefix.Setting
function This_MOD.load_setting()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

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

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Clasificar la información de data.raw.technology
--- Crearción de:
--- GPrefix.Tech
function This_MOD.load_technology()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Contenedores para el resultado
    GPrefix.Tech = {
        Level = {},
        Recipe = {}
    }

    --- Renombrar
    local tech = data.raw.technology
    local Tech = GPrefix.Tech

    --- Variable a usar
    local levels = {}

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Buscar el niverl de la tecnología indicada
    local function get_level(name)
        --- Tecnología clasificada
        if levels[name] then
            return levels[name]
        end

        --- Renombrar
        local prereq = tech[name].prerequisites or {}

        --- Tecnología si requisitos
        if #prereq == 0 then
            levels[name] = 1
            return 1
        end

        --- Buscar el requisito más dejano
        local max = 0
        for _, pre in ipairs(prereq) do
            local pre_level = get_level(pre)
            if pre_level > max then max = pre_level end
        end

        --- Guardar y devolver el nivel
        levels[name] = max + 1
        return levels[name]
    end

    --- Clasificar todos tecnología
    for name in pairs(tech) do
        get_level(name)
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Recorrer cada tecnología
    for name, data in pairs(tech) do
        --- Obtener el nivel de la tecnología
        local level = levels[name]

        --- Guardar la tecnología en su nivel
        Tech.Level[level] = Tech.Level[level] or {}
        Tech.Level[level][name] = data

        --- Indexar la tecnología con a receta que desbloquea
        for _, effect in ipairs(data.effects or {}) do
            if effect.type == 'unlock-recipe' then
                local recipe = effect.recipe
                local current = Tech.Recipe[recipe]

                if not current or level > current.level then
                    Tech.Recipe[recipe] = {
                        level = level,
                        technology = data,
                        effects = data.effects
                    }
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------

--- Crear espacios entre los elementos
function This_MOD.change_orders()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Inicializar las vaiables
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local Orders = {}
    local Source = {}
    local N = 0

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Grupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inicializar las vaiables
    Orders = {}
    Source = {}

    --- Agrupar los Grupos
    for _, element in pairs(data.raw["item-group"]) do
        --- Validación
        if not element.order then goto jump_group end

        --- Agrupar
        table.insert(Source, element)
        table.insert(Orders, element.order)

        --- Receptor del salto
        ::jump_group::
    end

    --- Cantidad de afectados
    N = GPrefix.get_length(data.raw["item-group"])
    N = GPrefix.digit_count(N) + 1

    --- Ordenear los orders
    table.sort(Orders)

    --- Cambiar el order de los subgrupos
    for iKey, order in pairs(Orders) do
        for jKey, element in pairs(Source) do
            if element.order == order then
                element.order = GPrefix.pad_left(N, iKey) .. "0"
                table.remove(Source, jKey)
                break
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Subgrupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inicializar las vaiables
    Orders = {}
    Source = {}

    --- Agrupar los subgrupos
    for _, element in pairs(data.raw["item-subgroup"]) do
        --- Validación
        if not element.group then goto jump_subgroup end
        if not element.order then element.order = data.raw["item-group"][element.group].order end

        --- Agrupar
        Source[element.group] = Source[element.group] or {}
        table.insert(Source[element.group], element)

        Orders[element.group] = Orders[element.group] or {}
        table.insert(Orders[element.group], element.order)

        --- Receptor del salto
        ::jump_subgroup::
    end

    --- Cambiar el order de los subgrupos
    for subgroup, orders in pairs(Orders) do
        --- Ordenear los orders
        table.sort(orders)

        --- Cantidad de afectados
        N = GPrefix.get_length(orders)
        N = GPrefix.digit_count(N) + 1

        --- Remplazar los orders
        for iKey, order in pairs(orders) do
            for jKey, element in pairs(Source[subgroup]) do
                if element.order == order then
                    element.order = GPrefix.pad_left(N, iKey) .. "0"
                    table.remove(Source[subgroup], jKey)
                    break
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Establecer subgrupos por defecto
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Subgrupos por defecto
    local Empty = {
        type = "item-subgroup",
        name = "subgroup-empty",
        group = "other",
        order = "999"
    }

    --- Crear el Subgrupos por defecto
    data:extend({ Empty })

    --- Inicializar las vaiables
    Orders = {}
    Source = {}
    Source.Items = GPrefix.Items
    Source.Fluids = GPrefix.Fluids
    Source.Recipes = GPrefix.Recipes

    --- Objetos, recetas y fluidos
    for Key, Values in pairs(Source) do
        if Key ~= "Recipes" then Values = { Values } end
        for _, values in ipairs(Values) do
            for _, value in pairs(values) do
                if not value.subgroup then
                    value.subgroup = Empty.name
                    value.order = value.name
                end
                if not value.order then
                    value.order = value.name
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Objetos, recetas y demás
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inicializar las vaiables
    Orders = {}
    Source = {}

    --- Agrupar	los objetos, recetas y demás
    for _, elements in pairs(data.raw) do
        for _, element in pairs(elements) do
            --- Evitar estos tipos
            if element.type == "item-group" then break end
            if element.type == "item-subgroup" then break end

            --- Validación
            if not element.subgroup then goto jump_element end
            if not element.order then goto jump_element end

            --- Agrupar
            Source[element.subgroup] = Source[element.subgroup] or {}
            table.insert(Source[element.subgroup], element)

            Orders[element.subgroup] = Orders[element.subgroup] or {}
            table.insert(Orders[element.subgroup], element.order)

            --- Receptor del salto
            :: jump_element ::
        end
    end

    --- Cambiar el order de los subgrupos
    for subgroup, orders in pairs(Orders) do
        --- Ordenear los orders
        table.sort(orders)

        --- Cantidad de afectados
        N = GPrefix.get_length(orders)
        N = GPrefix.digit_count(N) + 1

        --- Remplazar los orders
        for iKey, order in pairs(orders) do
            for jKey, element in pairs(Source[subgroup]) do
                if element.order == order then
                    element.order = GPrefix.pad_left(N, iKey) .. "0"
                    table.remove(Source[subgroup], jKey)
                    break
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Agrupar las recetas
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for name, recipes in pairs(GPrefix.Recipes) do
        local item = GPrefix.Items[name]
        if item then
            item.order = item.order or "0"
            local order = tonumber(item.order) or 0
            for _, recipe in pairs(recipes) do
                if #recipe.results == 1 then
                    recipe.subgroup = item.subgroup
                    recipe.order = GPrefix.pad_left(#item.order, order)
                    order = order + 1
                end
            end
        end
    end
end

--- Establecer traducción en todos los elementos
function This_MOD.set_localised()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Protipos a corregir
    local Array = {}
    Array.tile = GPrefix.Tiles
    Array.fluid = GPrefix.Fluids
    Array.entity = GPrefix.Entities
    Array.equipment = GPrefix.Equipments

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Establece el nombre de la receta
    local function set_localised(name, recipe, field)
        --- Valores a usar
        local Field = "localised_" .. field
        local fluid = GPrefix.Fluids[name]
        local item = GPrefix.Items[name]

        --- El resultado es un objeto
        if item then
            --- Nombre del objeto por defecto
            recipe[Field] = item[Field]

            --- Traducción para una entidad
            if item.place_result then
                local Entiy = GPrefix.Entities[item.place_result]
                item[Field] = Entiy[Field]
                recipe[Field] = Entiy[Field]
            end

            --- Traducción para un suelo
            if item.place_as_tile then
                local tile = data.raw.tile[item.place_as_tile.result]
                item[Field] = tile[Field]
                recipe[Field] = tile[Field]
            end

            --- Traducción para un equipamiento
            if item.place_as_equipment_result then
                local result = item.place_as_equipment_result
                local equipment = GPrefix.Equipments[result]
                if equipment then
                    item[Field] = equipment[Field]
                    recipe[Field] = equipment[Field]
                end
            end
        end

        --- El resultado es un liquido
        if fluid then recipe[Field] = fluid[Field] end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Establecer la traducción
    for type, subgroup in pairs(Array) do
        if type ~= "tile" then subgroup = { subgroup } end
        for _, elements in pairs(subgroup) do
            for _, element in pairs(elements) do
                if element.localised_name then
                    if GPrefix.is_table(element.localised_name) and element.localised_name[1] ~= "" then
                        element.localised_name = { "", element.localised_name }
                    end
                end
                if not element.localised_name then
                    element.localised_name = { "", { type .. "-name." .. element.name } }
                end
                if not element.localised_description then
                    element.localised_description = { "", { type .. "-description." .. element.name } }
                end
            end
        end
    end

    --- Establecer la traducción de los objetos
    for _, item in pairs(GPrefix.Items) do
        if item.localised_name then
            if GPrefix.is_table(item.localised_name) and item.localised_name[1] ~= "" then
                item.localised_name = { "", item.localised_name }
            end
        end
        for _, field in pairs({ "name", "description" }) do
            local Field = "localised_" .. field
            if not item[Field] then
                item[Field] = { "", { "item-" .. field .. "." .. item.name } }
                set_localised(item.name, {}, field)
            end
        end
    end

    --- Establecer la traducción en la receta
    for _, recipes in pairs(GPrefix.Recipes) do
        if recipes.localised_name then
            if GPrefix.is_table(recipes.localised_name) and recipes.localised_name[1] ~= "" then
                recipes.localised_name = { "", recipes.localised_name }
            end
        end

        for _, recipe in pairs(recipes) do
            for _, field in pairs({ "name", "description" }) do
                local Field = "localised_" .. field
                --- Establece el nombre de la receta
                if not recipe[Field] then
                    --- Recetas con varios resultados
                    if #recipe.results ~= 1 then
                        if not recipe.main_product or recipe.main_product == "" then
                            --- Traducción por defecto
                            recipe[Field] = { "", { "recipe-" .. field .. "." .. recipe.name } }
                        else
                            --- Usar objeto o fluido de referencia
                            set_localised(recipe.main_product, recipe, field)
                        end
                    end

                    --- Receta con unico resultado
                    if #recipe.results == 1 then
                        local result = recipe.results[1]
                        set_localised(result.name, recipe, field)
                    end
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Ejecutar las acciones propias de este archivo
This_MOD.start()

---------------------------------------------------------------------------------------------------
