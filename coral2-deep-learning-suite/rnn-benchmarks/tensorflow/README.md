#TensorFlow benchmarks

Provided by Maarten Bosma.

I used the build-in rnn libary. ``basic_lstm`` is the Tensorflow equivalent of FastLSTM. 

These results are produced using TensorFlow 0.8, cuda 7.5, cudnnv5, turned off ondemand cpu governor [1], Intel(R) Xeon(R) CPU E5-2630L v3 @ 1.80GHz, Titan X:

To install TensorFlow from source:
   * https://www.tensorflow.org/versions/r0.8/get_started/os_setup.html#installing-from-sources
   * http://stackoverflow.com/questions/34239537/how-to-update-tensorflow-from-source
   
## Fast LSTM



### 30 x 32 x 128

```
$ python rnn.py -n basic_lstm -b 32 -l 128 -s 30
Setup : compile + forward/backward x 1
--- 3.91482686996 seconds
Forward:
--- 32000 samples in 8.53500294685 seconds (3749.266427 samples/s, 0.0002667 s/sample) ---
Forward + Backward:
--- 32000 samples in 26.2391839027 seconds (1219.550125 samples/s, 0.0008200 s/sample) ---
``` 

### 30 x 32 x 512

```
python rnn.py -n basic_lstm -b 32 -l 512 -s 30
Setup : compile + forward/backward x 1
--- 3.97159981728 seconds
Forward:
--- 32000 samples in 10.3965659142 seconds (3077.939414 samples/s, 0.0003249 s/sample) ---
Forward + Backward:
--- 32000 samples in 28.3808200359 seconds (1127.522036 samples/s, 0.0008869 s/sample) ---
``` 

### 30 x 32 x 1024


```
python rnn.py -n basic_lstm -b 32 -l 1024 -s 30
Setup : compile + forward/backward x 1
--- 3.81890392303 seconds
Forward:
--- 32000 samples in 18.0062820911 seconds (1777.157541 samples/s, 0.0005627 s/sample) ---
Forward + Backward:
--- 32000 samples in 42.533454895 seconds (752.348947 samples/s, 0.0013292 s/sample) ---
``` 


### 30 x 128 x 128

```
$ python rnn.py -n basic_lstm -b 128 -l 128 -s 30
Setup : compile + forward/backward x 1
--- 3.68258690834 seconds
Forward:
--- 128000 samples in 8.3175599575 seconds (15389.128621 samples/s, 0.0000650 s/sample) ---
Forward + Backward:
--- 128000 samples in 24.1425020695 seconds (5301.853123 samples/s, 0.0001886 s/sample) ---

``` 

### 30 x 128 x 512

```
python rnn.py -n basic_lstm -b 128 -l 512 -s 30
Setup : compile + forward/backward x 1
--- 3.72586607933 seconds
Forward:
--- 128000 samples in 14.6179850101 seconds (8756.336794 samples/s, 0.0001142 s/sample) ---
Forward + Backward:
--- 128000 samples in 32.6627261639 seconds (3918.840067 samples/s, 0.0002552 s/sample) ---

``` 

### 30 x 128 x 1024

```
python rnn.py -n basic_lstm -b 128 -l 1024 -s 30
Setup : compile + forward/backward x 1
--- 3.84206986427 seconds
Forward:
--- 128000 samples in 30.4814198017 seconds (4199.279457 samples/s, 0.0002381 s/sample) ---
Forward + Backward:
--- 128000 samples in 75.8014390469 seconds (1688.622295 samples/s, 0.0005922 s/sample) ---

``` 

## RNN

### 30 x 32 x 128

```
python rnn.py -n rnn -b 32 -l 128 -s 30
Setup : compile + forward/backward x 1
--- 1.6487121582 seconds
Forward:
--- 32000 samples in 3.56794595718 seconds (8968.745711 samples/s, 0.0001115 s/sample) ---
Forward + Backward:
--- 32000 samples in 8.91037988663 seconds (3591.317139 samples/s, 0.0002784 s/sample) ---
``` 

### 30 x 32 x 512

```
python rnn.py -n rnn -b 32 -l 512 -s 30
Setup : compile + forward/backward x 1
--- 1.62368106842 seconds
Forward:
--- 32000 samples in 6.98823904991 seconds (4579.122118 samples/s, 0.0002184 s/sample) ---
Forward + Backward:
--- 32000 samples in 11.1912858486 seconds (2859.367586 samples/s, 0.0003497 s/sample) ---
``` 

### 30 x 32 x 1024

```
python rnn.py -n rnn -b 32 -l 1024 -s 30
Setup : compile + forward/backward x 1
--- 1.72744393349 seconds
Forward:
--- 32000 samples in 7.73560094833 seconds (4136.718041 samples/s, 0.0002417 s/sample) ---
Forward + Backward:
--- 32000 samples in 16.9597899914 seconds (1886.815816 samples/s, 0.0005300 s/sample) ---
``` 

### 30 x 128 x 128

```
python rnn.py -n rnn -b 128 -l 128 -s 30
Setup : compile + forward/backward x 1
--- 1.698335886 seconds
Forward:
--- 128000 samples in 4.29631710052 seconds (29792.959180 samples/s, 0.0000336 s/sample) ---
Forward + Backward:
--- 128000 samples in 9.66468191147 seconds (13244.098582 samples/s, 0.0000755 s/sample) ---
``` 

### 30 x 128 x 512

```
python rnn.py -n rnn -b 128 -l 512 -s 30
Setup : compile + forward/backward x 1
--- 1.63733696938 seconds
Forward:
--- 128000 samples in 11.1102721691 seconds (11520.869881 samples/s, 0.0000868 s/sample) ---
Forward + Backward:
--- 128000 samples in 16.0786859989 seconds (7960.849538 samples/s, 0.0001256 s/sample) ---
``` 

### 30 x 128 x 1024

```
python rnn.py -n rnn -b 128 -l 1024 -s 30
Setup : compile + forward/backward x 1
--- 1.7014939785 seconds
Forward:
--- 128000 samples in 17.6321749687 seconds (7259.456092 samples/s, 0.0001378 s/sample) ---
Forward + Backward:
--- 128000 samples in 28.4844169617 seconds (4493.685097 samples/s, 0.0002225 s/sample) ---

``` 


 [1] Turning on performance governor: `sudo bash -c 'for i in ls /sys/devices/system/cpu/*/cpufreq/scaling_governor; do echo 'performance' > $i; done;'`
