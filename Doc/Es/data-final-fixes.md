# 📦 `zzzYAIM0425 0000 lib`

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

## 🔹 `GPrefix.duplicate_item(item)`

Crea una copia de un objeto tipo `item`, duplicando únicamente propiedades específicas.

### 📥 Parámetros
- `item` (table): Objeto a duplicar.  

### 📤 Retorno
- `table`: Nuevo objeto tipo `item`, con las propiedades copiadas.  
  Si el valor no es una tabla válida, devuelve `nil`.

### 🧩 Propiedades copiadas
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

### 🧪 Ejemplo
```lua
local nuevo = GPrefix.duplicate_item({
    name = "iron-plate",
    stack_size = 100,
    order = "a[iron]-b[plate]"
})
-- nuevo = {
--   type = "item",
--   name = "iron-plate",
--   stack_size = 100,
--   order = "a[iron]-b[plate]",
--   ...
-- }
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


## 🔹 `GPrefix.duplicate_subgroup(old_name, new_name)`

Crea un nuevo subgrupo (`item-subgroup`) duplicando uno existente y generando un `order` único basado en el subgrupo original.

- 🧬 Copia las propiedades del subgrupo original (`old_name`).
- 🔁 Calcula un nuevo `order` disponible, incrementando el valor base hasta encontrar un hueco libre.
- ⚠️ Devuelve `nil` si no se encuentra el subgrupo original, si ya existe uno con `new_name`, o si no hay espacio en el rango de orden.

### 📥 Parámetros
- `old_name` (string): Nombre del subgrupo existente a duplicar.  

- `new_name` (string): Nombre a asignar al nuevo subgrupo.  

### 📤 Retorno
- `table`: Nuevo subgrupo creado y extendido con `data:extend`.  
  Si ocurre un error (por validación o colisión), retorna `nil`.

### 🧪 Ejemplo
```lua
local nuevo = GPrefix.duplicate_subgroup("resources-raw", "resources-custom")
-- nuevo = {
--   name = "resources-custom",
--   order = "0031",
--   ...
-- }
```


## 🔹 `GPrefix.get_technology_unlock_recipe(recipe)`

Obtiene la tecnología que desbloquea directamente una receta dada. Si no se encuentra una tecnología que la desbloquee directamente, busca la tecnología más "costosa" que permita fabricar sus ingredientes.

- 🎯 Prioriza tecnologías directas que desbloquean la receta (`Tech.Recipe`).
- 📊 En caso de múltiples tecnologías, selecciona la más barata (menos nivel, ingredientes y ciencia).
- 🔁 Si no hay tecnología directa, busca la más costosa que permita fabricar los ingredientes.

### 📥 Parámetros
- `recipe` (table): Receta para la que se desea identificar la tecnología desbloqueadora.  

### 📤 Retorno
- `table`: Tecnología (`technology`) asociada.  
  Si no se encuentra ninguna, devuelve `nil`.

### ⚙️ Lógica de selección
- **Primera etapa:** Si hay tecnologías que desbloquean directamente la receta:
  - Si solo hay una, se devuelve.
  - Si hay varias, se elige la más *barata*:
    - Menor nivel.
    - Menor número de ingredientes.
    - Menor cantidad de unidades de ciencia (`unit.count`).
- **Segunda etapa:** Si no hay tecnología directa:
  - Se buscan las tecnologías que permiten fabricar los ingredientes.
  - Se selecciona la más *costosa*, con la lógica inversa a la anterior.

### 🧪 Ejemplo
```lua
local recipe = data.raw.recipe["advanced-circuit"]
local tech = GPrefix.get_technology_unlock_recipe(recipe)
-- tech.name == "advanced-electronics"
```
