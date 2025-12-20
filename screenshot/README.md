# YAIM0425 d00b Core – API Reference

---

> 📘 This document describes the **publicly usable functions** provided by **YAIM0425 d00b Core**.
> It is intended for **MOD authors using YAIM0425 mods**, not for internal implementation details.
>
> Examples are written in **Lua (Factorio MOD environment)**.

---

## 🔹 Global Container: `GMOD`

All functions are exposed through the global table:

```lua
GMOD
```

This table is created automatically when the core is loaded and is shared by all YAIM0425 MODs.

---

## 🧩 Identification & MOD Info

### `GMOD.get_id_and_name([name])`

Returns identification information for a MOD or prototype name.

#### 📥 Input

* `name` *(string, optional)* – Prototype or MOD name. If omitted, returns info for the current MOD.

#### 📤 Output

* `table | nil`

Returned table contains:

* `id` → short internal ID of the MOD
* `name` → MOD name
* `prefix` → prefix used by YAIM0425
* `ids` → concatenated ID string

#### 🧪 Example

```lua
local info = GMOD.get_id_and_name()
log(info.id)
```

---

## 📦 Data & Prototype Utilities

### `GMOD.copy(value)`

Creates a **deep copy** of a table or value.

#### 📥 Input

* `value` *(any)* – Table or primitive value

#### 📤 Output

* `copy` *(same type as input)*

#### 🧪 Example

```lua
local new_entity = GMOD.copy(data.raw.furnace["stone-furnace"])
```

---

### `GMOD.extend(prototype)`

Safely adds a new prototype to the game using `data:extend()`.

#### 📥 Input

* `prototype` *(table)* – Valid Factorio prototype

#### 📤 Output

* `nil`

#### 🧪 Example

```lua
GMOD.extend(my_item)
```

---

### `GMOD.get_tables(root, key, stop_key)`

Recursively searches a table and returns all sub-tables that contain a given key.

#### 📥 Input

* `root` *(table)* – Root table to search
* `key` *(string)* – Key to look for
* `stop_key` *(string | nil)* – Optional key to stop recursion

#### 📤 Output

* `table[]` – List of matching tables

#### 🧪 Example

```lua
local sprites = GMOD.get_tables(entity, "filename")
```

---

## 🔢 Numeric Helpers

### `GMOD.number_unit(value)`

Parses Factorio-style numeric strings (e.g. `"5MW"`, `"120kW"`).

#### 📥 Input

* `value` *(string)* – Energy or power string

#### 📤 Output

* `number | nil`

#### 🧪 Example

```lua
local watts = GMOD.number_unit("5MW")
```

---

## 🧠 Logic & Validation

### `GMOD.has_id(name, id)`

Checks whether a name already contains a specific MOD ID.

#### 📥 Input

* `name` *(string)*
* `id` *(string)*

#### 📤 Output

* `boolean`

#### 🧪 Example

```lua
if GMOD.has_id(entity.name, This_MOD.id) then return end
```

---

## 🧪 Debugging

### `GMOD.var_dump(value)`

Prints a readable dump of a variable to the log.

#### 📥 Input

* `value` *(any)*

#### 📤 Output

* `nil`

#### 🧪 Example

```lua
GMOD.var_dump(entity)
```

---

## 🎮 Runtime Helper

### `GMOD.create_data(event, this_mod)`

Creates a **consolidated runtime data object** for events.

#### 📥 Input

* `event` *(table)* – Factorio event
* `this_mod` *(table)* – MOD descriptor returned by `get_id_and_name()`

#### 📤 Output

* `Data` *(table)* containing:

  * Player
  * Entity
  * Force
  * GUI storage
  * Persistent storage (`storage`)

#### 🧪 Example

```lua
script.on_event(defines.events.on_built_entity, function(event)
  local Data = GMOD.create_data(event, This_MOD)
  if not Data.Player then return end
end)
```

---

## 📌 Notes

* All functions are **safe to use across multiple MODs**
* Functions are designed to avoid duplication and conflicts
* This API may grow over time but aims to remain backward-compatible

---

## 🖼️ Screenshots

![Screenshot 1](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(1).png)

![Screenshot 2](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(2).png)

![Screenshot 3](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(3).png)

![Screenshot 4](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(4).png)

![Screenshot 5](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(5).png)

![Screenshot 6](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(6).png)

![Screenshot 7](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(7).png)

![Screenshot 8](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(8).png)

![Screenshot 9](https://github.com/yaim0425/YAIM0425-d00b-core/raw/code/screenshot/(9).png)
