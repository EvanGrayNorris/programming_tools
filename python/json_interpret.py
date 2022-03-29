import json
import numpy as np

with open("input.json") as f:
    y = json.load(f)

print("Testing {} Models".format(len(y['Models'])))
for i in range(0,len(y['Models'])):
    current_entry = "model{}".format(i)
    print("Model Name: {}".format(y['Models'][current_entry]['Name']))
    print("Model Path: {}".format(y['Models'][current_entry]['Path']))
