import numpy as np
import matplotlib.pyplot as plt


class Neuron:
    def __init__(self, n_inputs, bias=0., weights=None):
        self.b = bias
        if weights is not None:
            self.ws = np.array(weights)
        else:
            self.ws = np.random.rand(n_inputs)

        # Store inputs and outputs for backpropagation
        self.last_input = None
        self.last_output = None

    def _f(self, x):  # activation function (here: leaky_relu)
        return np.maximum(x * 0.1, x)

    def _f_derivative(self, x):  # derivative of the leaky_relu
        return np.where(x > 0, 1, 0.1)

    def __call__(self, xs):  # forward pass
        self.last_input = xs
        z = xs @ self.ws + self.b
        self.last_output = self._f(z)
        return self.last_output


class Layer:
    def __init__(self, n_neurons, n_inputs_per_neuron):
        self.neurons = [Neuron(n_inputs_per_neuron) for _ in range(n_neurons)]

    def __call__(self, inputs):
        outputs = np.array([neuron(inputs) for neuron in self.neurons])
        return outputs


class NeuralNetwork:
    def __init__(self, layer_sizes):
        self.layers = []
        for i in range(1, len(layer_sizes)):
            self.layers.append(Layer(layer_sizes[i], layer_sizes[i - 1]))

    def __call__(self, inputs):
        for layer in self.layers:
            inputs = layer(inputs)
        return inputs

    def visualize(self):
        # Visualization of the network structure
        fig, ax = plt.subplots(figsize=(10, 5))

        layer_sizes = [len(self.layers[0].neurons[0].ws)] + [len(layer.neurons) for layer in self.layers]
        v_spacing = 1
        h_spacing = 2

        # Nodes
        for i, layer_size in enumerate(layer_sizes):
            for j in range(layer_size):
                x = i * h_spacing
                y = j * v_spacing
                ax.add_patch(plt.Circle((x, y), 0.1, color='blue' if i < len(layer_sizes) - 1 else 'green'))
                if i == 0:
                    ax.text(x - 0.4, y, f'Input {j + 1}', ha='center', va='center')

        # Edges
        for i, (layer_size_a, layer_size_b) in enumerate(zip(layer_sizes[:-1], layer_sizes[1:])):
            for j in range(layer_size_a):
                for k in range(layer_size_b):
                    x1, y1 = i * h_spacing, j * v_spacing
                    x2, y2 = (i + 1) * h_spacing, k * v_spacing
                    ax.plot([x1, x2], [y1, y2], 'k-')

        ax.set_aspect('equal')
        ax.axis('off')
        plt.show()


nn = NeuralNetwork([3, 4, 4, 1])
nn.visualize()
