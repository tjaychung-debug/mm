# umm

**A dense, function-first language for competitive programming. Written in C. Compiles to plain C for submission.**

```
+++
n..
v[n]..
'(v)
v...
M(v), m(v), S(v)...
```
Read `n`, read `n` numbers, sort, print, then print max, min and sum. Six lines, no braces, almost no Shift key.

**▶ IDE: https://tjaychung-debug.github.io/umm/** — run, autocomplete, grammar sheet (F1), and one-click conversion to a single submittable C file.

---

## Why

- **Dots are I/O.** `a.` declares, `a..` declares and reads, `a...` prints. `a, b, c..` reads three values.
- **Shapes are control flow.** `(c)` if · `((c)` else-if · `())` else · `(i, n)-` for · `.(c)` while · `-(x, v)` for-each · `--` break · `-` continue.
- **Capitals are built-ins.** `M m G g S R U L H B P Pw Cr Dj Bf Fw Tp Kr …` — the algorithms you would otherwise paste from a template.
- **Indentation is the block.** No braces, no semicolons (allowed if you want two statements on one line).
- **Digits after a name are precision.** Names never contain digits, so `avg3...` prints `avg` with 3 decimals.
- **One runtime, two backends.** The same C runtime is compiled to WebAssembly for the IDE and pasted into the generated C, so the browser and the judge print the same thing.

## Cheat sheet

| | umm | C++ |
|---|---|---|
| declare / read / print | `a.` `a..` `a...` | `ll a=0;` `cin>>a;` `cout<<a<<'\n';` |
| read an array / grid | `v[n]..` `w[n][m]..` | loops of `cin` |
| constant | `.N = 100` | `const int N = 100;` |
| swap | `a, b = b, a` | `swap(a, b);` |
| if / else-if / else | `(x > 0)` `((x == 0)` `())` | `if … else if … else` |
| switch | `((x))` then `1:` … `_:` | `switch` (no fallthrough) |
| for | `(i, n)-` `(i, a, b, step)-` `(i = 0; i < n; i++)-` | `for` |
| while / do-while | `.(c)` / `.()` … `.(c)` | `while` / `do … while` |
| for-each | `-(x, v)` | `for (auto x : v)` |
| break / continue | `--` / `-` | |
| function | `add-(a, b)` ⏎ `.... a + b` | `ll add(ll a, ll b)` |
| reference / default | `f-(_a, b=10)` | `ll &a, ll b = 10` |
| lambda | `-(a, b) a > b` | `[](…){ return a > b; }` |
| sort asc / desc / custom | `'(v)` `''(v)` `'(v, cmp)` | `sort` |
| size / substr / find / replace-all | `s'(x)` `s''(s,i,k)` `s'''(s,t)` `s''''(s,a,b)` | |
| push / pop / top | `v += x` `Po(v)` `T(v)` | |
| queue / heap / min-heap | `Q()` `PQ()` `PQ(m)` | |
| set / map | `ST()` `MP()` · `st -= x` · `In(st, x)` | `set` `map` |

**Built-ins:** `M m` max/min · `G g` gcd/lcm · `S` sum · `Ps` prefix sum · `R` reverse · `U` sort+unique · `C` count · `N` next permutation · `L H B` lower/upper bound, binary search · `P Sv` prime test, sieve · `Pw Cr` modpow, nCr · `Fc` factorize · `Ab Sq` · `A(n, x)` `A(n, m, x)` filled lists · `I D St O Ch` conversions · `Lis Lcs Kn Pal Kmp` · `Bf Df Dj Fw Tp` graphs · `Uf Fd Un` union-find · `Kr` MST · `Rl` read line.

The full table with examples is inside the IDE (F1).

## Example: shortest path

```
n, e, s..
adj = A(n, [])
(i, e)-
  u, v, w..
  adj[u] += [v, w]
Dj(adj, s)...
```

## Build

```sh
./build.sh            # needs gcc, clang (wasm32 target), python3
bin/dot run file.um < input.txt
bin/dot c file.um > main.c     # single-file C for the judge
tests/run.sh          # interpreter output == compiled C output
```

| path | |
|---|---|
| `src/rt.c` | runtime: values, containers (treap set/map, heap, deque), I/O, built-in algorithms |
| `src/dot.c` | lexer (indentation), parser, name resolution |
| `src/back.c` | tree-walking interpreter and C code generator |
| `web/index.template.html` | the IDE; `tools/mkweb.py` embeds the wasm into `index.html` |

## Notes

- Integers are 64-bit; `/` between integers truncates like C.
- Memory is never freed (fine for judge-sized programs).
- Deep recursion is limited in the browser; the generated C has the native stack.
