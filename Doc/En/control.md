# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.create_data(event, that_mod)`

Builds a consolidated data object from an event. This structure simplifies access to entities, players, forces, and both persistent and runtime-only storage.

### 📌 Parameters
- `event`: `table` — The event received from `script.on_event`
- `that_mod`: `table` — Info from the current mod (e.g., `id`, `Forces`, `Players`, etc.)

### 🔁 Returns
- `table` — A `Data` object that centralizes all relevant runtime info for the event.

---

### 🧱 Contents of the `Data` object

#### 🔸 Core event data
- `Data.Event`: Copy of the original event.
- `Data.Entity`: Affected entity (`event.entity` or `event.created_entity`).
- `Data.Player`: Player associated with the event (`game.get_player(event.player_index)`).
- `Data.Force`: Main force involved (from player or entity).

#### 🔸 Additional forces
- `Data.Force_player`: Player’s force.
- `Data.Force_entity`: Entity’s force.

If both match, `Data.Force` is consolidated.

---

### 💾 Storage objects (persistent and temporary)

#### 🔸 Persistent storage
- `Data.gPrefix`: Global mod-wide table.
- `Data.gMOD`: Mod-specific storage (`gPrefix[that_mod.id]`).
- `Data.gForces`: Table of forces (by index).
- `Data.gForce`: Current force's persistent space.
- `Data.gPlayers`: Table of players (by index).
- `Data.gPlayer`: Current player's persistent space.

#### 🔸 Runtime-only storage
- `Data.GForces`: Runtime force data (`that_mod.Forces`).
- `Data.GForce`: Current force’s runtime space.
- `Data.GPlayers`: Runtime player data (`that_mod.Players`).
- `Data.GPlayer`: Current player's runtime space.
- `Data.GUI`: Runtime GUI space for the player.

---

### 🔍 Example

```lua
script.on_event(defines.events.on_built_entity, function(event)
  local Data = GPrefix.create_data(event, This_MOD)
  if Data.Entity then
    log("Entity placed by player: " .. Data.Entity.name)
  end
end)
```

## 📘 Available Functions

- [`Basic functions`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/En/Basic%20functions.md)  
- [`Advanced functions`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/En/Advanced%20functions.md)  
- [`README`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/README.md)
- [`data-final-fixes`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/En/data-final-fixes.md)
