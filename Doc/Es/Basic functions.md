# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.is_nil(value)`

Verifica si un valor es `nil`.  
Aunque esta verificación puede hacerse directamente en Lua (`value == nil`), esta función existe por razones de consistencia con otras utilidades `GPrefix.is_*`, permitiendo una interfaz uniforme, más clara y extensible.

### 📌 Parámetros
- `value`: Cualquier tipo de valor (string, número, tabla, etc.)

### 📦 Retorna
- `true` si el valor es `nil`.
- `false` en cualquier otro caso.

### 🔍 Ejemplos

```lua
GPrefix.is_nil(nil)
-- return true

GPrefix.is_nil("hello")
-- return false
```

## 🔹 `GPrefix.is_table(value)`

Verifica si un valor es una tabla.

### 📌 Parámetros
- `value`: Cualquier tipo de dato a verificar.

### 📦 Retorna
- `true` si el valor es de tipo `table`.
- `false` en cualquier otro caso.

### 🔍 Ejemplos

```lua
GPrefix.is_table({})
-- return true

GPrefix.is_table(123)
-- return false
```

## 🔹 `GPrefix.is_string(value)`

Verifica si un valor es una cadena de texto (`string`).

### 📌 Parámetros
- `value`: Cualquier valor a evaluar.

### 📦 Retorna
- `true` si el valor es de tipo `string`.
- `false` en cualquier otro caso.

### 🔍 Ejemplos

```lua
GPrefix.is_string("hello")
-- return true

GPrefix.is_string(10)
-- return false
```

## 🔹 `GPrefix.is_number(value)`

Verifica si un valor es numérico (`number`), incluyendo enteros y decimales.

### 📌 Parámetros
- `value`: Valor a comprobar.

### 📦 Retorna
- `true` si el valor es de tipo `number`.
- `false` en cualquier otro caso.

### 🔍 Ejemplos

```lua
GPrefix.is_number(42)
-- return true

GPrefix.is_number("42")
-- return false
```

## 🔹 `GPrefix.is_boolean(value)`

Verifica si un valor es booleano (`true` o `false`).

### 📌 Parámetros
- `value`: Cualquier valor a evaluar.

### 📦 Retorna
- `true` si el valor es estrictamente `true` o `false`.
- `false` en cualquier otro caso (incluidos strings como `"false"` o `"true"`).

### 🔍 Ejemplos

```lua
GPrefix.is_boolean(false)
-- return true

GPrefix.is_boolean("false")
-- return false
```

## 🔹 `GPrefix.is_function(value)`

Verifica si un valor es una función.

### 📌 Parámetros
- `value`: Cualquier valor a evaluar.

### 📦 Retorna
- `true` si el valor es de tipo `function`.
- `false` en cualquier otro caso.

### 🔍 Ejemplos

```lua
GPrefix.is_function(function() end)
-- return true

GPrefix.is_function(123)
-- return false
```

## 🔹 `GPrefix.is_userdata(value)`

Verifica si un valor es de tipo `userdata`, típicamente usado para manejar objetos definidos por el motor de Factorio o integraciones externas.

### 📌 Parámetros
- `value`: Cualquier valor a evaluar.

### 📦 Retorna
- `true` si el valor es de tipo `userdata`.
- `false` en cualquier otro caso.

### 🔍 Ejemplos

```lua
GPrefix.is_userdata(userdata)
-- return true

GPrefix.is_userdata("text")
-- return false
```