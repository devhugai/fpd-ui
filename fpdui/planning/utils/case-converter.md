# Case Converter

Acá tenés **indicaciones claras y técnicas** para que un programador desarrolle un **script de Text Case Converter** que cubra **todos los casos listados**, con reglas consistentes y predecibles.

---

## General rules (apply to all cases)

* Input: arbitrary text string.
* Normalize input first:

  * Trim leading/trailing spaces.
  * Replace multiple spaces with a single space.
  * Preserve only letters and word separators (space, `_`, `-`, `.`, `/`), unless otherwise specified.
* Words are identified by:

  * Spaces
  * `_`, `-`, `.`, `/`
  * Case boundaries in camelCase / PascalCase
* Accented characters should be preserved.
* Numbers should be preserved and treated as part of the word they belong to.
* Output must not introduce trailing separators.

---

## Case definitions & rules

### 1. Lowercase

**Rule:**

* Convert all characters to lowercase.
* Preserve spaces.

**Example:**
`este es un ejemplo de text case conversion`

---

### 2. Uppercase

**Rule:**

* Convert all characters to uppercase.
* Preserve spaces.

**Example:**
`ESTE ES UN EJEMPLO DE TEXT CASE CONVERSION`

---

### 3. CamelCase

**Rule:**

* First word: lowercase.
* Subsequent words: capitalize first letter.
* Remove all separators.

**Example:**
`esteEsUnEjemploDeTextCaseConversion`

---

### 4. Capital Case

**Rule:**

* Capitalize the first letter of every word.
* Words separated by a single space.

**Example:**
`Este Es Un Ejemplo De Text Case Conversion`

---

### 5. Constant Case

**Rule:**

* All letters uppercase.
* Words separated by underscore `_`.

**Example:**
`ESTE_ES_UN_EJEMPLO_DE_TEXT_CASE_CONVERSION`

---

### 6. Dot Case

**Rule:**

* All letters lowercase.
* Words separated by dot `.`.

**Example:**
`este.es.un.ejemplo.de.text.case.conversion`

---

### 7. Header Case

**Rule:**

* Capitalize first letter of each word.
* Words separated by hyphen `-`.

**Example:**
`Este-Es-Un-Ejemplo-De-Text-Case-Conversion`

---

### 8. No Case

**Rule:**

* All letters lowercase.
* Words separated by spaces.
* Same output as normalized lowercase text.

**Example:**
`este es un ejemplo de text case conversion`

---

### 9. Param Case

**Rule:**

* All letters lowercase.
* Words separated by hyphen `-`.

**Example:**
`este-es-un-ejemplo-de-text-case-conversion`

---

### 10. PascalCase

**Rule:**

* Capitalize first letter of every word.
* Remove all separators.

**Example:**
`EsteEsUnEjemploDeTextCaseConversion`

---

### 11. Path Case

**Rule:**

* All letters lowercase.
* Words separated by slash `/`.

**Example:**
`este/es/un/ejemplo/de/text/case/conversion`

---

### 12. Sentence Case

**Rule:**

* First letter of the sentence uppercase.
* Rest lowercase.
* Words separated by spaces.

**Example:**
`Este es un ejemplo de text case conversion`

---

### 13. Snake Case

**Rule:**

* All letters lowercase.
* Words separated by underscore `_`.

**Example:**
`este_es_un_ejemplo_de_text_case_conversion`

---

### 14. Mocking Case

**Rule:**

* Alternate uppercase/lowercase letters randomly or by pattern.
* Spaces preserved.
* Common deterministic pattern:

  * Even index → uppercase
  * Odd index → lowercase
* Only letters are alternated; spaces stay unchanged.

**Example:**
`EsTe eS Un eJeMpLo dE TeXt cAsE CoNvErSiOn`

---

## Implementation recommendation

* Step 1: Normalize input and extract words into an array.
* Step 2: Apply case-specific transformation.
* Step 3: Join words using the case-specific separator.
* Step 4: Post-process (capitalization, randomness for mocking case).
