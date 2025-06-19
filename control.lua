---------------------------------------------------------------------------------------------------
--> control.lua <--
---------------------------------------------------------------------------------------------------

--- --- --- --- --- --- --- --- --- --- --- --- --- ---
---> Cargar las funciones y constantes
--- --- --- --- --- --- --- --- --- --- --- --- --- ---

require("__CONSTANT__")
require("__FUNCTION__")
require("util")

---------------------------------------------------------------------------------------------------
---> Dar el formato deseado a la información <---
---------------------------------------------------------------------------------------------------

--- Contenedor de funciones y datos usados
--- unicamente en este archivo
local ThisMOD = {}

--- --- --- --- --- --- --- --- --- --- --- --- --- ---

--- Procesar los datos
function ThisMOD.control()
    --- Clasificar la información de data.raw
    ThisMOD.load_data()
end

--- Clasificar la información de data.raw
function ThisMOD.load_data()
    --- Agregar el suelo a GPrefix.Tiles
    local function addTitle(tile)
        local results = tile.mineable_properties.products
        if not results then return end

        for _, result in pairs(results) do
            GPrefix.Tiles[result.name] = GPrefix.Tiles[result.name] or {}
            table.insert(GPrefix.Tiles[result.name], tile)
        end
    end

    --- Agregar la receta a GPrefix.Recipes
    local function addRecipe(recipe)
        local results = recipe.products
        if not results then return end

        for _, result in pairs(results) do
            GPrefix.Recipes[result.name] = GPrefix.Tiles[result.name] or {}
            table.insert(GPrefix.Recipes[result.name], recipe)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Renombrar las variables
    GPrefix.Items = prototypes.item
    GPrefix.Fluids = prototypes.fluid
    GPrefix.Entities = prototypes.entity
    GPrefix.Equipments = prototypes.equipment

    --- Agrupar los suelos
    GPrefix.Tiles = {}
    for _, tile in pairs(prototypes.tile) do
        addTitle(tile)
    end

    --- Agrupar las recetas
    GPrefix.Recipes = {}
    for _, recipe in pairs(prototypes.recipe) do
        addRecipe(recipe)
    end
end

--- Crea un consolidado de variables para usar en tiempo de ejecuión
--- @param Event table
--- @param thisMOD table
--- @return table
function GPrefix.create_data(Event, thisMOD)
    --- Contenedor de variable
    local Temporal = {}

    --- Variable de salida
    local Data = {}
    Data.Event = Event
    Data.Temporal = {}

    --- Identificar al jugador
    Data.Player = Event.player
    if Event.player_index then Data.Player = game.get_player(Event.player_index) end

    --- El grupo al cual pertenece el jugador está en el evento dado
    Data.Force = Event.force or nil

    --- El grupo al cual pertenece el jugador está en el jugador
    if Data.Player and not GPrefix.is_string(Data.Player.force) then
        Data.Force = Data.Player.force
    end

    --- El grupo al cual pertenece el jugador se debe buscar busca
    if Data.Player and GPrefix.is_string(Data.Player.force) then
        Data.Force = game.forces[Data.Player.force]
    end

    --- Espacio guardable es para TODOS los MODs
    storage[GPrefix.Prefix] = storage[GPrefix.Prefix] or {}
    Data.gPrefix = storage[GPrefix.Prefix]

    --- Espacio guardable para este MOD
    Data.gPrefix[thisMOD.name] = Data.gPrefix[thisMOD.name] or {}
    Data.gMOD = Data.gPrefix[thisMOD.name]

    --- Crear el espacio para los forces
    Data.gMOD.Forces = Data.gMOD.Forces or {}
    Data.gForces = Data.gMOD.Forces

    thisMOD.Forces = thisMOD.Forces or {}
    Data.GForces = thisMOD.Forces

    --- Crear el espacio para un forces
    if not Data.Force then Data.Force = {} end
    local ForceID = Data.Force.index
    if not ForceID then goto JumpForce end

    Data.gForce = Data.gForces
    Data.gForce[ForceID] = Data.gForce[ForceID] or {}
    Data.gForce = Data.gForce[ForceID]

    Data.GForce = Data.GForces
    Data.GForce[ForceID] = Data.GForce[ForceID] or {}
    Data.GForce = Data.GForce[ForceID]

    --- Receptor del salto
    :: JumpForce ::

    --- No se tiene un jugador
    if not Data.Player then return Data end

    --- Espacio no guardable
    thisMOD.Players = thisMOD.Players or {}
    Temporal.Players = thisMOD.Players

    --- Espacio no guardable del jugador
    local PlayerID = Data.Player.index
    Temporal.Players[PlayerID] = Temporal.Players[PlayerID] or {}
    Data.GPlayer = Temporal.Players[PlayerID]

    --- Espacio para el GUI
    Data.GPlayer.GUI = Data.GPlayer.GUI or {}
    Data.GUI = Data.GPlayer.GUI

    --- Espacio guardable para el jugador
    Data.gMOD.Players = Data.gMOD.Players or {}
    Temporal.Players = Data.gMOD.Players

    Temporal.Players[PlayerID] = Temporal.Players[PlayerID] or {}
    Data.gPlayer = Temporal.Players[PlayerID]

    --- Devolver el consolidado de los datos
    return Data
end

--- --- --- --- --- --- --- --- --- --- --- --- --- ---

--- Dar el formato deseado a la información
ThisMOD.control()

---------------------------------------------------------------------------------------------------
