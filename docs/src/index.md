
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

### Ball

Projection of $y$ onto the closed ball $S = \{x \in \mathbb{R}^n: \|x - c\|_2 \le r\}$ is
$$
    \text{proj}_S(y)_i = \begin{cases}
    c + r \frac{y - c}{\|y - c\|_2} & \|y - c\|_2 > r \\
    y & \|y - c\|_2 \le r
    \end{cases}.
$$


```julia
y = [-2.5, -1.5, -0.5, 0.0, 0.5, 1.5, 2.5]
# norm is less than 5
sqrt(sum(abs2, y)) 
```




    4.183300132670378




```julia
# projection onto the unit ball
project(Ball(length(y)), y)
```




    7-element Array{Float64,1}:
     -0.5976143046671968 
     -0.3585685828003181 
     -0.11952286093343936
      0.0                
      0.11952286093343936
      0.3585685828003181 
      0.5976143046671968 




```julia
# projection onto ball with center 0 and radius 5
project(Ball(length(y), 5.), y)
```




    7-element Array{Float64,1}:
     -2.5
     -1.5
     -0.5
      0.0
      0.5
      1.5
      2.5




```julia
# projection onto ball with center (1,...,1) and radius 1
project(Ball(ones(length(y)), 1.), y)
```




    7-element Array{Float64,1}:
     0.29289321881345254
     0.4949237277238947 
     0.6969542366343369 
     0.7979694910895578 
     0.8989847455447789 
     1.101015254455221  
     1.3030457633656631 



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
