# rnn-benchmarks

All benchmarks are reported for a host with the following specifications :
   * NVIDIA GeForce GTX TITAN X GPU 
   * Intel(R) Xeon(R) CPU E5-2630L v3 @ 1.80GHz
   * CUDA 7.5, cudnnv5

These benchmarks compare the running time of various recurrent neural networks on different deep-learning libraries.
The networks (RNN or LSTM) take as input a 3D Tensor `batch_size x seq_length x hidden_size`
and output the last hidden state, compute a MSE loss, backpropagate the errors through the network and do a simple update of the parameters (`params = params - lr*gradParams`). 
The sequence length is always set to `30`. 
The `hidden_size` specifies the size of the output and input layer of the networks.

The code of the scripts we ran are available. 
The implementations of each model on the different libraries each use 
the fastest implementations we were able to find. 
If you are aware of faster implementations, please let me know. 
I've reported results on Theano, Torch and TensorFlow so far, but we will try to include many more libraries in the future (including cudnn very soon).

The reported `Train` time is the average time needed to run (forward, backward, and update) a training example (and not a training batch), so the smaller the better.
We also report `Compile` time, which includes symbolic graph optimizations (Theano and TensorFlow compilation), as well as a forward and backward pass (to allocate memory).
While the compilation time isn't really a factor in production, it does increase debugging time, which is why we report it here.

## LSTM

This LSTM implementation used for these benchmarks does not use peephole connections between cell and gates.

### Batch Size 32

#### Hidden Size 128

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 7.46 | 289.6 | 99.1 |
| Torch  | 0.03 | 434.4 | 99.9 |
| TensorFlow | 3.91 | 820.0 | 266.7 |


#### Hidden Size 512

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 7.59 | 619.4 | 200.9 |
| Torch  | 0.19 | 610.7 | 201.7 |
| TensorFlow | 3.97 | 886.9 | 324.9 |


#### Hidden Size 1024

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 9.62 | 1013.5 | 324.1 |
| Torch  | 0.69 | 1139.8 | 346.3 |
| TensorFlow | 3.81 | 1329.2 | 562.7 |


### Batch Size 128

#### Hidden Size 128

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 7.38 | 102.9 | 25.6 |
| Torch  | 0.03 | 109.8 | 25.2 |
| TensorFlow | 3.68 | 188.6 | 65.0 |


#### Hidden Size 512

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 7.50 | 256.0 | 62.8 |
| Torch  | 0.20 | 214.3 | 51.4 |
| TensorFlow | 3.73 | 255.2 | 114.2 |

#### Hidden Size 1024

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 7.45 | 583.4 | 160.2 |
| Torch  | 0.75 | 558.1 | 112.4 |
| TensorFlow | 3.84 | 592.2 | 238.1 |


## RNN

This section benchmarks a simple RNN implementation.

### Batch Size 32

#### Hidden Size 128

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 4.31 | 104.6 | 30.9 |
| Torch  | 0.05 | 259.53 | 103.06 |
| TensorFlow | 1.64 | 278.4 | 111.5 |

#### Hidden Size 512

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 4.36 | 275.2 | 102.2 |
| Torch  | 0.05 | 288.2 | 114.6 |
| TensorFlow | 1.62 | 349.7 | 218.4 |

#### Hidden Size 1024

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 4.44 | 443.8 | 179.5 |
| Torch  | 0.09 | 381.4 | 118.8 |
| TensorFlow | 1.72 | 530.0 | 241.7 |

### Batch Size 128

#### Hidden Size 128

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 4.48 | 45.4 | 13.7 |
| Torch  | 0.08 | 67.7 | 32.7 |
| TensorFlow | 1.70 | 75.5 | 33.6 |

#### Hidden Size 512

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 4.40 | 79.0 | 23.8 |
| Torch  | 0.09 | 73.5 | 34.2 |
| TensorFlow | 1.63 | 125.6 | 86.8 |

#### Hidden Size 1024

| Library | Compile (s) | Train (µs) | Forward only (µs) |
| ------------- | ------------- | ------------- | ------------- |
| Theano | 4.38 | 147.8 | 50.3 |
| Torch  | 0.13 | 150.2 | 64.7 |
| TensorFlow | 1.70 | 222.5 | 137.8 |
