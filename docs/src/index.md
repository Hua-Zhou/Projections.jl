
# Projections.jl

Projections.jl is a Julia package that collects commonly used projection operators. It is useful for optimization algorithms such as projected gradient descent.

Given a point $y \in \mathbb{R}^n$ and a set $S \subset \mathbb{R}^n$, the projection of $y$ onto $S$ is defined as
$$
    \text{proj}_S(y) = \arg \min_{x \in S} \|y - x\|_2^2.
$$
If $S$ is a closed convex set, then $\text{proj}_S(y)$ is unique.

## Installation

This package requires Julia v0.7 or later. The package has not yet been registered and must be installed using the repository location. Start julia and use the ] key to switch to the package manager REPL
```julia
(v1.0) pkg> add https://github.com/Hua-Zhou/Projections.jl.git
```

Machine information for this tutorial


```julia
versioninfo()
```

    Julia Version 1.0.3
    Commit 099e826241 (2018-12-18 01:34 UTC)
    Platform Info:
      OS: macOS (x86_64-apple-darwin14.5.0)
      CPU: Intel(R) Core(TM) i7-6920HQ CPU @ 2.90GHz
      WORD_SIZE: 64
      LIBM: libopenlibm
      LLVM: libLLVM-6.0.0 (ORCJIT, skylake)
    Environment:
      JULIA_EDITOR = code


## Basic usage

This package provides two functions for a set $s$,
```julia
project!(s, v, y)
```
overwrites `v` by projection of `y` to set `s`. 
```julia
project(s, y)
```
simply returns projection of `y` to set `s`.

## Projection operators


```julia
using Projections
```

### Box

Projection of $y$ onto a closed box $S = [a_1, b_1] \times \cdots \times [a_n, b_n]$ is
$$
    \text{proj}_S(y)_i = \begin{cases}
    a_i & y_i < a_i \\
    y_i & y_i \in [a_i, b_i] \\
    b_i & y_i > b_i
    \end{cases}.
$$


```julia
y = [-2.5, -1.5, -0.5, 0.0, 0.5, 1.5, 2.5]
a = fill(-1.0, 7) # vector of all -1
b = fill( 1.0, 7) # vector of all  1
project(Box(a, b), y)
```




    7-element Array{Float64,1}:
     -1.0
     -1.0
     -0.5
      0.0
      0.5
      1.0
      1.0



## Contributing

You are welcome to contribute to the Projections.jl package. To add a projection operator, e.g., projection to the affine set, to the package, follow these steps:

0. Fork the Projections.jl package.  
0. Add `affine.jl` to the `src` folder that implements the type `Affine`, the function `project!(s::Affine, v, y)`, and the function `project(s, y)`. 
0. Add a line `include("affine.jl")` to the `/src/Projections.jl` file.
0. Add test file `affine_test.jl` to the `test` folder.
0. Add a line `include("affine_test.jl")` to the `/test/runtests.jl` file.  
0. Make sure that `Pkg.test("Projections")` successfully runs.
0. Add documentation for the new projection operator to the `Projection operators` section of Jupyter notebook `/docs/Projections.jl`. 
0. Issue a pull request.
