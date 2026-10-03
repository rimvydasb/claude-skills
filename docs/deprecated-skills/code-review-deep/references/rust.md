# Rust Review Checks

Apply these checks in addition to the general lenses of `code-review-deep`.

## General Rust

- **Logic Fragility:** `unwrap()`, `expect()`, and `panic!` on paths that input can reach; `Result` values ignored with
  `let _ =`; partial writes; unhandled async cancellation.
- **Enforcement vs. Hope:** invariants that the Type-State pattern, newtypes, private fields, or constructors returning
  `Result` could enforce instead of runtime checks or comments.
- **Structural Inconsistency:** domain modules that depend on I/O, serialization, or adapter crates.

## WASM Targets

Apply this section when the crate targets WASM: a `wasm32` target, `wasm-bindgen`, `wasm-pack`, or project priorities in
`CLAUDE.md` that say so. Priorities in `CLAUDE.md` override the defaults below.

### Default Priorities

1. **Small WASM Size First:** The primary goal is small WASM binary size.
2. **Small Stack Size Second:** Optimize for low stack usage in WASM environments.
3. **Performance Third:** Optimize for speed only after size and stack considerations are met.
4. **Maintainability** and code clarity are important but secondary to the above goals.

Some decisions that seem to increase cognitive load or add complexity are justified when they significantly reduce WASM
size or stack usage. Always weigh trade-offs against these priorities.

### Memory and Stack Profiling

- Where does the code allocate on the heap (`Box`, `Vec`, `String`) when a stack-allocated or zero-copy alternative
  (`&str`, slices) is sufficient?
- Which recursive functions or deep call chains threaten the WASM stack limit?

### Strict Constraints

Do NOT suggest common Rust patterns if they introduce binary bloat:

- **No Heavy Error Handling:** Do not suggest `anyhow` or `eyre`. Expect and evaluate lightweight, custom `enum` error
  types.
- **Monomorphization Awareness:** Flag excessive use of generics or large trait objects (`dyn Trait`) that duplicate code
  or inflate the vtable.
- **Formatting Bloat:** Flag usage of `format!()`, `to_string()`, or heavy `#[derive(Debug)]` implementations that leak
  into the final WASM binary.
- **Dependency Audit:** If the code uses heavy crates (for example `serde` without `alloc`, `regex`), suggest lightweight
  WASM-friendly alternatives.

### Evidence

- Report a WASM size or stack concern only when you can name the concrete construct: the generic, the `format!` call,
  the recursive function.
- Do not state byte sizes you have not measured.
