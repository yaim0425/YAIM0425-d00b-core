# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.number_unit(string)`

Parses and converts a string composed of a number with scale prefixes like `k`, `M`, `G`, etc., and physical units like `J` or `W`.

- 🔁 Interprets scale prefixes and converts them to powers of 10.
- 🔍 Validates and splits the string into a numeric value and unit.
- ❌ If the string is invalid, returns `nil, nil`.

### 📥 Parameters
- `string` (string): A string containing a number, prefix, and unit.  

### 📤 Returns
- `number`: Converted numeric value.  
- `string`: Detected physical unit.

### 📐 Supported prefixes
| Prefix | Power   |
|--------:|---------|
| (empty) | 10⁰     |
| `k`     | 10³     |
| `M`     | 10⁶     |
| `G`     | 10⁹     |
| `T`     | 10¹²    |
| `P`     | 10¹⁵    |
| `E`     | 10¹⁸    |
| `Z`     | 10²¹    |
| `Y`     | 10²⁴    |
| `R`     | 10²⁷    |
| `Q`     | 10³⁰    |

### 🧪 Examples
```lua
GPrefix.number_unit("0.3MW")   -- 300000, "W"
GPrefix.number_unit("1.5kJ")   -- 1500, "J"
GPrefix.number_unit("42")      -- 42, nil
GPrefix.number_unit("abc")     -- nil, nil
```

## 🔹 `GPrefix.short_number(number)`

Abbreviates a large number using suffixes like `k`, `M`, `G`, etc., making it easier to read.

- 🔢 Converts numeric values into a compact format.
- 🧠 Keeps a single decimal digit, removing unnecessary trailing zeros.
- ⚠️ If the input is not a number, returns `nil`.

### 📥 Parameters
- `number` (number): The number to abbreviate.

### 📤 Returns
- `string`: The abbreviated string.

### 📐 Used suffixes
| Power    | Suffix |
|---------:|--------|
| 10⁰      | _(empty)_ |
| 10³      | `k`    |
| 10⁶      | `M`    |
| 10⁹      | `G`    |
| 10¹²     | `T`    |
| 10¹⁵     | `P`    |
| 10¹⁸     | `E`    |
| 10²¹     | `Z`    |
| 10²⁴     | `Y`    |
| 10²⁷     | `R`    |
| 10³⁰     | `Q`    |

### 🧪 Examples
```lua
GPrefix.short_number(300000)     -- "300k"
GPrefix.short_number(1250000)    -- "1.2M"
GPrefix.short_number(1200000000) -- "1.2G"
GPrefix.short_number(532)        -- "532"
GPrefix.short_number("texto")    -- nil
```

## 🔹 `GPrefix.duplicate_item(item)`

Creates a copy of an `item`-type object, duplicating only specific properties.

### 📥 Parameters
- `item` (table): The object to duplicate.

### 📤 Returns
- `table`: A new `item` object with selected properties copied.  
  If the input is not a valid table, returns `nil`.

### 🧩 Copied properties
- `name`
- `icons`
- `order`
- `weight`
- `subgroup`
- `color_hint`
- `drop_sound`
- `pick_sound`
- `stack_size`
- `localised_name`
- `inventory_move_sound`
- `localised_description`
- `ingredient_to_weight_coefficient`

### 🧪 Example
```lua
local copy = GPrefix.duplicate_item({
    name = "iron-plate",
    stack_size = 100,
    order = "a[iron]-b[plate]"
})
-- copy = {
--   type = "item",
--   name = "iron-plate",
--   stack_size = 100,
--   order = "a[iron]-b[plate]",
--   ...
-- }
```

## 🔹 `GPrefix.delete_prefix(name)`

Removes the prefix from a name, based on the value of `GPrefix.name`, followed by a hyphen (`-`).

- ⚠️ If the prefix is not found, the name is returned unchanged.

### 📥 Parameters
- `name` (string): String with a prefix.  

### 📤 Returns
- `string`: Name without the prefix defined in `GPrefix.name`.  

### 🧪 Example
```lua
GPrefix.name = "prefix"
GPrefix.delete_prefix("prefix-0000-0200-name")
-- "0000-0200-name"
```

## 🔹 `GPrefix.duplicate_subgroup(old_name, new_name)`

Creates a new subroup (`item-subgroup`) by duplicating an existing one and generating a unique `order` based on the original subgroup.

- 🧬 Copies the properties of the original subgroup (`old_name`).
- 🔁 Calculates the next available `order`, incrementing the base value until a free slot is found.
- ⚠️ Returns `nil` if the original subgroup doesn't exist, if `new_name` already exists, or if there's no space in the order range.

### 📥 Parameters
- `old_name` (string): Name of the existing subgroup to duplicate.

- `new_name` (string): Name to assign to the new subgroup.

### 📤 Returns
- `table`: New subgroup created and extended with `data:extend`.  
  If an error occurs (validation or conflict), returns `nil`.

### 🧪 Example
```lua
local new = GPrefix.duplicate_subgroup("resources-raw", "resources-custom")
-- new = {
--   name = "resources-custom",
--   order = "0031",
--   ...
-- }
```

## 🔹 `GPrefix.get_technology(recipe)`

Returns the technology that directly unlocks a given recipe. If no such technology is found, it searches for the *most expensive* technology that allows crafting its ingredients.

- 🎯 Prioritizes technologies that directly unlock the recipe (`Tech.Recipe`).
- 📊 If multiple technologies are found, selects the cheapest (lower level, fewer ingredients, less science required).
- 🔁 If no direct technology exists, selects the most expensive among those that unlock the ingredients.

### 📥 Parameters
- `recipe` (table): The recipe for which to identify the unlocking technology.  

### 📤 Returns
- `table`: The associated technology (`technology`).  
  Returns `nil` if none is found.

### ⚙️ Selection logic
- **Stage 1:** If there are technologies that directly unlock the recipe:
  - If there's only one, it is returned.
  - If multiple exist, the *cheapest* one is selected:
    - Lower level.
    - Fewer ingredients.
    - Lower `unit.count` (science packs).
- **Stage 2:** If no direct technology is found:
  - Searches for technologies that unlock the recipe’s ingredients.
  - The *most expensive* one is selected, using the inverse criteria.

### 🧪 Example
```lua
local recipe = data.raw.recipe["advanced-circuit"]
local tech = GPrefix.get_technology(recipe)
-- tech.name == "advanced-electronics"
```

## 🔹 `GPrefix.add_recipe_to_tech_with_recipe(old_recipe_name, new_recipe)`

Adds a **new recipe** to a technology that already includes another reference recipe.

### 📌 Parameters
- `old_recipe_name`: A **string** representing the name of the reference recipe already present in the target technology.
- `new_recipe`: A **table** containing the definition of the new recipe to add.

### 📦 Returns
- Returns nothing.
- If no technology contains `old_recipe_name`, no change is made.

### 🔍 Examples

```lua
local new_recipe = {
  type = "recipe",
  name = "advanced-circuit-custom",
  enabled = false,
  ingredients = {
    {"copper-cable", 4},
    {"electronic-circuit", 2},
  },
  result = "advanced-circuit-custom"
}

GPrefix.add_recipe_to_tech_with_recipe("advanced-circuit", new_recipe)
```

## 🔹 `GPrefix.extend(...)`

Loads **prototypes** into the game using the internal `data:extend` function.

### 📌 Parameters
- `...`: One or more elements (tables) containing prototype definitions (recipes, items, entities, etc.).

### 📦 Returns
- Returns nothing.
- All provided prototypes are registered in the game.

### 🔍 Examples

```lua
GPrefix.extend({
  {
    type = "item",
    name = "custom-iron-plate",
    icon = "__base__/graphics/icons/iron-plate.png",
    icon_size = 64,
    stack_size = 100
  }
})
```

## 📘 Available Functions

- [`Basic functions`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/En/Basic%20functions.md)  
- [`Advanced functions`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/En/Advanced%20functions.md)  
- [`control`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/En/control.md)  
- [`README`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/README.md)
