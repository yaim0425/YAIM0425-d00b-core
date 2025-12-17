# YAIM0425 d00b Core

---

### 📌 Description

**YAIM0425 d00b Core** is a technical **core / framework MOD** for Factorio, designed to act as a shared utility library for all other MODs developed under the **YAIM0425** ecosystem.

This MOD does **not add gameplay content by itself**. Instead, it provides a unified and consistent infrastructure that simplifies development, improves compatibility, and reduces duplicated logic across multiple MODs.

Its main responsibilities include:

- Initializing a global shared container (`GMOD`) for all YAIM0425 MODs
- Providing reusable utility functions and helpers
- Safely consolidating event data (players, entities, forces, GUI, storage)
- Classifying and indexing prototypes:
  - Items
  - Fluids
  - Entities
  - Equipments
  - Tiles (grouped by mining results)
  - Recipes (grouped by results)
- Ensuring correct execution across **settings**, **data-final-fixes** and **control** stages
- Offering a stable base compatible with large overhaul MODs (Bob’s, Py, Krastorio 2, Space Exploration, etc.)

This MOD is intended to be used as a **dependency** by other MODs, not as a standalone experience.

🔗 **GitHub Repository**  
https://github.com/yaim0425/YAIM0425-d00b-core
