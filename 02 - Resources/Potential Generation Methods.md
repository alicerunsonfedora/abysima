# Potential Generation Methods

## Recurrent Neural Networks
- Rely on previous and current inputs for training
- Commonly used for: Translation, NLP, Speech Recognition, Image Captioning
- Combinational logic : Neural Network :: Sequential logic : RNN ::
- Parameters shared across network
- Weights adjusted with backpropogation and gradient descent
- Algorithm for back propogation: Backpropogation Through Time (BPTT)
	- Specific to sequence data, works similarly to standard backpropogation
	- Sums errors at each step
- Common problems:
	- Exploding gradient: gradient becomes too large and model becomes unstable
	- Vanishing gradient: gradient becomes too small and weights become insignificant (close to 0)
	- Potential solution: Reduce number of hidden layers
- Different types of RNNs:
	- One-to-one
	- One-to-many
	- Many-to-one
	- Many-to-many
- Common activation methods:
	- Sigmoid
	- Tanh
	- RELU
- Variants:
	- Bidirectional RNN (BRNN): Includes data from future to improve accuracy
	- Long Short Term Memory (LSTM): Use of three gates in 'cells' to control flow of information (see also: [[Long-Short-Term-Memory.pdf]])
	- Gated Recurrent Unites (GRU): Similar to LSTM, uses hidden states with two gates

### Ideal Usage

Given a list of IPA symbols that represents sounds that go together, predict the next sound.

```
[kæ] -> [t]
[kæ] -> [p]
```

## Generative Deep Learning