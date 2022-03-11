import matplotlib.pyplot as plt
import numpy as np

if __name__ == "__main__":
    X,Y = np.meshgrid(np.linspace(-5,5,100), np.linspace(-5, 5, 100))
    Z = np.exp(-(((X)**2 / 2) + ((Y)**2 / 2)))

    #plot
    fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
    ax.plot_surface(X,Y,Z)
    plt.show()
    