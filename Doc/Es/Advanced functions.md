# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.digit_count(value)`

Cuenta cuántos **caracteres** tiene un número, incluyendo:
- Dígitos (`0–9`)
- El signo negativo (`-`) si existe
- El punto decimal (`.`) si está presente

### 📌 Parámetros
- `value`: Valor numérico (entero o decimal) a evaluar.

### 📦 Retorna
- Un número entero representando la cantidad de caracteres del valor.
- `nil` si el valor no es numérico.

### 🔍 Ejemplos

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

Devuelve la cantidad de elementos contenidos en una tabla, sin importar si tiene índices numéricos o claves personalizadas.

### 📌 Parámetros
- `array`: Una tabla en Lua, ya sea tipo lista (`{ "A", "B", "C" }`) o diccionario (`{ ["A"]="A", ... }`).

### 📦 Retorna
- Un número entero indicando la cantidad de elementos.
- `nil` si el valor no es una tabla.

### 🔍 Ejemplos

```lua
GPrefix.get_length({"A", "B", "C"})
-- return 3

GPrefix.get_length({["A"]="A", ["B"]="B", ["C"]="C"})
-- return 3

GPrefix.get_length("")
-- return nil
```

## 🔹 `GPrefix.get_key(array, value)`

Busca un valor dentro de una tabla y retorna su clave correspondiente, ya sea índice numérico o clave personalizada.

### 📌 Parámetros
- `array`: Tabla en la que se buscará el valor.
- `value`: Valor a buscar dentro de la tabla.

### 📦 Retorna
- La **clave** del valor encontrado (`número` o `string`).
- `nil` si el valor no está presente en la tabla.

### 🔍 Ejemplos

```lua
GPrefix.get_key({"A", "B", "C"}, "B")
-- return 2

GPrefix.get_key({["A"]="A", ["B"]="B", ["C"]="C"}, "B")
-- return "B"

GPrefix.get_key({"A", "B", "C"}, "D")
-- return nil
```

## 🔹 `GPrefix.pad_left_zeros(digits, value)`

Rellena un valor por la izquierda con ceros (`"0"`) hasta alcanzar una longitud total específica.

### 📌 Parámetros
- `digits`: Longitud total deseada del resultado (número).
- `value`: Cadena de texto o número a rellenar.

### 📦 Retorna
- Una **cadena de texto** con ceros a la izquierda si es necesario.
- Si `digits` o `value` no son válidos, se devuelve una cadena vacía.

### 🔍 Ejemplos

```lua
GPrefix.pad_left_zeros(3, "1")
-- return "001"

GPrefix.pad_left_zeros(2, "B")
-- return "0B"

GPrefix.pad_left_zeros("", "")
-- return ""
```

## 🔹 `GPrefix.get_table(array, key, value)`

Busca y retorna la **primera tabla** dentro de un arreglo que contenga una clave con un valor específico.

### 📌 Parámetros
- `array`: Lista de tablas (array de diccionarios).
- `key`: Clave a buscar dentro de cada subtabla.
- `value`: Valor que debe tener la clave para ser considerada coincidencia.

### 📦 Retorna
- La **primera subtabla** que cumpla la condición `subtabla[key] == value`.
- `nil` si no se encuentra ninguna coincidencia.

### 🔍 Ejemplos

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

Busca de forma **recursiva** todas las tablas que contengan una clave con un valor específico, y las retorna en una lista.

### 📌 Parámetros
- `array`: Tabla compleja que puede contener otras tablas anidadas.
- `key`: Clave que debe buscarse dentro de cada subtabla.
- `value`: Valor esperado para esa clave.

### 📦 Retorna
- Una **lista de subtablas** que contienen `key = value`.
- Una **tabla vacía** si no se encuentra ninguna coincidencia.

### 🔍 Ejemplos

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

Imprime uno o más valores en el archivo `factorio-current.log` en un formato visualmente claro y estructurado, útil para depuración.

### 📌 Parámetros
- `value1, ..., valueN`: Uno o más valores (strings, números, tablas, etc.) que se deseen registrar.

### 📦 Retorna
- Devuelve `nil`. Su propósito principal es el efecto de **registro/log**.

### 🔍 Ejemplos

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

## 📘 Funciones disponibles

- [`Basic functions`](./Doc/Es/Basic%20functions.md)
- [`Volver al README`](./README.md)
- [`control`](./Doc/Es/control.md)
- [`data-final-fixes`](./Doc/Es/data-final-fixes.md)
