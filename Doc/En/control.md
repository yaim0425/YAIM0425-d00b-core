# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.create_data(event, that_mod)`

Builds and returns a table with key data from the received event, centralizing useful information about entities, players, forces, and storage spaces (persistent and non-persistent). It is designed to facilitate interoperability between multiple MODs.

### 📌 Parameters
- `event`: Event table provided by Factorio.
- `that_mod`: Reference to the calling mod, used to isolate its data space.

### 📦 Returns `Data`

**Basic values:**
- `Event`: Direct reference to the event.
- `Entity`: The affected or created entity, if any.
- `Player`: The player, if any.

- `Force_player`: The force the `Player` belongs to.
- `Force_entity`: The force the `Entity` belongs to.
- `Force`: Exists if `Force_player` and `Force_entity` are the same, or if only `Player` or only `Entity` exists. The presence of this variable removes `Force_player` and `Force_entity`.

**The following are values stored with the game save:**
- `gPrefix`: Contains all saved data for all mods under `yaim0425`, indexed by `that_mod.index`.
- `gMOD`: Container for all saved data specific to the current mod. Includes `gForces` and `gPlayers`.
- `gForces`: Container for each force used by the mod, indexed by `Force.index`.
- `gForce`: Data for the current force, if it exists.
- `gPlayers`: Container for each player that has used the mod, indexed by `Player.index`.
- `gPlayer`: Saved data for the current player.

**The following are values *not* stored with the game save:**
- `GForces`: Container for each force used by the mod, indexed by `Force.index`.
- `GForce`: Data for the current force, if it exists.
- `GPlayers`: Container for each player that has used the mod, indexed by `Player.index`.
- `GPlayer`: Non-persistent data for the current player. Contains `GUI`.
- `GUI`: Non-persistent space for player-specific graphical interfaces.

### 🔍 Usage Example

```lua
local Data = GPrefix.create_data(event, my_mod)

-- Access the player
if Data.Player then
    game.print("Player: " .. Data.Player.name)
end

-- Access the mod's persistent space
Data.gMOD.my_variable = true
```