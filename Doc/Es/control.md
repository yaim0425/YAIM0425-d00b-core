# 📦 `zzzYAIM0425 0000 lib`

## 🔹 `GPrefix.create_data(event, that_mod)`

Crea una estructura consolidada de datos a partir de un evento. Esta estructura facilita el acceso a entidades, jugadores, fuerzas y espacios de almacenamiento tanto persistentes como temporales.

### 📌 Parámetros
- `event`: `table` — Evento recibido desde `script.on_event`
- `that_mod`: `table` — Información del mod actual, incluyendo `id`, `Forces`, `Players`, etc.

### 🔁 Retorna
- `table` — Objeto `Data` con acceso centralizado a la información útil durante el evento.

---

### 🧱 Contenido del objeto `Data`

#### 🔸 Datos básicos del evento
- `Data.Event`: Referencia directa del evento recibido.
- `Data.Entity`: La entidad afectada (`event.entity` o `event.created_entity`).
- `Data.Player`: Jugador relacionado al evento (`game.get_player(event.player_index)`).
- `Data.Force`: Fuerza principal asociada al evento (jugador o entidad).

#### 🔸 Fuerzas adicionales
- `Data.Force_player`: Fuerza asociada al jugador.
- `Data.Force_entity`: Fuerza asociada a la entidad.

Si ambas fuerzas coinciden, se consolidan en `Data.Force`.

---

### 💾 Almacenamientos (persistentes y temporales)

#### 🔸 Espacios guardables
- `Data.gPrefix`: Espacio global por mod.
- `Data.gMOD`: Espacio por mod específico.
- `Data.gForces`: Tabla de fuerzas persistentes.
- `Data.gForce`: Espacio específico de una fuerza.
- `Data.gPlayers`: Tabla de jugadores persistentes.
- `Data.gPlayer`: Espacio específico de un jugador.

#### 🔸 Espacios no guardables
- `Data.GForces`: Tabla de fuerzas temporales (`that_mod.Forces`).
- `Data.GForce`: Espacio temporal específico de una fuerza.
- `Data.GPlayers`: Tabla de jugadores temporales (`that_mod.Players`).
- `Data.GPlayer`: Espacio temporal de un jugador.
- `Data.GUI`: Espacio temporal para interfaces gráficas (GUI) del jugador.

---

### 🔍 Ejemplo de uso

```lua
script.on_event(defines.events.on_built_entity, function(event)
  local Data = GPrefix.create_data(event, This_MOD)
  if Data.Entity then
    log("Entidad colocada por el jugador: " .. Data.Entity.name)
  end
end)
```

## 📘 Funciones disponibles

- [`Funciones básicas`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/Basic%20functions.md)  
- [`Funciones avanzadas`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/Advanced%20functions.md)  
- [`README`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/README.md)
- [`data-final-fixes`](https://github.com/yaim0425/zzzYAIM0425-0000-lib/blob/main/Doc/Es/data-final-fixes.md)
