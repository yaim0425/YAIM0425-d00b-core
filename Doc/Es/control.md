# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.create_data(event, that_mod)`

Construye y retorna una tabla con los datos clave del evento recibido, centralizando información útil sobre entidades, jugadores, forces y espacios de almacenamiento (guardables y no guardables). Está diseñada para facilitar la interoperabilidad entre múltiples MODs.

### 📌 Parámetros
- `event`: Tabla de evento proporcionada por Factorio.
- `that_mod`: Referencia al mod que llama, usada para separar su espacio de datos.

### 📦 Retorna `Data`
**Valores basicas**
- `Event`: Referencia directa al evento
- `Entity`: La entidad afectada o creada, si existe
- `Player`: El jugador, si existe

- `Force_player`: Force al que pertenece `Player`
- `Force_entity`: Force al que pertenece `Entity`
- `Force`: Existe si `Force_player` y `Force_entity` son iguales, si solo existe `Player` o si solo existe  `Entity`. La existencia de esta variable eliminará `Force_player` y `Force_entity`

**Los siguientes son espacios/datos que se guardan con la partida.**
- `gPrefix`: Contiene todos los datos guardados de todos los mods de `yaim0425`, los espacios están indexados por `that_mod.index`
- `gMOD`: Contenedor de todos los datos guardados del mod en ejecución. Contiene `gForces` y `gPlayers`
- `gForces`: Contenedor de cada force que ha usada el mod, los espacios están indexados por `Force.index`
- `gForce`: Espacio para el force actual, si existe
- `gPlayers`: Contenedor de cada jugador que ha usado el mod, los espacios están indexados por `Player.index`
- `gPlayer`: Espacios guardables para el jugador

**Los siguientes son espacios/datos que NO se guardan con la partida.**
- `GForces`: Contenedor de cada force que ha usada el mod, los espacios están indexados por `Force.index`
- `GForce`: Espacio para el force actual, si existe
- `GPlayers`: Contenedor de cada jugador que ha usado el mod, los espacios están indexados por `Player.index`
- `GPlayer`: Espacios guardables para el jugador. Contiene `GUI`
- `GUI`: Espacio no guardable para interfaces gráficas por jugador

### 🔍 Ejemplo de uso

```lua
local Data = GPrefix.create_data(event, my_mod)

-- Acceder al jugador
if Data.Player then
    game.print("Jugador: " .. Data.Player.name)
end

-- Acceder al espacio guardable del MOD
Data.gMOD.mi_variable = true
```

## 📘 Funciones disponibles

- [`Basic functions`](./Basic%20functions.md)
- [`Advanced functions`](./Advanced%20functions.md)
- [`Volver al README`](./README.md)
- [`data-final-fixes`](./data-final-fixes.md)
