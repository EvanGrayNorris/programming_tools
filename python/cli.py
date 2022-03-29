from doctest import OutputChecker
from multiprocessing import pool
from pyexpat import model
import sys
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import models, layers
from tensorflow.keras.callbacks import TensorBoard
import tensorflow.keras.backend as kb
import json
#print the command line arguments

with open("model.json") as f:
    model_struct = json.load(f)

activation_function = model_struct["Hyperparameters"]["activation function"]
print("activation function: {}".format(activation_function) )
epoch_size = model_struct["Hyperparameters"]["epoch size"]
print("{} Epochs".format(epoch_size) )
batch_size = model_struct["Hyperparameters"]["batch size"]
print("Batch Size {}".format(batch_size) )




class FullModelClass():

    def build_dynamic_model(self, image_input):
        x = image_input
        for i in range(len(model_struct["Convolution Layers"])):
            N_filters = model_struct["Convolution Layers"]["layer{}".format(i)]["Convolution"]["Filters"]
            pooling_size = model_struct["Convolution Layers"]["layer{}".format(i)]["Convolution"]["pool size"]
            padding_size = model_struct["Convolution Layers"]["layer{}".format(i)]["Convolution"]["padding"]
            x = layers.Conv2D(N_filters, (pooling_size,pooling_size), padding=padding_size)(x)
            x = layers.Activation(activation_function)(x)
            if model_struct["Convolution Layers"]["layer{}".format(i)]["Pooling"]["apply"] == 1:
                pooling_size = model_struct["Convolution Layers"]["layer{}".format(i)]["Pooling"]["pool size"]
                layers.MaxPooling2D(pool_size=(pooling_size,pooling_size))(x)
            if model_struct["Convolution Layers"]["layer{}".format(i)]["Dropout"]["apply"] == 1:
                dropout_factor = model_struct["Convolution Layers"]["layer{}".format(i)]["Dropout"]["dropout factor"]
                x = layers.Dropout(dropout_factor)(x)
        x = layers.Flatten()(x)

        for i in range(len(model_struct["Fully Connected Layers"])):
            neurons = model_struct["Fully Connected Layers"]["layer{}".format(i)]["Neurons"]
            x = layers.Dense(neurons)(x)
            x = layers.Activation(activation_function)(x)

        output = layers.Dense(101)(x)
        return output

    def assemble_model(self, width, height, num_extra_feature):
        input_shape = (height, width, 1)
        image_inputs = keras.Input(shape=input_shape, name='img_in')
        model = models.Model(inputs=[image_inputs], outputs=self.build_dynamic_model(image_inputs), name="nolm_model")
        return model


model = FullModelClass().assemble_model(128, 128, 0)
model.summary()