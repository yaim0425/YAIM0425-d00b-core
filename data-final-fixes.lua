---------------------------------------------------------------------------------------------------
---> data-final-fixes.lua <---
---------------------------------------------------------------------------------------------------

--- Validar si se cargó antes
if GPrefix and GPrefix.name then return end

---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------
---> Cargar las funciones y constantes <---
---------------------------------------------------------------------------------------------------

require("__CONSTANTS__")
require("__FUNCTIONS__")
require("util")

---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------
---> Funciones globales <---
---------------------------------------------------------------------------------------------------

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
end

--- Crear una copia del objeto dado
--- @param item table # Objeto a duplicar
--- @return any # Copia del objeto
function GPrefix.duplicate_item(item)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar el valor de entrada
    if not GPrefix.is_table(item) then return nil end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Propiedades a copiar
    local Copy_this = {}
    table.insert(Copy_this, "name")
    table.insert(Copy_this, "icons")
    table.insert(Copy_this, "order")
    table.insert(Copy_this, "weight")
    table.insert(Copy_this, "subgroup")
    table.insert(Copy_this, "color_hint")
    table.insert(Copy_this, "drop_sound")
    table.insert(Copy_this, "pick_sound")
    table.insert(Copy_this, "stack_size")
    table.insert(Copy_this, "localised_name")
    table.insert(Copy_this, "inventory_move_sound")
    table.insert(Copy_this, "localised_description")
    table.insert(Copy_this, "ingredient_to_weight_coefficient")

    --- Contenedor del objeto
    local Item = {}
    Item.type = "item"

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Copiar las propiedades
    for _, copy_this in pairs(Copy_this) do
        Item[copy_this] = util.copy(item[copy_this])
    end

    --- Devolver el nuevo objeto
    return Item

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Elimina el indicador del nombre dado
--- @param name string # __Ejemplo:__ prefix-0000-0200-name
--- @return string # __Ejemplo:__ 0000-0200-name
function GPrefix.delete_prefix(name)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    return string.gsub(name, GPrefix.name .. "%-", "") or ""

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Crea un subgroup despues del dado
--- @param old_name string # Nombre del subgrupo a duplicar
--- @param new_name string # Nombre a asignar al duplicado
--- @return any # Devuelve el duplicado
--- o una tabla vacio si se poduce un error
function GPrefix.duplicate_subgroup(old_name, new_name)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if not GPrefix.is_string(old_name) then return nil end
    if not GPrefix.is_string(new_name) then return nil end
    local Subgroup = util.copy(GPrefix.subgroups[old_name])
    if GPrefix.subgroups[new_name] then return nil end
    if not Subgroup then return nil end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Order de referencia
    local Order = {}
    Order[1] = Subgroup.order
    Order[2] = math.floor(tonumber(Order[1]) / 10) * 10
    Order[3] = Order[2]

    --- Buscar el siguiente order
    while true do
        Order[2] = Order[2] + 1
        if Order[2] - Order[3] > 9 then return nil end
        Order[1] = GPrefix.pad_left_zeros(#Order[1], Order[2])

        for _, subgroup in pairs(GPrefix.subgroups) do
            if subgroup.group == Subgroup.group then
                Order[4] = subgroup.order == Order[1]
                if Order[4] then break end
            end
        end
        if not Order[4] then break end
    end

    --- Crear el subgroup
    Subgroup.name = new_name
    Subgroup.order = Order[1]
    data:extend({ Subgroup })
    return Subgroup

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Tecnología que desbloquea la receta dada
--- @param recipe table # receta a buscar
--- @return any # Tecnología que desbloquea la receta dada
function GPrefix.get_technology(recipe)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Variable a usar
    local Techs

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Comparar ambos elementos
    local function compare(old, new, expensive)
        if
            (not expensive and old.level > new.level)
            or (expensive and old.level < new.level)
        then
            return new
        elseif old.level == new.level then
            local Old_unit = old.technology.unit
            local New_unit = new.technology.unit
            local Old_ingredients = Old_unit and #Old_unit.ingredients or 0
            local New_ingredients = New_unit and #New_unit.ingredients or 0
            if
                (not expensive and Old_ingredients > New_ingredients)
                or (expensive and Old_ingredients < New_ingredients)
            then
                return new
            elseif Old_ingredients == New_ingredients then
                local Old_count = Old_unit and Old_unit.count or 0
                local New_count = New_unit and New_unit.count or 0
                if
                    (not expensive and Old_count > New_count)
                    or (expensive and Old_count < New_count)
                then
                    return new
                end
            end
        end
        return old
    end


    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Buscar la receta dada
    Techs = GPrefix.tech.recipe[recipe.name]

    --- Tecnología más "barata" que desbloquea la receta dada
    if Techs then
        --- Solo una tecnología desbloquea la receta
        if #Techs == 1 then return Techs[1].technology end

        --- Buscar la tecnología más "barata"
        local Tech = Techs[1]
        for _, New in pairs(Techs) do
            Tech = compare(Tech, New, false)
        end
        return Tech.technology
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Tecnologías que desbloquean los ingredientes
    Techs = {}
    for _, ingredient in pairs(recipe.ingredients or {}) do
        for _, Recipe in pairs(GPrefix.Recipes[ingredient.name] or {}) do
            for _, Tech in pairs(GPrefix.tech.recipe[Recipe.name] or {}) do
                Techs[Tech.technology.name] = Tech
            end
        end
    end

    --- Buscar la tecnología más "cara"
    local Tech = Techs[1]
    for _, New in pairs(Techs) do
        Tech = compare(Tech, New, true)
    end
    return Tech.technology

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
    local id, name = mod_name:match(GPrefix.name .. "%-(%d+)%-(.+)")

    --- Información propia del mod
    that_mod.id = id
    that_mod.name = name
    that_mod.prefix = GPrefix.name .. "-" .. id .. "-"

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Cargar los prototipos al juego
--- @param ... any
function GPrefix.extend(...)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Renombrar los parametros dados
    local Prototypes = { ... }
    if #Prototypes == 0 then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Clasificar y guardar el prototipo
    local function extend(prototype)
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Recipes
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "recipe" then break end

            GPrefix.Recipes[prototype.name] = GPrefix.Recipes[prototype.name] or {}
            table.insert(GPrefix.Recipes[prototype.name], prototype)
            prototype.enabled = true
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Fluids
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "fluid" then break end

            GPrefix.Fluids[prototype.name] = prototype
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Items
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if not prototype.stack_size then break end

            GPrefix.Items[prototype.name] = prototype
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Tiles
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "tile" then break end
            if not prototype.minable then break end
            if not prototype.minable.results then break end

            for _, result in pairs(prototype.minable.results) do
                GPrefix.Tiles[result.name] = GPrefix.Tiles[result.name] or {}
                table.insert(GPrefix.Tiles[result.name], prototype)
            end
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Equipments
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if not prototype.shape then break end

            GPrefix.Equipments[prototype.name] = prototype
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Entities
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if not prototype.minable then break end
            if not prototype.minable.results then break end

            for _, Result in pairs(prototype.minable.results) do
                GPrefix.Entities[Result.name] = prototype
            end
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Technologies
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "technology" then break end
            GPrefix.var_dump(GPrefix.tech.level)
            GPrefix.var_dump(GPrefix.tech.recipe)
            -- local Technologies = GPrefix.Technologies
            -- for _, effect in pairs(arg.effects or {}) do
            --     if effect.type == "unlock-recipe" then
            --         Technologies[effect.recipe] = Technologies[effect.recipe] or {}
            --         table.insert(Technologies[effect.recipe], arg.effects)
            --     end
            -- end
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Guardar el nuevo prototipo
    for _, arg in pairs(Prototypes) do
        extend(arg)
        data:extend({ arg })
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Agrega una receta nueva a una tecnología que ya tiene otra receta como referencia
--- @param old_recipe_name string # Nombre de la receta de referencia
--- @param new_recipe table # Receta a agregar
function GPrefix.add_recipe_to_tech_with_recipe(old_recipe_name, new_recipe)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Crea la receta de ser necesario
    if not data.raw.recipe[new_recipe.name] then
        GPrefix.extend(new_recipe)
    end

    --- Renombrar la variable
    local Recipe = GPrefix.tech.recipe

    --- Espacio para guardar la info
    local Space = Recipe[new_recipe.name] or {}
    Recipe[new_recipe.name] = Space

    --- Transferir a info al espacio
    for _, tech in pairs(Recipe[old_recipe_name] or {}) do
        --- Evitar duplicados
        if not Space[tech.technology.name] then

            --- Guardar la info
            Space[tech.technology.name] = tech

            --- Agregar la nueva receta
            table.insert(tech.effects, {
                type = "unlock-recipe",
                recipe = new_recipe.name
            })

            --- Desactivar la receta
            new_recipe.enabled = false
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

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
    if not GPrefix.is_string(element.icon) then return end

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
---- GPrefix.Items
---- GPrefix.Tiles
---- GPrefix.Fluids
---- GPrefix.Recipes
---- GPrefix.Entities
---- GPrefix.Equipments
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
            if not GPrefix.is_string(value) then
                for _, element in pairs(data.raw) do
                    --- Buscar la entidad
                    element = element[name]

                    --- El ciclo es solo para saltar
                    --- elementos no deseados
                    repeat
                        --- Coasa evitar
                        if not element then break end
                        if GPrefix.get_key(ignore_types, element.type) then break end
                        if Key == "Entities" then
                            if not element.minable then break end
                            if not element.minable.results then break end
                        end
                        if Key == "Equipments" then
                            if not element.shape then break end
                            if not element.sprite then break end
                        end

                        --- Guardar entidad
                        Value[name] = element
                    until true
                end
            end
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
---- GPrefix.Setting
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
            GPrefix.Setting[id][name] = value.value
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Clasificar la información de data.raw.technology
---- GPrefix.Tech
function This_MOD.load_technology()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Contenedores para el resultado
    GPrefix.tech = {}
    GPrefix.tech.raw = {}
    GPrefix.tech.level = {}
    GPrefix.tech.recipe = {}

    --- Renombrar
    local tech = data.raw.technology
    local Tech = GPrefix.tech

    --- Variable a usar
    local levels = {}

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Buscar el niverl de la tecnología indicada
    local function get_level(name)
        --- --- --- --- --- --- --- --- --- --- --- --- ---

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

        --- --- --- --- --- --- --- --- --- --- --- --- ---
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

        --- Indexar la tecnología por su nombre
        Tech.raw[data.name] = {
            level = level,
            technology = data,
            effects = data.effects
        }

        --- Indexar la tecnología por su nivel
        Tech.level[level] = Tech.level[level] or {}
        Tech.level[level][name] = Tech.raw[data.name]

        --- Indexar la tecnología con a receta que desbloquea
        for _, effect in ipairs(data.effects or {}) do
            if effect.type == 'unlock-recipe' then
                local space = Tech.recipe[effect.recipe] or {}
                Tech.recipe[effect.recipe] = space
                space[data.name] = Tech.raw[data.name]
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





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Grupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inicializar las vaiables
    Orders = {}
    Source = {}

    --- Agrupar los Grupos
    for _, element in pairs(data.raw["item-group"]) do
        if element.order then
            table.insert(Source, element)
            table.insert(Orders, element.order)
        end
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
                element.order = GPrefix.pad_left_zeros(N, iKey) .. "0"
                table.remove(Source, jKey)
                break
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Subgrupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inicializar las vaiables
    Orders = {}
    Source = {}

    --- Agrupar los subgroups
    for _, element in pairs(GPrefix.subgroups) do
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        Source[element.group] = Source[element.group] or {}
        table.insert(Source[element.group], element)
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        Orders[element.group] = Orders[element.group] or {}
        table.insert(Orders[element.group], element.order or element.name)
        --- --- --- --- --- --- --- --- --- --- --- --- ---
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
                    element.order = GPrefix.pad_left_zeros(N, iKey) .. "0"
                    table.remove(Source[subgroup], jKey)
                    break
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





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

            --- El ciclo es solo para saltar
            --- elementos no deseados
            repeat
                --- Validación
                if not element.subgroup then break end
                if not element.order then break end

                --- Agrupar
                Source[element.subgroup] = Source[element.subgroup] or {}
                table.insert(Source[element.subgroup], element)

                Orders[element.subgroup] = Orders[element.subgroup] or {}
                table.insert(Orders[element.subgroup], element.order)
            until true
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
                    element.order = GPrefix.pad_left_zeros(N, iKey) .. "0"
                    table.remove(Source[subgroup], jKey)
                    break
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





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
                    recipe.order = GPrefix.pad_left_zeros(#item.order, order)
                    order = order + 1
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Establecer traducción en todos los elementos
function This_MOD.set_localised()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Funciones a usar
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





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Traducir estas secciones
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Protipos a corregir
    local Array = {}
    Array.tile = GPrefix.Tiles
    Array.fluid = GPrefix.Fluids
    Array.entity = GPrefix.Entities
    Array.equipment = GPrefix.Equipments

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

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Traducción de los objetos y las recetas
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

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
---> Ejecutar las funciones internas <---
---------------------------------------------------------------------------------------------------

--- Ejecutar las acciones propias de este archivo
This_MOD.start()

---------------------------------------------------------------------------------------------------
