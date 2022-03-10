using Plots

function kernel(n,q,x)
    if sign(n) == 1
        return ((-1)^q/(factorial(big(q))*factorial(big(q+n))))*(0.5*x)^(n+2*q)
    else
        return ((-1)^q/(factorial(big(q))*factorial(big(q-abs(n)))))*(0.5*x)^(2*q - abs(n))
    end
end

function bessel(n,x)
    return sum(kernel.(n,0:100,x))
end

plot()
for n = 0:2
    x = 0:0.01:20
    plot!(x,bessel.(n,x),label=string("n: ",n))
end
plot!()