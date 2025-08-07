# 📦 `zzzYAIM0425 0000 lib`

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


## 🔹 `GPrefix.get_technology(recipe)`

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
local tech = GPrefix.get_technology(recipe)
-- tech.name == "advanced-electronics"
```

## 🧠 `GPrefix.create_tech(prefix, tech, new_recipe)`

Crea una nueva tecnología en el espacio de nombres dado y le asigna una receta.  
Si ya existe una tecnología con ese nombre, simplemente le agrega la receta.

### 📥 Parámetros

| Nombre         | Tipo   | Descripción                                               |
|----------------|--------|-----------------------------------------------------------|
| `prefix`       | string | Prefijo o espacio de nombres usado para el nombre final   |
| `tech`         | table  | Definición base de la tecnología a crear                  |
| `new_recipe`   | table  | Receta a asociar a la tecnología                          |

### 🔁 Retorna

El objeto `Tech` creado o existente (`GPrefix.tech.raw[Tech_name]`).

### ⚙️ Comportamiento

- Si la tecnología ya existe, simplemente se le agrega la receta.
- Si no existe, se crea una copia de la definición y se ajusta el nombre (`prefix + name`).
- Agrega `prerequisites`, `effects` y desactiva la receta si es necesario.

### 💡 Ejemplo

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

Agrega una **nueva receta** a una tecnología que ya contiene otra receta como referencia.

### 📌 Parámetros
- `old_recipe_name`: Nombre (**string**) de la receta que ya está presente en la tecnología objetivo.
- `new_recipe`: Tabla (**table**) con los datos de la nueva receta a agregar.

### 📦 Retorna
- No retorna nada.
- Si no se encuentra la tecnología que contiene `old_recipe_name`, no se realiza ningún cambio.

### 🔍 Ejemplos

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

Agrega una **receta nueva** a una tecnología existente.  
Si la receta aún no ha sido definida, también se crea.

### 📌 Parámetros
- `tech_name`: `string` — Nombre interno de la tecnología  
- `new_recipe`: `table` — Tabla con la definición de la receta a agregar

### 🔁 Efectos
- Inserta un efecto `"unlock-recipe"` en la tecnología indicada  
- La receta es **desactivada por defecto** (`enabled = false`)  
- Si la receta no existe en `data.raw.recipe`, se registra automáticamente usando `GPrefix.extend`

### 🔍 Ejemplo

```lua
GPrefix.add_recipe_to_tech("automation", {
    name = "my-custom-recipe",
    ingredients = {
        {"iron-plate", 1},
        {"copper-plate", 1}
    },
    result = "electronic-circuit",
    enabled = true  -- será forzado a false internamente
})
```

## 🔹 `GPrefix.get_item_create_entity(entity)`

Obtiene el **ítem constructor** de una entidad dada, es decir, el objeto de inventario que permite colocarla en el mundo.

### 📌 Parámetros
- `entity`: `table` — Entidad de `data.raw` con información de minería (`minable`)

### 🔁 Retorna
- El ítem (`item`) que crea la entidad, o `nil` si no se encuentra

### ⚙️ Lógica interna
- Valida que la entidad tenga propiedades `minable` y `minable.results`
- Busca dentro de `entity.minable.results` un ítem que tenga `place_result` igual al nombre de la entidad

### 🔍 Ejemplo

```lua
local lamp = data.raw["lamp"]["small-lamp"]
local item = GPrefix.get_item_create_entity(lamp)

if item then
    log("El ítem que crea la lámpara es: " .. item.name)
end
```
## 🔹 `GPrefix.extend(...)`

Carga los **prototipos** al juego utilizando la función interna `data:extend`.

### 📌 Parámetros
- `...`: Uno o más elementos (tablas) que contienen definiciones de prototipos (recetas, ítems, entidades, etc.).

### 📦 Retorna
- No retorna nada directamente.
- Todos los prototipos proporcionados son registrados en el juego.

### 🔍 Ejemplos

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

## 📘 Funciones disponibles

- [`Funciones básicas`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/Basic%20functions.md)  
- [`Funciones avanzadas`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/Advanced%20functions.md)  
- [`control`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/control.md)  
- [`README`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/README.md)
