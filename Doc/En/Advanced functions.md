# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.digit_count(value)`

Counts how many **characters** are present in a number, including:
- Digits (`0–9`)
- A minus sign (`-`) if present
- A decimal point (`.`) if present

⚠️ This function converts the number to a string and counts its characters.  
It does **not** differentiate between integer or decimal parts—**all characters are counted**.

### 📌 Parameters
- `value`: A numeric value (integer or decimal) to evaluate.

### 📦 Returns
- An integer representing the total number of characters in the numeric value.
- `nil` if the value is not a number.

### 🔍 Examples

```lua
GPrefix.digit_count(10)
-- return 2

GPrefix.digit_count(-10)
-- return 3

GPrefix.digit_count(-1.60)
-- return 5

GPrefix.digit_count(1.60)
-- return 4

GPrefix.digit_count("")
-- return nil
```

## 🔹 `GPrefix.get_length(array)`

Returns the number of elements contained in a table, regardless of whether it uses numeric indices or custom keys.

### 📌 Parameters
- `array`: A Lua table, either a list-style table (`{ "A", "B", "C" }`) or a dictionary-style table (`{ ["A"]="A", ... }`).

### 📦 Returns
- An integer representing the number of elements.
- `nil` if the value is not a table.

### 🔍 Examples

```lua
GPrefix.get_length({"A", "B", "C"})
-- return 3

GPrefix.get_length({["A"]="A", ["B"]="B", ["C"]="C"})
-- return 3

GPrefix.get_length("")
-- return nil
```

## 🔹 `GPrefix.get_key(array, value)`

Searches for a value within a table and returns its corresponding key, whether it's a numeric index or a custom key.

### 📌 Parameters
- `array`: The table in which to search for the value.
- `value`: The value to search for inside the table.

### 📦 Returns
- The **key** of the found value (`number` or `string`).
- `nil` if the value is not present in the table.

### 🔍 Examples

```lua
GPrefix.get_key({"A", "B", "C"}, "B")
-- return 2

GPrefix.get_key({["A"]="A", ["B"]="B", ["C"]="C"}, "B")
-- return "B"

GPrefix.get_key({"A", "B", "C"}, "D")
-- return nil
```

## 🔹 `GPrefix.pad_left_zeros(digits, value)`

Pads a value on the left with zeros (`"0"`) until it reaches a specified total length.

### 📌 Parameters
- `digits`: Desired total length of the result (number).
- `value`: String or number to be padded.

### 📦 Returns
- A **string** padded with leading zeros if necessary.
- Returns an empty string if either `digits` or `value` is invalid.

### 🔍 Examples

```lua
GPrefix.pad_left_zeros(3, "1")
-- return "001"

GPrefix.pad_left_zeros(2, "B")
-- return "0B"

GPrefix.pad_left_zeros("", "")
-- return ""
```

## 🔹 `GPrefix.get_table(array, key, value)`

Searches for and returns the **first table** inside an array that contains a specific key with a given value.

### 📌 Parameters
- `array`: A list of tables (array of dictionaries).
- `key`: The key to look for in each subtable.
- `value`: The value that the key must have to be considered a match.

### 📦 Returns
- The **first subtable** that meets the condition `subtable[key] == value`.
- `nil` if no match is found.

### 🔍 Examples

```lua
local recipe = {
  {type="fluid", name="oil", amount=10},
  {type="item", name="iron-ore", amount=3},
  {type="item", name="iron-plate", amount=5}
}

GPrefix.get_table(recipe, "type", "fluid")
-- return {type="fluid", name="oil", amount=10}

GPrefix.get_table(recipe, "type", "item")
-- return {type="item", name="iron-ore", amount=3}

GPrefix.get_table(recipe, "type", "beam")
-- return nil
```

## 🔹 `GPrefix.get_tables(array, key, value)`

Recursively searches for all tables that contain a specific key with a given value, and returns them in a list.

### 📌 Parameters
- `array`: A complex table that may contain nested tables.
- `key`: The key to search for in each subtable.
- `value`: The expected value for that key.

### 📦 Returns
- A **list of subtables** that contain `key = value`.
- An **empty table** if no matches are found.

### 🔍 Examples

```lua
local attack_parameters = {
  type = 'beam',
  cooldown = 40,
  range = 24,
  range_mode = 'center-to-bounding-box',
  source_direction_count = 64,
  source_offset = {0, -0.85587225},
  damage_modifier = 2,
  ammo_category = 'laser',
  ammo_type = {
    energy_consumption = '800kJ',
    action = {
      type = 'direct',
      action_delivery = {
        type = 'beam',
        beam = 'laser-beam',
        max_length = 24,
        duration = 40,
        source_offset = {0, -1.31439}
      }
    }
  }
}

GPrefix.get_tables(attack_parameters, "beam", "laser-beam")
-- return {
--   {
--     type = 'beam',
--     beam = 'laser-beam',
--     max_length = 24,
--     duration = 40,
--     source_offset = {0, -1.31439}
--   }
-- }

GPrefix.get_tables(attack_parameters, "type", "item")
-- return nil
```

## 🔹 `GPrefix.var_dump(value1, ..., valueN)`

Prints one or more values to the `factorio-current.log` file in a visually clear and structured format, useful for debugging purposes.

### 📌 Parameters
- `value1, ..., valueN`: One or more values (strings, numbers, tables, etc.) to be logged.

### 📦 Returns
- Returns `nil`. Its primary purpose is the **side effect** of writing to the log.

### 🔍 Examples

```lua
local recipe = {
  {type="fluid", name="oil", amount=10},
  {type="item", name="iron-ore", amount=3},
  {type="item", name="iron-plate", amount=5}
}

GPrefix.var_dump(recipe)
```

### 🗂️ Resultado en `factorio-current.log`

```log
>>>
{
  [ 1 ] = {
    [ 'type' ] = 'fluid',
    [ 'name' ] = 'oil',
    [ 'amount' ] = 10
  },
  [ 2 ] = {
    [ 'type' ] = 'item',
    [ 'name' ] = 'iron-ore',
    [ 'amount' ] = 3
  },
  [ 3 ] = {
    [ 'type' ] = 'item',
    [ 'name' ] = 'iron-plate',
    [ 'amount' ] = 5
  }
}
<<<
```

## 📘 Available Functions

- [`Basic functions`](./Basic%20functions.md)
- [`README`](../../README.md)
- [`Control`](./control.md)
- [`Data Final Fixes`](./data-final-fixes.md)
