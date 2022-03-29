import json

from jinja2 import ModuleLoader

with open("model.json") as f:
    model_struct = json.load(f)

N_convolution_layers = len(model_struct["Convolution Layers"])
print(N_convolution_layers)

N_connected_layers = len(model_struct["Fully Connected Layers"])
print(N_connected_layers)

for i in range(len(model_struct["Convolution Layers"])):
    print("Layer {}".format(i))
    #print(model_struct["Convolution Layers"]["layer{}".format(i)])
    if model_struct["Convolution Layers"]["layer{}".format(i)]["Pooling"]["apply"] == 1:
        print("Pool Size: {}".format(model_struct["Convolution Layers"]["layer{}".format(i)]["Pooling"]["pool size"]))
    else:
        print("No Pooling")
    
    if model_struct["Convolution Layers"]["layer{}".format(i)]["Dropout"]["apply"] == 1:
        print("Dropout Factor: {}".format(model_struct["Convolution Layers"]["layer{}".format(i)]["Dropout"]["dropout factor"]))
    else:
        print("No dropout")

    print("{} Filters".format(model_struct["Convolution Layers"]["layer{}".format(i)]["Convolution"]["Filters"]))
    print("Pool Size: {}".format(model_struct["Convolution Layers"]["layer{}".format(i)]["Convolution"]["pool size"]))
    print("Padding: {}".format(model_struct["Convolution Layers"]["layer{}".format(i)]["Convolution"]["padding"]))