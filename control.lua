<<<<<<< HEAD
---------------------------------------------------------------------------------------------------
---> control.lua <---
---------------------------------------------------------------------------------------------------

--- Validar si se cargó antes
if GPrefix and GPrefix.name then return end

---------------------------------------------------------------------------------------------------
=======
---------------------------------------------------------------------------
---[ control.lua ]---
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
=======

---------------------------------------------------------------------------
---[ Funciones globales ]---
---------------------------------------------------------------------------
>>>>>>> nuevo/main

--- Crea un consolidado de variables para usar en tiempo de ejecuión
--- @param event table
--- @param that_mod table
--- @return table
<<<<<<< HEAD
function GPrefix.create_data(event, that_mod)
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
function GMOD.create_data(event, that_mod)
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Contenedor de datos
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Variable de salida
    local Data = { Event = event }

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Identificar la entidad
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Entidad en el evento
    if event.entity and event.entity.valid then
        Data.Entity = event.entity
    elseif event.created_entity and event.created_entity.valid then
        Data.Entity = event.created_entity
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Identificar al jugador
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Identificar al jugador
    if event.Player then
        Data.Player = event.Player
    end

>>>>>>> nuevo/main
    if event.player_index then
        Data.Player = game.get_player(event.player_index)
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Identificar los forces
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- El force está en el evento dado
    Data.Force = event.force or nil

    --- El force está en el jugador
<<<<<<< HEAD
    if Data.Player and not GPrefix.is_string(Data.Player.force) then
=======
    if Data.Player and type(Data.Player.force) ~= "string" then
>>>>>>> nuevo/main
        Data.Force = Data.Player.force
    end

    --- El force se debe buscar busca
<<<<<<< HEAD
    if Data.Player and GPrefix.is_string(Data.Player.force) then
        Data.Force = game.forces[Data.Player.force]
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    if Data.Player and type(Data.Player.force) == "string" then
        Data.Force = game.forces[Data.Player.force]
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Buscar y crear los forces
    for Key, Value in pairs({ player = Data.Player, entity = Data.Entity }) do
        --- Agregar prefijo
        Key = "Force_" .. Key

        --- Cargar el force de forma directa
<<<<<<< HEAD
        if not GPrefix.is_string(Value.force) then
=======
        if type(Value.force) ~= "string" then
>>>>>>> nuevo/main
            Data[Key] = Value.force
        end

        --- Cargar el force usando el nombre o id
<<<<<<< HEAD
        if GPrefix.is_string(Value.force) then
=======
        if type(Value.force) == "string" then
>>>>>>> nuevo/main
            Data[Key] = game.forces[Value.force]
        end
    end

    --- Reducir los forces a uno de ser posible
    if Data.Force_player and Data.Force_player == Data.Force_entity then
        Data.Force = Data.Force_entity
<<<<<<< HEAD
        Data.Force_entity = nil
        Data.Force_player = nil
    elseif not Data.Force_player and Data.Force_entity then
        Data.Force = Data.Force_entity
        Data.Force_entity = nil
    elseif Data.Force_player and not Data.Force_entity then
        Data.Force = Data.Force_player
        Data.Force_player = nil
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Espacio guardable para TODOS los MODs
    storage[GPrefix.name] = storage[GPrefix.name] or {}
    Data.gPrefix = storage[GPrefix.name]
=======
    elseif not Data.Force_player and Data.Force_entity then
        Data.Force = Data.Force_entity
    elseif Data.Force_player and not Data.Force_entity then
        Data.Force = Data.Force_player
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Crear el espacio guardable y NO guardable
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Espacio guardable para TODOS los MODs
    storage[GMOD.name] = storage[GMOD.name] or {}
    Data.gPrefix = storage[GMOD.name]
>>>>>>> nuevo/main

    --- Espacio guardable para este MOD
    Data.gPrefix[that_mod.id] = Data.gPrefix[that_mod.id] or {}
    Data.gMOD = Data.gPrefix[that_mod.id]

    --- Crear el espacio guardable para los forces
    Data.gMOD.Forces = Data.gMOD.Forces or {}
    Data.gForces = Data.gMOD.Forces

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Crear el espacio NO guardable para los forces
    that_mod.Forces = that_mod.Forces or {}
    Data.GForces = that_mod.Forces

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Crear el espacio para un forces
    for _, force in pairs({ Data.Force_player, Data.Force_entity, Data.Force }) do
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Crear el espacio NO guardable para los forces
    that_mod.forces = that_mod.forces or {}
    Data.GForces = that_mod.forces

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Crear el espacio para un forces
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for _, force in pairs({ Data.Force_entity, Data.Force_player, Data.Force }) do
>>>>>>> nuevo/main
        --- Espacio guardable
        Data.gForce = Data.gForces
        Data.gForce[force.index] = Data.gForce[force.index] or {}
        Data.gForce = Data.gForce[force.index]

        --- Espacio NO guardable
        Data.GForce = Data.GForces
        Data.GForce[force.index] = Data.GForce[force.index] or {}
        Data.GForce = Data.GForce[force.index]
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Espacio NO guardable para los jugadores
    that_mod.Players = that_mod.Players or {}
    Data.GPlayers = that_mod.Players

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Espacio para los jugadores
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Espacio NO guardable para los jugadores
    that_mod.players = that_mod.players or {}
    Data.GPlayers = that_mod.players

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Espacio guardable para los jugadores
    Data.gMOD.Players = Data.gMOD.Players or {}
    Data.gPlayers = Data.gMOD.Players

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- No se tiene un jugador
    if not Data.Player then return Data end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- No se tiene un jugador
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if not Data.Player then return Data end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Crear el espacio para un jugador
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Identificador del jugador
    local ID_Player = Data.Player.index

    --- Espacio NO guardable del jugador
    Data.GPlayers[ID_Player] = Data.GPlayers[ID_Player] or {}
    Data.GPlayer = Data.GPlayers[ID_Player]

<<<<<<< HEAD
    --- Espacio para el GUI
    Data.GPlayer.GUI = Data.GPlayer.GUI or {}
    Data.GUI = Data.GPlayer.GUI

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
>>>>>>> nuevo/main

    --- Espacio guardable del jugador
    Data.gPlayers[ID_Player] = Data.gPlayers[ID_Player] or {}
    Data.gPlayer = Data.gPlayers[ID_Player]

<<<<<<< HEAD
    --- Devolver el consolidado de los datos
    return Data

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------
=======
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Espacio para el GUI
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    Data.gPlayer.GUI = Data.gPlayer.GUI or {}
    Data.GUI = Data.gPlayer.GUI

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Devolver el consolidado de los datos
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    return Data

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

    --- Clasificar la información de data.raw
    --- Crearción de:
    --- GPrefix.Items
    --- GPrefix.Tiles
    --- GPrefix.Fluids
    --- GPrefix.Recipes
    --- GPrefix.Entities
    --- GPrefix.Equipments
    This_MOD.filter_data()

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------

--- Clasificar la información de data.raw
--- Crearción de:
--- GPrefix.items
--- GPrefix.tiles
--- GPrefix.fluids
--- GPrefix.recipes
--- GPrefix.entities
--- GPrefix.equipments
function This_MOD.filter_data()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Agregar el suelo a GPrefix.Tiles
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

    --- Clasificar la información de data.raw
    This_MOD.filter_data()

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------





---------------------------------------------------------------------------
---[ Funciones locales ]---
---------------------------------------------------------------------------

--- Crearción de:
--- GMOD.items
--- GMOD.tiles
--- GMOD.fluids
--- GMOD.recipes
--- GMOD.entities
--- GMOD.equipments
function This_MOD.filter_data()
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Agregar el suelo a GMOD.Tiles
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

>>>>>>> nuevo/main
    local function addTitle(tile)
        local results = tile.mineable_properties.products
        if not results then return end

        for _, result in pairs(results) do
<<<<<<< HEAD
            GPrefix.tiles[result.name] = GPrefix.tiles[result.name] or {}
            table.insert(GPrefix.tiles[result.name], tile)
        end
    end

    --- Agregar la receta a GPrefix.recipes
=======
            GMOD.tiles[result.name] = GMOD.tiles[result.name] or {}
            table.insert(GMOD.tiles[result.name], tile)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    --- Agregar la receta a GMOD.recipes
    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

>>>>>>> nuevo/main
    local function addRecipe(recipe)
        local results = recipe.products
        if not results then return end

        for _, result in pairs(results) do
<<<<<<< HEAD
            GPrefix.recipes[result.name] = GPrefix.tiles[result.name] or {}
            table.insert(GPrefix.recipes[result.name], recipe)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---



    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Renombrar las variables
    GPrefix.items = prototypes.item
    GPrefix.fluids = prototypes.fluid
    GPrefix.entities = prototypes.entity
    GPrefix.equipments = prototypes.equipment

    --- Agrupar los suelos
    GPrefix.tiles = {}
=======
            GMOD.recipes[result.name] = GMOD.tiles[result.name] or {}
            table.insert(GMOD.recipes[result.name], recipe)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---





    --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Renombrar las variables
    GMOD.items = prototypes.item
    GMOD.fluids = prototypes.fluid
    GMOD.entities = prototypes.entity
    GMOD.equipments = prototypes.equipment

    --- Agrupar los suelos
    GMOD.tiles = {}
>>>>>>> nuevo/main
    for _, tile in pairs(prototypes.tile) do
        addTitle(tile)
    end

    --- Agrupar las recetas
<<<<<<< HEAD
    GPrefix.recipes = {}
=======
    GMOD.recipes = {}
>>>>>>> nuevo/main
    for _, recipe in pairs(prototypes.recipe) do
        addRecipe(recipe)
    end

<<<<<<< HEAD
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------
=======
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
---[ Iniciar el MOD ]---
---------------------------------------------------------------------------

This_MOD.start()

---------------------------------------------------------------------------
>>>>>>> nuevo/main
