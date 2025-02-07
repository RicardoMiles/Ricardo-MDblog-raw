## `malloc()` and `realloc()`
| Feature | `malloc()` | `realloc()` |
|---------|------------|-------------|
|Purpose|Alloctes a new block of memory.|Resizes an existing memory block (can extend or shrink)|
|Data Preservation|Does not preserve data (new block is empty)|Preserves existing data, but moves it if needed.|
|Behavior|Allocates memory and returns a pointer to it|Resize memory, returning the pointer to the resized block.|
|Flexibility|Cannot resize an existing block.|Dynamically adjusts the size of an allocated block.|

