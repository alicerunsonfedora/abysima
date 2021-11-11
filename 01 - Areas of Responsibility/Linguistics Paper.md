# Project Abysima: Determining Word Validity to Generate Random Words for a New Language

Language is one of the most complex and powerful tools humankind has designed and used for centuries. Being able to communicate ideas in such a way that other have agreed upon using sounds and symbols is incredible. This powerful tool has let us discuss research and ideas for experimentation, leading us to new technologies like machine learning. Over the years, we've designed and engineered many machine learning algorithms that can redraw images in a particular style, create or extend music, and even write stories that can be used for video games. Given that we can create these generative networks, this begs the question of whether we can utilize machine learning to create languages. The task would be very daunting and take longer than a semester to study, so I instead proposed an experiment where I generated words against a machine learning model to validate them as possible words in a given language.

## Background
Machine learning models are specialized algorithms that attempt to emulate how the human brain works when learning new data. Fundamentally, these algorithms utilize various mathematical operations with matrices and vectors to accomplish this. When a model is given an input to predict, it will attempt to perform those mathematical operations to determine a specific type of output. While engineers and data scientists know that the model will perform these operations, the order in which they are applied, as well as what numbers the model will use, are hidden from the engineers.

## Methods
I started the experiment by gathering a large list of words in the English and Japanese language and random strings between three to eight letters in length. 

For this experiment, I settled on creating three different models that I will compare to determine the best validator: a fully-connected neural network, a recurrent neural network, and an automatically-generated model using Apple's Create ML tool.

A fully-connected neural network (FCNN) is the most common type of machine learning model in which all of the "nodes" in the network are connected to each other. Most fully-connected neural networks will assume that the input data provided is independent of other data and will try to create a generalized equation.

Recurrent neural networks (RNN) extend from FCNNs, with some major differences. RNNs treat the input data will be a sequence; that is, each part of the input comes immediately after the next. An article from the International Business Machines (IBM) Cloud Learning Hub in 2020 notes that these types of networks are commonly used for natural language processing and speech recognition (IBM, para 1). For this experiment, I created a variation of the RNN known as the Long Short-Term Memory network (LSTM). Sepp Hochriter and Jürgen Schmidhuber researched and designed the network in 1997 to improve on the RNN model by adding in additional checks ("gates") and parameters to ensure that the network would learn properly (Hochriter and Schmidhuber, pp. 1-2).

Finally, I created a 

## Sources

“Appendix:1000 Japanese Basic Words.” _Wiktionary_, 23 Aug. 2021. _Wiktionary_, https://en.wiktionary.org/w/index.php?title=Appendix:1000_Japanese_basic_words&oldid=63736536.

Vennerød, Christian Bakke, et al. “Long Short-Term Memory RNN.” _ArXiv:2105.06756 [Cs]_, May 2021. _arXiv.org_, http://arxiv.org/abs/2105.06756.

“What Are Recurrent Neural Networks?” _IBM Cloud Learning Hub_, IBM Cloud Education, 14 Sept. 2020, https://www.ibm.com/cloud/learn/recurrent-neural-networks.