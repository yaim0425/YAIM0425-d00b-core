# 📦 `zzzYAIM0425 0000 lib`

### 🔹 `GPrefix.digit_count(value)`
```
GPrefix.digit_count(10)
return 2

GPrefix.digit_count(-10)
return 3

GPrefix.digit_count(-1.60)
return 2

GPrefix.digit_count(1.60)
return 1

GPrefix.digit_count(“”)
return nil
```

### 🔹 `GPrefix.get_length(array)`
```
GPrefix.get_length({“A”, “B”, “C”})
return 3

GPrefix.get_length({[“A”]=“A”, [“B”]=“B”, [“C”]=“C”})
return 3

GPrefix.get_length("")
return nil
```

### 🔹 `GPrefix.get_key(array, value)`
```
GPrefix.get_key({“A”, “B”, “C”}, "B")
return 2

GPrefix.get_key({[“A”]=“A”, [“B”]=“B”, [“C”]=“C”}, "B")
return "B"

GPrefix.get_key({“A”, “B”, “C”}, "D")
return nil
```

### 🔹 `GPrefix.pad_left(digits, value)`
```
GPrefix.pad_left(3, "1")
return "001"

GPrefix.pad_left(2, "B")
return "0B"

GPrefix.pad_left("", "")
return ""
```

### 🔹 `GPrefix.get_table(array, key, value)`
```
local recipe = {
    {type="fluid", name="oil", amount=10},
    {type="item", name="iron-ore", amount=3},
    {type="item", name="iron-plate", amount=5}
}

GPrefix.get_table(recipe, "type", "fluid")
return {type="fluid", name="oil", amount=10}

GPrefix.get_table(recipe, "type", "item")
return {type="item", name="iron-ore", amount=3}

GPrefix.get_table(recipe, "type", "beam")
return nil
```

### 🔹 `GPrefix.get_tables(array, key, value)`
```
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
return
{
    {
        type = 'beam',
        beam = 'laser-beam',
        max_length = 24,
        duration = 40,
        source_offset = {0, -1.31439}
    }
}

GPrefix.get_table(attack_parameters, "type", "item")
return nil
```

### 🔹 `GPrefix.log(value1, ..., valueN)`
```
local recipe = {
    {type="fluid", name="oil", amount=10},
    {type="item", name="iron-ore", amount=3},
    {type="item", name="iron-plate", amount=5}
}

GPrefix.log(recipe) --> factorio-current.log
GPrefix.log(recipe) --> factorio-current.log
return
">>>
">>>
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
<<<"
<<<"
```
