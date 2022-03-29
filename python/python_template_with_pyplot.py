import matplotlib.pyplot as plt
import numpy as np
import os

#set path to current directory
path = os.path.dirname(os.path.realpath(__file__))
#data is located at /path/to/current/directory/data
data_path = os.path.join(path, "data")
compound_data_path = os.path.join(path, "compoundData")
print(data_path)

if __name__ == "__main__":
    X,Y = np.meshgrid(np.linspace(-5,5,100), np.linspace(-5, 5, 100))
    Z = np.exp(-(((X)**2 / 2) + ((Y)**2 / 2)))

    #plot
    fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
    ax.plot_surface(X,Y,Z)
    plt.show()
    