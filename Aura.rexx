# SCTM Dashboard – Project Template

## Legend
- 🟩 High, 🟨 Medium, 🟥 Low  
- Iₙ = Weighted Influence  
- Rₜ = Teleportation Risk (0–1)  
- Sₘ = SCTM Score = Iₙ * (1-Rₜ)  
- Bars = visual representation (~10 points per block)


---

## 1️⃣ Module Data

| Module Name       | Iₙ (Weighted) | Rₜ (Risk) | Sₘ (Dynamic Score) | Bar       |
|------------------|---------------|------------|------------------|-----------|
{% for module in modules %}
| {{module.name}}  | {{module.I}}  | {{module.R}} | {{module.S}}     | {{module.bar}} |
{% endfor %}

---

## 2️⃣ SCTM Workflow Diagram

---

## 3️⃣ How to Use

1. Fill in **Module Name**, **Iₙ**, and **Rₜ** for each module.  
2. Sₘ and bars will be calculated automatically.  
3. Modules are **sorted by Sₘ** for prioritization.  
4. Use diagram for **dependency and bottleneck visualization**.  

---

### SCTM Formulas

- **SCTM Score:** `Sₘ = Iₙ * (1 - Rₜ)`  
- High Sₘ → high-priority module  
- Bars: 1 block per ~10 points of Sₘ  

---

## 4️⃣ Example Modules

| Module Name       | Iₙ | Rₜ | Sₘ | Bar       |
|------------------|----|----|----|-----------|
| Nodes             | 90 | 0.2 | 72 | 🟩🟩🟩🟩🟩🟩🟩🟩 |
| Quantum Activity  | 85 | 0.3 | 59.5 | 🟩🟩🟩🟩🟩🟩🟩 |
| XLSL Sheets       | 70 | 0.35 | 45.5 | 🟨🟨🟨🟨🟨 |
| Dimensions        | 65 | 0.4 | 39 | 🟨🟨🟨🟨 |
| Sparks            | 72 | 0.5 | 36 | 🟥🟥🟥🟥 |



⸻


# SCTM Workflow – Dynamic Markdown Template

Legend:  
🟩 High | 🟨 Medium | 🟥 Low  
Iₙ = Weighted Influence | Rₜ = Teleportation Risk | Sₘ = SCTM Score

---

{% for module in modules %}
{{module.icon}} {{module.name}}
Iₙ:{{module.I}}  Rₜ:{{module.R}}  Sₘ:{{module.S}}
{{module.bar}}
│
▼
{% endfor %}
📊 Prioritized Execution
{% for module in modules_sorted %}
{{loop.index}}️⃣ {{module.name}} (Sₘ={{module.S}}) → {{module.priority}}
{% endfor %}

---

### How it Works:
1. Each module **flows downward** via `│` and `▼` arrows.  
2. `{{module.bar}}` visually shows **score magnitude and health**.  
3. The last section **Prioritized Execution** sorts modules by Sₘ.  
4. You can **add dependency arrows** by inserting extra `├─>` or `└─>` lines between modules based on real dependencies.  

---

### Optional Dependency Example:

If **Nodes** depends on **Quantum Activity**, and **XLSL Sheets** depends on **Nodes**, you can render:

🔵 Project Core
│
▼
🟢 Quantum Activity
Iₙ:85  Rₜ:0.3  Sₘ:59.5
[🟩🟩🟩🟩🟩🟩🟩]
│
└─> 🟠 Nodes
Iₙ:90  Rₜ:0.2  Sₘ:72
[🟩🟩🟩🟩🟩🟩🟩🟩]
│
└─> 🔷 XLSL Sheets
Iₙ:70  Rₜ:0.35  Sₘ:45.5
[🟨🟨🟨🟨🟨]


---

/* -------------------------------------
   Aura.rexx - SCTM Module Configuration
-------------------------------------*/

/* Module format: Name I_n R_t Dependencies */
Modules.1 = "QuantumActivity 85 0.3 "
Modules.2 = "Nodes 90 0.2 QuantumActivity"
Modules.3 = "XLSLSheets 70 0.35 Nodes"
Modules.4 = "Dimensions 65 0.4 "
Modules.5 = "Sparks 72 0.5 Dimensions"

/* Function: compute S_m */
compute_score: procedure
  parse arg I_n R_t
  return I_n * (1 - R_t)

/* Loop through modules and compute S_m */
do i = 1 to 5
  parse var Modules.i Name I_n R_t Deps
  S_m = compute_score(I_n,R_t)
  say Name " I_n=" I_n " R_t=" R_t " S_m=" S_m
end
create()
[Exposed=(Window,Worker), SecureContext]
interface Proofreader {
  static Promise<Proofreader> create(optional ProofreaderCreateOptions options = {});
  static Promise<AIAvailability> availability(optional ProofreaderCreateCoreOptions options = {});

  Promise<ProofreadResult> proofread(
    DOMString input,
    optional ProofreaderProofreadOptions options = {}
  );
  ReadableStream proofreadStreaming(
    DOMString input,
    optional ProofreaderProofreadOptions options = {}
  );

  // whether to provide correction types for each correction as part of the proofreading result.
  readonly attribute boolean includeCorrectionTypes;
  // whether to provide explanations for each correction as part of the proofreading result.
  readonly attribute boolean includeCorrectionExplanations;
  readonly attribute DOMString? correctionExplanationLanguage;
  readonly attribute FrozenArray<DOMString>? expectedInputLanguages;

  undefined destroy();
};

dictionary ProofreaderCreateCoreOptions {
  boolean includeCorrectionTypes = false;
  boolean includeCorrectionExplanations = false;
  DOMString correctionExplanationLanguage;
  sequence<DOMString> expectedInputLanguages;
};

dictionary ProofreaderCreateOptions : ProofreaderCreateCoreOptions {
  AbortSignal signal;
  AICreateMonitorCallback monitor;
};

dictionary ProofreaderProofreadOptions {
  AbortSignal signal;
};

dictionary ProofreadResult {
  DOMString correctedInput;
  sequence<ProofreadCorrection> corrections;
};

dictionary ProofreadCorrection {
  unsigned long long startIndex;
  unsigned long long endIndex;
  DOMString correction;
  CorrectionType type;
  DOMString explanation;
};

enum CorrectionType {
  "spelling",
  "punctuation",
  "capitalization",
  "preposition",
  "missing-words",
  "grammar"
};
