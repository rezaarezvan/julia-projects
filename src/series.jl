# series
using CairoMakie, Random, LaTeXStrings
path   = "C:/Users/Reza/Desktop/juliatesting/media/" # Absolute, change this
CairoMakie.activate!(type = "png")

let
    Random.seed!(123)
    m = 200
    function spiral(; a = 1, n = 100, h = 0, k = 0)
        φ = LinRange(rand() + 1, 6π, n)
        h .+ rand(-1:2:1) * a * cos.(φ) ./ φ, k .+ rand(-1:2:1) * a * sin.(φ) ./ φ
    end
    x = raw"x=a\,\cos(\varphi)/\varphi,\quad "
    y = raw"y=a\,\sin(\varphi)/\varphi,\quad "
    curves = [spiral(; a = rand(), h = rand(-1:1)) for i in 1:m]

    with_theme(theme_minimal()) do
        fig = Figure(resolution = (600, 600))
        ax = Axis(fig[1, 1])
        CairoMakie.series!(curves; color = to_colormap(:Hokusai1, m), linewidth = 1.5)
        text!(latexstring(x * y * "\\varphi>0"), position = (-1, -1))
        hidedecorations!(ax; grid = false)
        display(fig)
        save(path * "series.png", fig)
    end
end;