module Figures

using Pages, Requires

export figure

const current = Ref{String}("")

struct Display <: AbstractDisplay end

function figure(id::String)
    if tryparse(Int,id) !== nothing
        id = "figure"*id
    end
    global current[] = id
    Pages.broadcast("script","""Figures.Figure("$(id)");""")
end
figure(id) = figure(string(id))

function closeall()
    current[] = ""
    Pages.broadcast("script","Figures.closeall();")
end

function close(id::String)
    if tryparse(Int,id) !== nothing
        id = "figure"*id
    end
    if id == current[]
        current[] = ""
    end
    Pages.broadcast("script","""Figures.close("$(id)");""")
end
close(id) = close(string(id))

function __init__()
    @require PlotlyJS="f0f68f2c-4968-5e81-91da-67840de0976a" include("packages/plotlyjs.jl")

    Get("/") do request::HTTP.Request
        read(joinpath(@__DIR__,"index.html"),String)
    end

    Get("/figures.js") do request::HTTP.Request
        read(joinpath(@__DIR__,"figures.js"),String)
    end

    Get("/d3.min.js") do request::HTTP.Request
        read(joinpath(@__DIR__,"..","libs","d3.min.js"),String)
    end

    Get("/plotly.min.js") do request::HTTP.Request
        read(joinpath(@__DIR__,"..","libs","plotly.min.js"),String)
    end

    @async Pages.start()

    pushdisplay(Display())
end

end