using .PlotlyJS

println("Good to go!")

function Base.display(::Display, p::PlotlyJS.SyncPlot)
    id = isempty(current[]) ? p.plot.divid : current[]
    # Pages.broadcast("script","""Plotly.newPlot("$(id)",$(p.plot.data),$(p.plot.layout),{displayModeBar: false});""")
    Pages.broadcast("script","""Plotly.newPlot("$(id)",$(p.plot.data),$(p.plot.layout));""")
end