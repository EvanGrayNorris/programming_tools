using PlotlyJS

function dipole(m,x)
    x *= 2*pi/360
    if m == 0
        return 3/(8*pi)*sin(x)^2
    elseif abs(m) == 1
        return 3/(16*pi)*(1+cos(x)^2)
    end
end

angle = 0:1:360
rad = dipole.(-1,angle)
plot(

    scatterpolar(r=rad, theta=angle, mode="markerss",),

    #Layout(polar=attr(angularaxis_direction="counterclockwise", sector=(0, 360)))

)