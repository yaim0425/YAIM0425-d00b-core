<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> data-final-fixes.lua <---
---------------------------------------------------------------------------------------------------

--- Validar si se cargó antes
if GPrefix and GPrefix.name then return end

---------------------------------------------------------------------------------------------------
=======
---------------------------------------------------------------------------
---[ data-final-fixes.lua ]---
---------------------------------------------------------------------------
>>>>>>> nuevo/main





<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> Cargar las funciones y constantes <---
---------------------------------------------------------------------------------------------------

require("__CONSTANTS__")
require("__FUNCTIONS__")
require("util")

---------------------------------------------------------------------------------------------------
=======
---------------------------------------------------------------------------
---[ Validar si se cargó antes ]---
---------------------------------------------------------------------------

if GMOD and GMOD.name then return end

---------------------------------------------------------------------------





---------------------------------------------------------------------------
---[ Cargar las funciones y constantes ]---
---------------------------------------------------------------------------

require("__CONSTANTS__")
require("__FUNCTIONS__")

---------------------------------------------------------------------------
>>>>>>> nuevo/main





<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> Funciones globales <---
---------------------------------------------------------------------------------------------------

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
        Item[copy_this] = GPrefix.copy(item[copy_this])
    end

    --- Devolver el nuevo objeto
    return Item

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
---------------------------------------------------------------------------
---[ Funciones globales ]---
---------------------------------------------------------------------------

--- Validar si está oculta
--- @param element table
--- @return boolean
function GMOD.is_hidde(element)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar los valores
    local Hidden = false
    Hidden = Hidden or element.hidden
    Hidden = Hidden or element.parameter
    Hidden = Hidden or GMOD.get_key(element.flags or {}, "hidden")

    --- Devolver el resultado
    return Hidden

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main
end

--- Crea un subgroup despues del dado
--- @param old_name string # Nombre del subgrupo a duplicar
--- @param new_name string # Nombre a asignar al duplicado
--- @return any # Devuelve el duplicado
--- o una tabla vacio si se poduce un error
<<<<<<< HEAD
function GPrefix.duplicate_subgroup(old_name, new_name)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if not GPrefix.is_string(old_name) then return nil end
    if not GPrefix.is_string(new_name) then return nil end
    local Subgroup = GPrefix.copy(GPrefix.subgroups[old_name])
    if GPrefix.subgroups[new_name] then return nil end
    if not Subgroup then return nil end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
function GMOD.duplicate_subgroup(old_name, new_name)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Validación
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if type(old_name) ~= "string" then return end
    if type(new_name) ~= "string" then return end
    if GMOD.subgroups[new_name] then return end
    local Subgroup = GMOD.copy(GMOD.subgroups[old_name])
    if not Subgroup then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Buscar un order disponible
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Order de referencia
    local Order = {}
    Order[1] = Subgroup.order
    Order[2] = math.floor(tonumber(Order[1]) / 10) * 10
    Order[3] = Order[2]

    --- Buscar el siguiente order
    while true do
        Order[2] = Order[2] + 1
<<<<<<< HEAD
        if Order[2] - Order[3] > 9 then return nil end
        Order[1] = GPrefix.pad_left_zeros(#Order[1], Order[2])

        for _, subgroup in pairs(GPrefix.subgroups) do
=======
        if Order[2] - Order[3] > 9 then return end
        Order[1] = GMOD.pad_left_zeros(#Order[1], Order[2])

        for _, subgroup in pairs(GMOD.subgroups) do
>>>>>>> nuevo/main
            if subgroup.group == Subgroup.group then
                Order[4] = subgroup.order == Order[1]
                if Order[4] then break end
            end
        end
        if not Order[4] then break end
    end

<<<<<<< HEAD
    --- Crear el subgroup
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Crear el subgroup
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

>>>>>>> nuevo/main
    Subgroup.name = new_name
    Subgroup.order = Order[1]
    data:extend({ Subgroup })
    return Subgroup

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Tecnología que desbloquea la receta dada
--- @param recipe table # receta a buscar
--- @return any # Tecnología que desbloquea la receta dada
function GPrefix.get_technology(recipe)

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if not recipe then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



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
        --- Indicador de la primera tecnología
        local key = next(Techs)

        --- Solo una tecnología desbloquea la receta
        if GPrefix.get_length(Techs) == 1 then
            return Techs[key].technology
        end

        --- Buscar la tecnología más "barata"
        local Tech = Techs[key]
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
        for _, Recipe in pairs(GPrefix.recipes[ingredient.name] or {}) do
            for _, Tech in pairs(GPrefix.tech.recipe[Recipe.name] or {}) do
                Techs[Tech.technology.name] = Tech
            end
        end
    end

    --- Los ingredientes no requieren tecnologias
    if not GPrefix.get_length(Techs) then return end

    --- Buscar la tecnología más "cara"
    local key = next(Techs)
    local Tech = Techs[key]
    for _, New in pairs(Techs) do
        Tech = compare(Tech, New, true)
    end
    return Tech.technology

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Crear la technology en el spacio dado y agregar la receta
--- @param prefix string
--- @param tech table
--- @param new_recipe table
--- @return any
function GPrefix.create_tech(prefix, tech, new_recipe, info)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if not tech then return end
    info = info or {}

    --- Crea la receta de ser necesario
    if not data.raw.recipe[new_recipe.name] then
        GPrefix.extend(new_recipe)
    end

    --- Nombre de la nueva tecnología
    local Tech_name = tech and tech.name or ""
    Tech_name = GPrefix.delete_prefix(Tech_name)
    Tech_name = info.name or prefix .. Tech_name

    --- La tecnología ya existe
    if GPrefix.tech.raw[Tech_name] then
        GPrefix.add_recipe_to_tech(Tech_name, new_recipe)
        return GPrefix.tech.raw[Tech_name].technology
    end

    --- Preprar la nueva tecnología
    local Tech = GPrefix.copy(tech)
    Tech.prerequisites = info.prerequisites or { Tech.name }
    Tech.name = Tech_name
    Tech.localised_description = nil
    Tech.effects = { {
        type = "unlock-recipe",
        recipe = new_recipe.name
    } }

    --- Crear la nueva tecnología
    GPrefix.extend(Tech)

    --- Devolver la tecnología
    return Tech

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Agrega una receta nueva a una tecnología que ya tiene otra receta como referencia
--- @param old_recipe_name string # Nombre de la receta de referencia
--- @param new_recipe table # Receta a agregar
function GPrefix.add_recipe_to_tech_with_recipe(old_recipe_name, new_recipe)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Agregar la receta a cada tecnología
    for _, tech in pairs(GPrefix.tech.recipe[old_recipe_name] or {}) do
        GPrefix.add_recipe_to_tech(tech.name, new_recipe)
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Agrega una receta nueva a una tecnología
--- @param tech_name string # Nombre de la tecnologia
--- @param new_recipe table # Receta a agregar
function GPrefix.add_recipe_to_tech(tech_name, new_recipe)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Crea la receta de ser necesario
    if not data.raw.recipe[new_recipe.name] then
        GPrefix.extend(new_recipe)
    end

    --- Renombrar la variable
    local Recipe = GPrefix.tech.recipe
    local Tech = GPrefix.tech.raw[tech_name]

    --- Validar
    if not Tech then return end

    --- Guardar la información
    Recipe[new_recipe.name] = Recipe[new_recipe.name] or {}
    table.insert(Recipe[new_recipe.name], Tech)

    --- Agregar la nueva receta
    table.insert(Tech.effects, {
        type = "unlock-recipe",
        recipe = new_recipe.name
    })

    --- Desactivar la receta
    new_recipe.enabled = false

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Obtiene el objeto que crea la entidad dada
--- @param entity table
--- @return any
function GPrefix.get_item_create_entity(entity)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if not entity.minable then return end
    if not entity.minable.results then return end

    --- Buscar el objeto
    for _, result in pairs(entity.minable.results) do
        if result.type == "item" then
            local Item = GPrefix.items[result.name]
            if Item.place_result == entity.name then
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Obtiene el objeto que crea la entidad dada
--- @param element table
--- @return any
function GMOD.get_item_create(element, propiety)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Validación
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if not element.minable then return end
    if not element.minable.results then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Buscar el objeto
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for _, result in pairs(element.minable.results) do
        if result.type == "item" then
            local Item = GMOD.items[result.name] or {}
            if Item[propiety] == element.name then
>>>>>>> nuevo/main
                return Item
            end
        end
    end

<<<<<<< HEAD
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Devuelve la tecnología que desbloquea una o varias recetas
--- @param value table # receta (tabla con .name) o lista de recetas
--- @return table|nil # Tecnología que desbloquea la receta o recetas
function GMOD.get_technology(value)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Lista de nombres de recetas
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validación
    if type(value) == "nil" then return end

    --- Enlistar las recetas
    local Recipe_list = {}
    if type(value) == "string" then
        table.insert(Recipe_list, value)
    elseif value.name then
        table.insert(Recipe_list, value.name)
    elseif type(value) == "table" then
        for _, r in pairs(value) do
            if type(r) == "string" then
                table.insert(Recipe_list, r)
            elseif type(r) == "table" and r.name then
                table.insert(Recipe_list, r.name)
            end
        end
    end

    --- Validación
    if #Recipe_list == 0 then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Función auxiliar para comparar dos tecnologías
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local function compare(old, new, expensive)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        if not old then return new end
        if not new then return old end

        local Old_unit = old.unit or {}
        local New_unit = new.unit or {}

        local Old_count = Old_unit.count or (Old_unit.count_formula and math.huge) or 0
        local New_count = New_unit.count or (New_unit.count_formula and math.huge) or 0

        local Old_ingredients = Old_unit.ingredients and #Old_unit.ingredients or 0
        local New_ingredients = New_unit.ingredients and #New_unit.ingredients or 0

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        -- Si buscamos la más barata
        if not expensive then
            if Old_ingredients ~= New_ingredients then
                return (Old_ingredients > New_ingredients) and new or old
            elseif Old_count ~= New_count then
                return (Old_count > New_count) and new or old
            else
                return (new.name < old.name) and new or old -- desempate por nombre
            end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        -- Si buscamos la más cara
        if Old_ingredients ~= New_ingredients then
            return (Old_ingredients < New_ingredients) and new or old
        elseif Old_count ~= New_count then
            return (Old_count < New_count) and new or old
        else
            return (new.name > old.name) and new or old -- desempate por nombre
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Buscar tecnologías que desbloquean las recetas
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local function find_techs_for_recipes(recipes)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        local Techs = {}
        for _, tech in pairs(data.raw.technology) do
            for _, effect in pairs(tech.effects or {}) do
                if effect.type == "unlock-recipe" then
                    for _, recipe_name in ipairs(recipes) do
                        if effect.recipe == recipe_name then
                            Techs[tech.name] = tech
                        end
                    end
                end
            end
        end
        return Techs

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Buscar tecnologías directas
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local Recipe_techs = find_techs_for_recipes(Recipe_list)

    if next(Recipe_techs) then
        local Key = next(Recipe_techs)
        local Selected = Recipe_techs[Key]
        for _, tech in pairs(Recipe_techs) do
            Selected = compare(Selected, tech, false)
        end
        return Selected
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Si no hay directas, buscar por los ingredientes
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local Ingredient_recipes = {}
    for _, recipe_name in ipairs(Recipe_list) do
        local Recipe = data.raw.recipe[recipe_name]
        for _, ingredient in pairs(Recipe.ingredients) do
            local Name = ingredient.name or ingredient[1]
            for _, recipe in pairs(GMOD.recipes[Name] or {}) do
                table.insert(Ingredient_recipes, recipe.name)
            end
        end
    end

    local Ingredient_techs = find_techs_for_recipes(Ingredient_recipes)

    if next(Ingredient_techs) then
        local Key = next(Ingredient_techs)
        local Selected = Ingredient_techs[Key]
        for _, tech in pairs(Ingredient_techs) do
            Selected = compare(Selected, tech, true)
        end
        return Selected
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Elimina el indicador del nombre dado
--- @param name string # __Ejemplo:__ prefix-i0MOD00-i0MOD20-name
--- @return string # __Ejemplo:__ # i0MOD00-i0MOD20-name
---- __ids-name,__ si se cumple el patron
---- o el nombre dado si no es así
function GMOD.delete_prefix(name)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    return name:gsub(GMOD.name .. "%-", "") or name

>>>>>>> nuevo/main
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Cargar los prototipos al juego
--- @param ... any
<<<<<<< HEAD
function GPrefix.extend(...)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
function GMOD.extend(...)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Renombrar los parametros dados
    local Prototypes = { ... }
    if #Prototypes == 0 then return end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Clasificar y guardar el prototipo
    local function extend(prototype)
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Recipes
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "recipe" then break end

            GPrefix.recipes[prototype.name] = GPrefix.recipes[prototype.name] or {}
            table.insert(GPrefix.recipes[prototype.name], prototype)
            prototype.enabled = true
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Fluids
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "fluid" then break end

            GPrefix.fluids[prototype.name] = prototype
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Items
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if not prototype.stack_size then break end

            GPrefix.items[prototype.name] = prototype
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
                GPrefix.tiles[result.name] = GPrefix.tiles[result.name] or {}
                table.insert(GPrefix.tiles[result.name], prototype)
            end
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Equipments
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if not prototype.shape then break end

            GPrefix.equipments[prototype.name] = prototype
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
                GPrefix.entities[Result.name] = prototype
            end
            return
        end
        --- --- --- --- --- --- --- --- --- --- --- --- ---



        --- --- --- --- --- --- --- --- --- --- --- --- ---
        ---> Technologies
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "technology" then break end

            --- Nivel de la nueva tecnologia
            local Level = 0
            for _, name in pairs(prototype.prerequisites) do
                if Level < GPrefix.tech.raw[name].level then
                    Level = GPrefix.tech.raw[name].level
                end
            end
            Level = Level + 1

            --- Valores a guardar
            local value = {
                level = Level,
                technology = prototype,
                effects = prototype.effects
            }

            --- Indexar la nueva tecnologia
            GPrefix.tech.raw[prototype.name] = value
            GPrefix.tech.level[Level] = GPrefix.tech.level[Level] or {}
            GPrefix.tech.level[Level][prototype.name] = value
            for _, effect in pairs(prototype.effects or {}) do
                if effect.type == "unlock-recipe" then
                    GPrefix.tech.recipe[effect.recipe] = GPrefix.tech.recipe[effect.recipe] or {}
                    GPrefix.tech.recipe[effect.recipe][prototype.name] = value
                    local Recipe = data.raw.recipe[effect.recipe]
                    if Recipe then Recipe.enable = false end
                end
            end
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

---------------------------------------------------------------------------------------------------
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Clasificar y guardar el prototipo
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local function extend(prototype)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Recipes
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        while true do
            if prototype.type ~= "recipe" then break end

            GMOD.recipes[prototype.name] = GMOD.recipes[prototype.name] or {}
            table.insert(GMOD.recipes[prototype.name], prototype)
            return
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Fluids
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        while true do
            if prototype.type ~= "fluid" then break end

            GMOD.fluids[prototype.name] = prototype
            return
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Items
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        while true do
            if not prototype.stack_size then break end

            GMOD.items[prototype.name] = prototype
            return
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Tiles
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        while true do
            if prototype.type ~= "tile" then break end
            local Item = GMOD.get_item_create(prototype, "place_as_tile")
            if not Item then break end

            GMOD.tiles[Item.name] = GMOD.tiles[Item.name] or {}
            table.insert(GMOD.tiles[Item.name], prototype)
            return
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Equipments
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        while true do
            if not prototype.shape then break end

            GMOD.equipments[prototype.name] = prototype
            return
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Entities
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        while true do
            if not prototype.max_health then break end
            if GMOD.is_hidde(prototype) then break end
            local Item = GMOD.get_item_create(prototype, "place_result")
            if not Item then break end

            GMOD.entities[Item.name] = prototype
            return
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Guardar el nuevo prototipo
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for _, arg in pairs(Prototypes) do
        data:extend({ arg })
        extend(arg)
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------
>>>>>>> nuevo/main





<<<<<<< HEAD
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
    --- GPrefix.items
    --- GPrefix.tiles
    --- GPrefix.fluids
    --- GPrefix.recipes
    --- GPrefix.entities
    --- GPrefix.equipments
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
=======
---------------------------------------------------------------------------
---[ Contenedor de este archivo ]---
---------------------------------------------------------------------------

local This_MOD = GMOD.get_id_and_name()
if not This_MOD then return end
GMOD[This_MOD.id] = This_MOD

---------------------------------------------------------------------------





---------------------------------------------------------------------------
---[ Inicio del MOD ]---
---------------------------------------------------------------------------

function This_MOD.start()
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Darle formato a las propiedades
    This_MOD.format_minable()
    This_MOD.format_icons()

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Clasificar la información de data.raw
    --- GMOD.items
    --- GMOD.tiles
    --- GMOD.fluids
    --- GMOD.recipes
    --- GMOD.entities
    --- GMOD.equipments
    This_MOD.filter_data()

    --- Clasificar la información de settings.startup
    --- GMOD.Setting
    This_MOD.load_setting()

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Cambiar los orders de los elementos
>>>>>>> nuevo/main
    This_MOD.change_orders()

    --- Establecer traducción en todos los elementos
    This_MOD.set_localised()

<<<<<<< HEAD
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
---- GPrefix.items
---- GPrefix.tiles
---- GPrefix.fluids
---- GPrefix.recipes
---- GPrefix.entities
---- GPrefix.equipments
function This_MOD.filter_data()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Contenedores finales
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    GPrefix.items = {}
    GPrefix.tiles = {}
    GPrefix.fluids = {}
    GPrefix.recipes = {}
    GPrefix.entities = {}
    GPrefix.equipments = {}

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

    --- Agregar la receta a GPrefix.recipes
    local function add_recipe(recipe)
        --- Receta oculta
        if is_hidde(recipe) then return end

        --- No es usable
        if recipe.parameter then return end
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------





---------------------------------------------------------------------------
---[ Funciones locales ]---
---------------------------------------------------------------------------

--- Darle formato a la propiedad "minable"
function This_MOD.format_minable()
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Hacer el cambio
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local function format(element)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Validar
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        if not element.minable then return end
        if not element.minable.result then return end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Dar el formato deseado
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        element.minable.results = { {
            type = "item",
            name = element.minable.result,
            amount = element.minable.count or 1
        } }

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Borrar los valores reubicados
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        element.minable.result = nil
        element.minable.count = nil

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Hacer el cambio
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for _, elements in pairs(data.raw) do
        for _, element in pairs(elements) do
            format(element)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Darle formato a la propiedad "icons"
function This_MOD.format_icons()
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Hacer el cambio
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    local function format(element)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Validar
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        if element.icons then return end
        if not element.icon then return end
        if type(element.icon) ~= "string" then return end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Dar el formato deseado
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        element.icons = { {
            icon = element.icon,
            icon_size = element.icon_size ~= 64 and element.icon_size or nil
        } }

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        --- Borrar los valores reubicados
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        element.icon_size = nil
        element.icon = nil

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Hacer el cambio
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for _, elements in pairs(data.raw) do
        for _, element in pairs(elements) do
            format(element)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------

--- Clasificar la información de data.raw
--- GMOD.items
--- GMOD.tiles
--- GMOD.fluids
--- GMOD.recipes
--- GMOD.entities
--- GMOD.equipments
function This_MOD.filter_data()
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Contenedores finales
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    GMOD.entities = {}
    GMOD.equipments = {}
    GMOD.fluids = {}
    GMOD.items = {}
    GMOD.recipes = {}
    GMOD.tiles = {}

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Agrega las Recetas, Suelos y Objetos
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Agregar la receta a GMOD.recipes
    local function add_recipe(recipe)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Vaidación
        if GMOD.is_hidde(recipe) then return end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

        --- Recorrer los resultados
        for _, result in pairs(recipe.results or {}) do
            --- Espacio a usar
<<<<<<< HEAD
            local Recipes = GPrefix.recipes[result.name] or {}
            GPrefix.recipes[result.name] = Recipes

            --- Agregar la receta si no se encuentra
            local Found = GPrefix.get_table(Recipes, "name", recipe.name)
            if not Found then table.insert(Recipes, recipe) end

            --- Guardar referencia del resultado
            if result.type == "item" then GPrefix.items[result.name] = true end
            if result.type == "fluid" then GPrefix.fluids[result.name] = true end
        end

        --- Guardar referencia de los ingredientes
        for _, ingredient in pairs(recipe.ingredients or {}) do
            if ingredient.type == "item" then GPrefix.items[ingredient.name] = true end
            if ingredient.type == "fluid" then GPrefix.fluids[ingredient.name] = true end
        end
    end

    --- Agregar el suelo a GPrefix.tiles
    local function add_tile(tile)
        --- El suelo no se puede quitar
        if not tile.minable then return end
        if not tile.minable.results then return end

        --- Verificar cada resultado
        for _, result in pairs(tile.minable.results) do
            --- El suelo no tiene receta
            if not GPrefix.items[result.name] then
                GPrefix.items[result.name] = true
            end

            --- Espacio a usar
            local Titles = GPrefix.tiles[result.name] or {}
            GPrefix.tiles[result.name] = Titles

            --- Agregar el suelo si no se encuentra
            local Found = GPrefix.get_table(Titles, "name", tile.name)
            if not Found then table.insert(Titles, tile) end
        end
    end

    --- Agregar el item a GPrefix.items
    local function add_item(item)
        --- Objeto no apilable
        if not item.stack_size then return end

        --- Objeto oculto
        if is_hidde(item) then return end

        --- No es usable
        if item.parameter then return end

        --- Guardar objeto
        GPrefix.items[item.name] = item

        --- Guardar suelo de no estarlo
        if item.place_as_tile and not GPrefix.tiles[item.name] then
            local tile = data.raw.tile[item.place_as_tile.result]
            GPrefix.tiles[item.name] = GPrefix.tiles[item.name] or {}
            table.insert(GPrefix.tiles[item.name], tile)
        end

        --- Valores a evaluar
        local Values = {}
        Values.entities = "place_result"
        Values.equipments = "place_as_equipment_result"

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
=======
            local Recipes = GMOD.recipes[result.name] or {}
            GMOD.recipes[result.name] = Recipes

            --- Agregar la receta si no se encuentra
            local Found = GMOD.get_key(Recipes, recipe)
            if not Found then table.insert(Recipes, recipe) end

            --- Guardar referencia del resultado
            if result.type == "item" then GMOD.items[result.name] = true end
            if result.type == "fluid" then GMOD.fluids[result.name] = true end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Guardar referencia de los ingredientes
        for _, ingredient in pairs(recipe.ingredients or {}) do
            if ingredient.type == "item" then GMOD.items[ingredient.name] = true end
            if ingredient.type == "fluid" then GMOD.fluids[ingredient.name] = true end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- Agregar el suelo a GMOD.tiles
    local function add_tile(tile)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Validación
        if not tile.minable then return end
        if not tile.minable.results then return end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Verificar cada resultado
        for _, result in pairs(tile.minable.results) do
            --- El suelo no tiene receta
            if not GMOD.items[result.name] then
                GMOD.items[result.name] = true
            end

            --- Espacio a usar
            local Titles = GMOD.tiles[result.name] or {}
            GMOD.tiles[result.name] = Titles

            --- Agregar el suelo si no se encuentra
            local Found = GMOD.get_key(Titles, tile)
            if not Found then table.insert(Titles, tile) end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- Agregar el item a GMOD.items
    local function add_item(item)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Validación
        if not item.stack_size then return end
        if GMOD.is_hidde(item) then return end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Guardar objeto
        GMOD.items[item.name] = item

        --- Guardar suelo de no estarlo
        if item.place_as_tile and not GMOD.tiles[item.name] then
            local Tile = data.raw.tile[item.place_as_tile.result]
            GMOD.tiles[item.name] = GMOD.tiles[item.name] or {}
            table.insert(GMOD.tiles[item.name], Tile)
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Validar las propiedades
        for index, property in pairs({
            entities = "place_result",
            equipments = "place_as_equipment_result"
        }) do
            if item[property] then
                --- Objeto de igual nombre que el resultado
                if item[property] == item.name then
                    GMOD[index][item.name] = true
                end

                --- Objeto de distinto nombre que el resultado
                if item[property] ~= item.name then
                    GMOD[index][item[property]] = true
                    GMOD[index][item.name] = item[property]
                end
            end
        end

        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Cargar las Recetas, Suelos, Fluidos y Objetos
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Recorrer las recetas
    for _, recipe in pairs(data.raw.recipe) do
        add_recipe(recipe)
    end

    --- Cargar los fluidos
<<<<<<< HEAD
    for name, _ in pairs(GPrefix.fluids) do
        local Fluid = data.raw.fluid[name]
        if Fluid then GPrefix.fluids[name] = Fluid end
=======
    for name, _ in pairs(GMOD.fluids) do
        local Fluid = data.raw.fluid[name]
        if Fluid then GMOD.fluids[name] = Fluid end
>>>>>>> nuevo/main
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

<<<<<<< HEAD
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
    Values["entities"] = GPrefix.entities
    Values["equipments"] = GPrefix.equipments

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Recorrer los elementos
    for Key, Value in pairs(Values) do
        --- Cargar de forma directa
        for name, value in pairs(Value) do
            if not GPrefix.is_string(value) then
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Buscar y cargar las Entidades y los Equipos
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Evitar estos tipos
    local Ignore_types = {
        tile = true,
        fluid = true,
        recipe = true
    }

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Recorrer los elementos
    for _, elements in pairs({ GMOD.entities, GMOD.equipments }) do
        --- Cargar de forma directa
        for name, value in pairs(elements) do
            if type(value) == "boolean" then
>>>>>>> nuevo/main
                for _, element in pairs(data.raw) do
                    --- Buscar la entidad
                    element = element[name]

                    --- El ciclo es solo para saltar
                    --- elementos no deseados
                    repeat
<<<<<<< HEAD
                        --- Coasa evitar
                        if not element then break end
                        if GPrefix.get_key(ignore_types, element.type) then break end
                        if Key == "entities" then
                            if not element.minable then break end
                            if not element.minable.results then break end
                        end
                        if Key == "equipments" then
=======
                        --- Validación
                        if not element then break end
                        if Ignore_types[element.type] then break end

                        --- Entidades
                        if elements == GMOD.entities then
                            if GMOD.is_hidde(element) then break end
                            if not element.max_health then break end
                        end

                        --- Equipos
                        if elements == GMOD.equipments then
>>>>>>> nuevo/main
                            if not element.shape then break end
                            if not element.sprite then break end
                        end

<<<<<<< HEAD
                        --- Guardar entidad
                        Value[name] = element
=======
                        --- Guardar
                        elements[name] = element
>>>>>>> nuevo/main
                    until true
                end
            end
        end

<<<<<<< HEAD
        --- Cargar las entidades de forma indirecta
        for name, value in pairs(Value) do
            if GPrefix.is_string(value) then
                Value[name] = Value[value]
=======
        --- Cargar de forma indirecta
        for name, value in pairs(elements) do
            if type(value) == "string" then
                elements[name] = elements[value]
>>>>>>> nuevo/main
            end
        end
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Eliminar los elementos que no se pudieron cargar
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Eliminar los elementos que no se pudieron cargar
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Variable contenedora
    local Info = ""
    local Delete = {}
<<<<<<< HEAD
    local Array = {}

    --- Valores a evaluar
    Array.Item = GPrefix.items
    Array.Tile = GPrefix.tiles
    Array.Fluid = GPrefix.fluids
    Array.Entity = GPrefix.entities
    Array.Equipment = GPrefix.equipments

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    local Array = {
        Item = GMOD.items,
        Tile = GMOD.tiles,
        Fluid = GMOD.fluids,
        Entity = GMOD.entities,
        Equipment = GMOD.equipments
    }

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Identificar valores vacios
    for iKey, elemnts in pairs(Array) do
        for jKey, elemnt in pairs(elemnts) do
<<<<<<< HEAD
            if GPrefix.is_boolean(elemnt) then
                Info = Info .. "\n\t\t"
                Info = Info .. iKey .. " not found or hidden: " .. jKey
                table.insert(Delete, jKey)
=======
            if type(elemnt) == "boolean" then
                Info = Info .. "\n\t\t"
                Info = Info .. iKey .. " not found or hidden: " .. jKey
                table.insert(Delete, { elemnts, jKey })
>>>>>>> nuevo/main
            end
        end
    end

    --- Eliminar valores vacios
<<<<<<< HEAD
    for _, list in pairs(Array) do
        for _, value in pairs(Delete) do
            list[value] = nil
        end
=======
    for _, value in pairs(Delete) do
        value[1][value[2]] = nil
>>>>>>> nuevo/main
    end

    --- Imprimir un informe de lo eliminados
    if #Delete >= 1 then log(Info) end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Clasificar la información de settings.startup
---- GPrefix.Setting
function This_MOD.load_setting()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inicializar el contenedor
    GPrefix.setting = {}

    --- Recorrer las opciones de configuración
    for key, value in pairs(settings.startup) do
        --- Separar los datos esperados
        local id, name = GPrefix.get_id_and_name(key)

        --- Validar los datos obtenidos
        if id and name then
            GPrefix.setting[id] = GPrefix.setting[id] or {}
            GPrefix.setting[id][name] = value.value
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
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Clasificar la información de settings.startup
--- GMOD.Setting
function This_MOD.load_setting()
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Validación
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if GMOD.setting then return end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Cargar las opciones de configuración
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Inicializar el contenedor
    GMOD.setting = {}

    --- Recorrer las opciones de configuración
    for option, value in pairs(settings.startup) do
        --- Separar los datos esperados
        local That_MOD = GMOD.get_id_and_name(option)

        --- Validar los datos obtenidos
        if That_MOD then
            GMOD.setting[That_MOD.id] = GMOD.setting[That_MOD.id] or {}
            GMOD.setting[That_MOD.id][That_MOD.name] = value.value
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------

--- Cambiar los orders de los elementos
function This_MOD.change_orders()
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Inicializar las vaiables
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    local Orders = {}
    local Source = {}
    local N = 0

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Grupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Grupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

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
<<<<<<< HEAD
    N = GPrefix.get_length(data.raw["item-group"])
    N = GPrefix.digit_count(N) + 1
=======
    N = GMOD.get_length(data.raw["item-group"])
    N = GMOD.digit_count(N) + 1
>>>>>>> nuevo/main

    --- Ordenear los orders
    table.sort(Orders)

    --- Cambiar el order de los subgrupos
    for iKey, order in pairs(Orders) do
        for jKey, element in pairs(Source) do
            if element.order == order then
<<<<<<< HEAD
                element.order = GPrefix.pad_left_zeros(N, iKey) .. "0"
=======
                element.order = GMOD.pad_left_zeros(N, iKey) .. "0"
>>>>>>> nuevo/main
                table.remove(Source, jKey)
                break
            end
        end
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Subgrupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Subgrupos
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Inicializar las vaiables
    Orders = {}
    Source = {}

    --- Agrupar los subgroups
<<<<<<< HEAD
    for _, element in pairs(GPrefix.subgroups) do
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        Source[element.group] = Source[element.group] or {}
        table.insert(Source[element.group], element)
        --- --- --- --- --- --- --- --- --- --- --- --- ---
        Orders[element.group] = Orders[element.group] or {}
        table.insert(Orders[element.group], element.order or element.name)
        --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    for _, element in pairs(GMOD.subgroups) do
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        Source[element.group] = Source[element.group] or {}
        table.insert(Source[element.group], element)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        Orders[element.group] = Orders[element.group] or {}
        table.insert(Orders[element.group], element.order or element.name)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main
    end

    --- Cambiar el order de los subgrupos
    for subgroup, orders in pairs(Orders) do
        --- Ordenear los orders
        table.sort(orders)

        --- Cantidad de afectados
<<<<<<< HEAD
        N = GPrefix.get_length(orders)
        N = GPrefix.digit_count(N) + 1
=======
        N = GMOD.get_length(orders)
        N = GMOD.digit_count(N) + 1
>>>>>>> nuevo/main

        --- Remplazar los orders
        for iKey, order in pairs(orders) do
            for jKey, element in pairs(Source[subgroup]) do
                if element.order == order then
<<<<<<< HEAD
                    element.order = GPrefix.pad_left_zeros(N, iKey) .. "0"
=======
                    element.order = GMOD.pad_left_zeros(N, iKey) .. "0"
>>>>>>> nuevo/main
                    table.remove(Source[subgroup], jKey)
                    break
                end
            end
        end
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Establecer subgrupos por defecto
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Establecer subgrupos por defecto
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Subgrupos por defecto
    local Empty = {
        type = "item-subgroup",
        name = "subgroup-empty",
        group = "other",
        order = "999"
    }

    --- Crear el Subgrupos por defecto
    data:extend({ Empty })

<<<<<<< HEAD
    --- Inicializar las vaiables
    Orders = {}
    Source = {}
    Source.items = GPrefix.items
    Source.fluids = GPrefix.fluids
    Source.recipes = GPrefix.recipes

    --- Objetos, recetas y fluidos
    for Key, Values in pairs(Source) do
=======
    --- Objetos, recetas y fluidos
    for Key, Values in pairs({
        items = GMOD.items,
        fluids = GMOD.fluids,
        recipes = GMOD.recipes
    }) do
>>>>>>> nuevo/main
        if Key ~= "recipes" then Values = { Values } end
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

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Objetos, recetas y demás
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Objetos, recetas y demás
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

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

<<<<<<< HEAD
                --- Agrupar
                Source[element.subgroup] = Source[element.subgroup] or {}
                table.insert(Source[element.subgroup], element)

=======
                --- Elementos a agrupar
                Source[element.subgroup] = Source[element.subgroup] or {}
                table.insert(Source[element.subgroup], element)

                --- Elementos a ordenar
>>>>>>> nuevo/main
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
<<<<<<< HEAD
        N = GPrefix.get_length(orders)
        N = GPrefix.digit_count(N) + 1
=======
        N = GMOD.get_length(orders)
        N = GMOD.digit_count(N) + 1
>>>>>>> nuevo/main

        --- Remplazar los orders
        for iKey, order in pairs(orders) do
            for jKey, element in pairs(Source[subgroup]) do
                if element.order == order then
<<<<<<< HEAD
                    element.order = GPrefix.pad_left_zeros(N, iKey) .. "0"
=======
                    element.order = GMOD.pad_left_zeros(N, iKey) .. "0"
>>>>>>> nuevo/main
                    table.remove(Source[subgroup], jKey)
                    break
                end
            end
        end
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Agrupar las recetas
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for name, recipes in pairs(GPrefix.recipes) do
        local item = GPrefix.items[name]
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Agrupar las recetas
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for name, recipes in pairs(GMOD.recipes) do
        local item = GMOD.items[name]
>>>>>>> nuevo/main
        if item then
            item.order = item.order or "0"
            local order = tonumber(item.order) or 0
            for _, recipe in pairs(recipes) do
                if #recipe.results == 1 then
                    recipe.subgroup = item.subgroup
<<<<<<< HEAD
                    recipe.order = GPrefix.pad_left_zeros(#item.order, order)
=======
                    recipe.order = GMOD.pad_left_zeros(#item.order, order)
>>>>>>> nuevo/main
                    order = order + 1
                end
            end
        end
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main
end

--- Establecer traducción en todos los elementos
function This_MOD.set_localised()
<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Funciones a usar
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Establece el nombre de la receta
    local function set_localised(name, recipe, field)
        --- Valores a usar
        local Field = "localised_" .. field
        local fluid = GPrefix.fluids[name]
        local item = GPrefix.items[name]
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Traducir estas secciones
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Establecer la traducción
    for name, subgroup in pairs({
        tile = GMOD.tiles,
        fluid = GMOD.fluids,
        entity = GMOD.entities,
        equipment = GMOD.equipments
    }) do
        if name ~= "tile" then subgroup = { subgroup } end
        for _, elements in pairs(subgroup) do
            for _, element in pairs(elements) do
                if element.localised_name then
                    if type(element.localised_name) == "table" and element.localised_name[1] ~= "" then
                        element.localised_name = { "", element.localised_name }
                    end
                end
                if not element.localised_name then
                    element.localised_name = { "", { name .. "-name." .. element.name } }
                end
                if not element.localised_description then
                    element.localised_description = { "", { name .. "-description." .. element.name } }
                end
            end
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Funciones a usar
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Establece el nombre de la receta
    local function set_localised(name, recipe, field)
        --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        --- Valores a usar
        local Field = "localised_" .. field
        local fluid = GMOD.fluids[name]
        local item = GMOD.items[name]
>>>>>>> nuevo/main

        --- El resultado es un objeto
        if item then
            --- Nombre del objeto por defecto
            recipe[Field] = item[Field]

            --- Traducción para una entidad
            if item.place_result then
<<<<<<< HEAD
                local Entiy = GPrefix.entities[item.place_result]
=======
                local Entiy = GMOD.entities[item.place_result]
>>>>>>> nuevo/main
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
<<<<<<< HEAD
                local equipment = GPrefix.equipments[result]
=======
                local equipment = GMOD.equipments[result]
>>>>>>> nuevo/main
                if equipment then
                    item[Field] = equipment[Field]
                    recipe[Field] = equipment[Field]
                end
            end
<<<<<<< HEAD
=======

            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main
        end

        --- El resultado es un liquido
        if fluid then recipe[Field] = fluid[Field] end
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Traducir estas secciones
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Protipos a corregir
    local Array = {}
    Array.tile = GPrefix.tiles
    Array.fluid = GPrefix.fluids
    Array.entity = GPrefix.entities
    Array.equipment = GPrefix.equipments

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
    for _, item in pairs(GPrefix.items) do
        if item.localised_name then
            if GPrefix.is_table(item.localised_name) and item.localised_name[1] ~= "" then
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Traducción de los objetos y las recetas
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Establecer la traducción de los objetos
    for _, item in pairs(GMOD.items) do
        if item.localised_name then
            if type(item.localised_name) == "table" and item.localised_name[1] ~= "" then
>>>>>>> nuevo/main
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
<<<<<<< HEAD
    for _, recipes in pairs(GPrefix.recipes) do
        if recipes.localised_name then
            if GPrefix.is_table(recipes.localised_name) and recipes.localised_name[1] ~= "" then
=======
    for _, recipes in pairs(GMOD.recipes) do
        if recipes.localised_name then
            if type(recipes.localised_name) == "table" and recipes.localised_name[1] ~= "" then
>>>>>>> nuevo/main
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

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    ---> Traducción de las tecnologias
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Actualizar el apodo del nombre
    for _, tech in pairs(GPrefix.tech.raw) do
        --- Renombrar
        local Tech = tech.technology
        local Full_name = Tech.name
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Traducción de las tecnologias
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Actualizar el apodo del nombre
    for _, tech in pairs(data.raw.technology) do
        --- Renombrar
        local Full_name = tech.name
>>>>>>> nuevo/main

        --- Separar la información
        local Name, Level = Full_name:match("(.+)-(%d+)")
        if Level then Level = " " .. (Level or "") end
        if not Name then Name = Full_name end

        --- Corrección para las tecnologías infinitas
<<<<<<< HEAD
        if Tech.unit and Tech.unit.count_formula then
=======
        if tech.unit and tech.unit.count_formula then
>>>>>>> nuevo/main
            Level = nil
        end

        --- Construir el apodo
<<<<<<< HEAD
        if Tech.localised_name then
            if Tech.localised_name[1] ~= "" then
                Tech.localised_name = { "", Tech.localised_name }
            end
        else
            Tech.localised_name = { "", { "technology-name." .. Name }, Level }
        end
        Tech.localised_description = { "", { "technology-description." .. Name } }
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------
=======
        if tech.localised_name then
            if tech.localised_name[1] ~= "" then
                tech.localised_name = { "", tech.localised_name }
            end
        else
            tech.localised_name = { "", { "technology-name." .. Name }, Level }
        end
        tech.localised_description = { "", { "technology-description." .. Name } }
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------
>>>>>>> nuevo/main





<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> Ejecutar las funciones internas <---
---------------------------------------------------------------------------------------------------

--- Ejecutar las acciones propias de este archivo
This_MOD.start()

---------------------------------------------------------------------------------------------------
=======
---------------------------------------------------------------------------

--- Iniciar el MOD
This_MOD.start()

---------------------------------------------------------------------------
>>>>>>> nuevo/main
