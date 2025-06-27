# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.is_nil(value)`

Checks whether a value is `nil`.  
Although this check can be performed directly in Lua (`value == nil`), this function exists for consistency with other `GPrefix.is_*` utilities, providing a uniform, clearer, and more extensible interface.

### 📌 Parameters
- `value`: Any type of value (string, number, table, etc.)

### 📦 Returns
- `true` if the value is `nil`.
- `false` in any other case.

### 🔍 Examples

```lua
GPrefix.is_nil(nil)
-- return true

GPrefix.is_nil("hello")
-- return false
```

## 🔹 `GPrefix.is_table(value)`

Checks whether a value is a table.

### 📌 Parameters
- `value`: Any type of data to check.

### 📦 Returns
- `true` if the value is of type `table`.
- `false` in any other case.

### 🔍 Examples

```lua
GPrefix.is_table({})
-- return true

GPrefix.is_table(123)
-- return false
```

## 🔹 `GPrefix.is_string(value)`

Checks whether a value is a string.

### 📌 Parameters
- `value`: Any value to evaluate.

### 📦 Returns
- `true` if the value is of type `string`.
- `false` in any other case.

### 🔍 Examples

```lua
GPrefix.is_string("hello")
-- return true

GPrefix.is_string(10)
-- return false
```

## 🔹 `GPrefix.is_number(value)`

Checks whether a value is numeric (`number`), including integers and decimals.

### 📌 Parameters
- `value`: Value to check.

### 📦 Returns
- `true` if the value is of type `number`.
- `false` in any other case.

### 🔍 Examples

```lua
GPrefix.is_number(42)
-- return true

GPrefix.is_number("42")
-- return false
```

## 🔹 `GPrefix.is_boolean(value)`

Checks whether a value is a boolean (`true` or `false`).

### 📌 Parameters
- `value`: Any value to evaluate.

### 📦 Returns
- `true` if the value is strictly `true` or `false`.
- `false` in any other case (including strings like `"false"` or `"true"`).

### 🔍 Examples

```lua
GPrefix.is_boolean(false)
-- return true

GPrefix.is_boolean("false")
-- return false
```

## 🔹 `GPrefix.is_function(value)`

Checks whether a value is a function.

### 📌 Parameters
- `value`: Any value to evaluate.

### 📦 Returns
- `true` if the value is of type `function`.
- `false` in any other case.

### 🔍 Examples

```lua
GPrefix.is_function(function() end)
-- return true

GPrefix.is_function(123)
-- return false
```

## 🔹 `GPrefix.is_userdata(value)`

Checks whether a value is of type `userdata`, typically used to handle objects defined by the Factorio engine or external integrations.

### 📌 Parameters
- `value`: Any value to evaluate.

### 📦 Returns
- `true` if the value is of type `userdata`.
- `false` in any other case.

### 🔍 Examples

```lua
GPrefix.is_userdata(userdata)
-- return true

GPrefix.is_userdata("text")
-- return false
```

## 📘 Available Functions

- [`README`](../../README.md)
- [`Advanced functions`](./Advanced%20functions.md)
- [`Control`](./control.md)
- [`Data Final Fixes`](./data-final-fixes.md)
