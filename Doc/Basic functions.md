# 📦 zzzYAIM0425 0000 lib

### 🔹 GPrefix.is_nil(value)
```
GPrefix.is_nil(nil)
return true

GPrefix.is_nil("hello")
return false
```

### 🔹 GPrefix.is_table(value)
```
GPrefix.is_table({})
return true

GPrefix.is_table(123)
return false
```

### 🔹 GPrefix.is_string(value)
```
GPrefix.is_string("hello")
return true

GPrefix.is_string(10)
return false
```

### 🔹 GPrefix.is_number(value)
```
GPrefix.is_number(42)
return true

GPrefix.is_number("42")
return false
```

### 🔹 GPrefix.is_boolean(value)
```
GPrefix.is_boolean(false)
return true

GPrefix.is_boolean("false")
return false
```

### 🔹 GPrefix.is_function(value)
```
GPrefix.is_function(function() end)
return true

GPrefix.is_function(123)
return false
```

### 🔹 GPrefix.is_userdata(value)
```
GPrefix.is_userdata(userdata)
return true

GPrefix.is_userdata("text")
return false
```
