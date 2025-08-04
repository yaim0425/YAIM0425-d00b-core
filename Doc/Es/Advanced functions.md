# 📦 `zzzYAIM0425 0000 lib`

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

## 🔹 `GPrefix.split_name_folder(that_mod)`

Obtiene información del mod a partir del **nombre de la carpeta** desde donde se llama la función, extrayendo:
- `that_mod.id`: ID del mod (ej. 0000)
- `that_mod.name`: Nombre limpio del mod
- `that_mod.prefix`: Prefijo estandarizado en el formato `GPrefix.name-0000-`

### 📌 Parámetros
- `that_mod`: Tabla en la que se almacenarán los datos (`id`, `name`, `prefix`).

### 📦 Retorna
- No retorna valores directos. Modifica la tabla `that_mod` agregando las claves `id`, `name`, `prefix`.

### 🔍 Ejemplo

```lua
local that_mod = {}
GPrefix.split_name_folder(that_mod)

-- Resultado esperado:
-- that_mod.id = "0000"
-- that_mod.name = "lib"
-- that_mod.prefix = "GPrefix-0000-"
```

## 🔹 `GPrefix.get_id_and_name(name)`

Divide el nombre del mod en dos partes: **ID numérico** y **nombre textual**, según el formato `"zzzYAIM0425 0000 lib"`.

### 📌 Parámetros
- `name`: `string` — Nombre completo del mod (ej. `"zzzYAIM0425 0000 lib"`)

### 📦 Retorna
Una tupla con dos valores:
1. `id` (`string`) — Identificador numérico del mod (ej. `"0000"`)
2. `clean_name` (`string`) — Nombre del mod sin prefijo (ej. `"lib"`)

### 🔍 Ejemplo

```lua
local id, clean = GPrefix.get_id_and_name("zzzYAIM0425 0000 lib")

-- Resultado esperado:
-- id = "0000"
-- clean = "lib"
```

## 🔹 `GPrefix.delete_prefix(name)`

Elimina el prefijo de un nombre, basado en el valor de `GPrefix.name`, seguido por un guion (`-`).

- ⚠️ Si no se encuentra el prefijo, devuelve el nombre sin cambios.

### 📥 Parámetros
- `name` (string): Cadena con prefijo.  

### 📤 Retorno
- `string`: Nombre sin el prefijo definido en `GPrefix.name`.  

### 🧪 Ejemplo
```lua
GPrefix.name = "prefix"
GPrefix.delete_prefix("prefix-0000-0200-name")
-- "0000-0200-name"
```

## 🔹 `GPrefix.has_id(name, id)`

Verifica si un **ID específico** está contenido **exactamente** dentro de una cadena, delimitado por guiones (`-`).

### 📌 Parámetros
- `name`: `string` — Cadena donde se buscará el ID  
- `id`: `string` — Identificador a verificar

### 🔁 Retorna
- `boolean` — `true` si el ID está presente exactamente entre guiones; de lo contrario, `false`.

### 🔍 Ejemplo

```lua
local result = GPrefix.has_id("zzzYAIM0425-0000-lib", "0000")

-- Resultado esperado:
-- result = true
```

## 🔹 `GPrefix.number_unit(string)`

Separa y convierte una cadena compuesta por un número con prefijos como `k`, `M`, `G`, etc., y unidades físicas como `J` o `W`.

- 🔁 Interpreta prefijos de escala y los convierte a potencias de 10.
- 🔍 Valida y descompone la cadena en valor numérico y unidad.
- ❌ Si la cadena no es válida, retorna `nil, nil`.

### 📥 Parámetros
- `string` (string): Cadena con número, prefijo y unidad.  

### 📤 Retorno
- `number`: Valor convertido.  
- `string`: Unidad física detectada.  

### 📐 Prefijos soportados
| Prefijo | Potencia |
|--------:|----------|
| (vacío) | 10⁰      |
| `k`     | 10³      |
| `M`     | 10⁶      |
| `G`     | 10⁹      |
| `T`     | 10¹²     |
| `P`     | 10¹⁵     |
| `E`     | 10¹⁸     |
| `Z`     | 10²¹     |
| `Y`     | 10²⁴     |
| `R`     | 10²⁷     |
| `Q`     | 10³⁰     |

### 🧪 Ejemplos
```lua
GPrefix.number_unit("0.3MW")   -- 300000, "W"
GPrefix.number_unit("1.5kJ")   -- 1500, "J"
GPrefix.number_unit("42")      -- 42, nil
GPrefix.number_unit("abc")     -- nil, nil
```

## 🔹 `GPrefix.short_number(number)`

Abrevia un número grande utilizando sufijos como `k`, `M`, `G`, etc., simplificando su lectura.

- 🔢 Convierte valores numéricos a un formato más compacto.
- 🧠 Mantiene un solo decimal, eliminando ceros innecesarios.
- ⚠️ Si el valor no es numérico, devuelve `nil`.

### 📥 Parámetros
- `number` (number): Número a abreviar.  

### 📤 Retorno
- `string`: Cadena abreviada.  

### 📐 Sufijos utilizados
| Potencia | Sufijo |
|---------:|--------|
| 10⁰      | _(vacío)_ |
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

### 🧪 Ejemplos
```lua
GPrefix.short_number(300000)     -- "300k"
GPrefix.short_number(1250000)    -- "1.2M"
GPrefix.short_number(1200000000) -- "1.2G"
GPrefix.short_number(532)        -- "532"
GPrefix.short_number("texto")    -- nil
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

- [`Funciones básicas`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/Basic%20functions.md)  
- [`README`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/README.md)
- [`control`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/control.md)  
- [`data-final-fixes`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/data-final-fixes.md)
