# 📦 `zzzYAIM0425 0000 lib`

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

## 🧠 `GPrefix.create_tech(prefix, tech, new_recipe)`

Creates a new technology in the given namespace and links it to a recipe.  
If a technology with that name already exists, the recipe is simply added to it.

### 📥 Parameters

| Name           | Type   | Description                                                 |
|----------------|--------|-------------------------------------------------------------|
| `prefix`       | string | Prefix or namespace used to build the final tech name       |
| `tech`         | table  | Base definition of the technology to create                 |
| `new_recipe`   | table  | Recipe to associate with the technology                     |

### 🔁 Returns

The created or existing `Tech` object (`GPrefix.tech.raw[Tech_name]`).

### ⚙️ Behavior

- If the tech already exists, it just adds the recipe to it.
- If it doesn’t, it copies the definition and renames it using the prefix.
- Adds `prerequisites`, `effects`, and disables the recipe if needed.

### 💡 Example

```lua
GPrefix.create_tech("core-", {
  name = "advanced-circuits",
  icon = "__mod__/graphics/icons/tech.png",
  unit = {
    count = 100,
    ingredients = {{"automation-science-pack", 1}},
    time = 30
  }
}, {
  name = "core-advanced-circuits-recipe",
  ingredients = {{"copper-cable", 2}, {"plastic-bar", 2}},
  result = "advanced-circuit",
  enabled = false
})
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

## 🔹 `GPrefix.add_recipe_to_tech(tech_name, new_recipe)`

Adds a **new recipe** to an existing technology.  
If the recipe hasn't been defined yet, it will also be created.

### 📌 Parameters
- `tech_name`: `string` — Internal name of the technology  
- `new_recipe`: `table` — Table with the recipe definition to add

### 🔁 Effects
- Inserts an `"unlock-recipe"` effect into the specified technology  
- The recipe is **disabled by default** (`enabled = false`)  
- If the recipe doesn't exist in `data.raw.recipe`, it will be registered using `GPrefix.extend`

### 🔍 Example

```lua
GPrefix.add_recipe_to_tech("automation", {
    name = "my-custom-recipe",
    ingredients = {
        {"iron-plate", 1},
        {"copper-plate", 1}
    },
    result = "electronic-circuit",
    enabled = true  -- will be internally set to false
})
```

## 🔹 `GPrefix.get_item_create_entity(entity)`

Retrieves the **item** that places the given entity in the world — that is, the item responsible for creating it.

### 📌 Parameters
- `entity`: `table` — A `data.raw` entity with mining information (`minable`)

### 🔁 Returns
- The `item` that creates the entity, or `nil` if none is found

### ⚙️ Internal Logic
- Validates that the entity has `minable` and `minable.results` defined
- Scans `entity.minable.results` for an item with `place_result` equal to the entity’s name

### 🔍 Example

```lua
local lamp = data.raw["lamp"]["small-lamp"]
local item = GPrefix.get_item_create_entity(lamp)

if item then
    log("The item that creates the lamp is: " .. item.name)
end
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
