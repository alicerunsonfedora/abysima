# Project Abysima: Determining Word Validity to Generate Random Words for a New Language

Language is one of the most complex and powerful tools humankind has designed and used for centuries. Being able to communicate ideas in such a way that other have agreed upon using sounds and symbols is incredible. This powerful tool has let us discuss research and ideas for experimentation, leading us to new technologies like machine learning. Over the years, we've designed and engineered many machine learning algorithms that can redraw images in a particular style, create or extend music, and even write stories that can be used for video games. Given that we can create these generative networks, this begs the question whether we can utilize machine learning to create languages. The task would be very daunting and take longer than a semester to study, so I instead proposed an experiment where I generated words against a machine learning model to validate them as possible words in a given language (aka. "sniglets").

## Background
Machine learning models are specialized algorithms that attempt to emulate how the human brain works when learning new data. Fundamentally, these algorithms utilize various mathematical operations with matrices and vectors to accomplish this. When a model is given an input to predict, it will attempt to perform those mathematical operations to determine a specific type of output. While engineers and data scientists know that the model will perform these operations, the order in which they are applied, as well as what numbers the model will use, are hidden from the engineers.

## Methods
I started the experiment by gathering a large list of words in the English and Japanese language and random strings between three and eight letters in length. Gathering two languages for the dataset was crucial in making sure the network would perform with different language rules in mind; choosing English and Japanese words were arbitrary. For each string or word in the list, I marked as either "valid" or "invalid"; after marking them, I shuffled the dataset to make sure the invalid and valid words were scattered about. Next, I broke down the words into their individual letters and put them into separate columns; for words that were less than eight letters in length, I padded the rest of the word with asterisks (\*). This padding is important because the networks that I will be using required that all the words be the same length; adding asterisks gets around this while making sure the words remain the same length. The result is a large table of nine columns: the first eight correspond to the letters in the word, and the last column corresponds to its marking (see Figure 1).

| char01 | char02 | char03 | char04 | char05 | char06 | char07 | char08 | Valid   |
| :----: | :----: | :----: | :----: | :----: | :----: | :----: | :----: | :------ |
| v      | f      | t      | *      | *      | *      | *      | *      | invalid |
| f      | y      | u      | t      | *      | *      | *      | *      | invalid |
| a      | l      | l      | o      | v      | e      | r      | *      | valid   |

> Figure 1: A small table that shows how the dataset is created. 

I then split the dataset into two groups: the training data, which will be used to train the networks, and the testing data, which will be used to evaluate the effectiveness of the network. The training data contains eighty percent of the dataset, whereas the testing set will contain the remaining twenty percent. This split is done as a way to mitigate overfitting, where the model overcorrects itself or memorizes the data. I then settled on creating three different models that I will compare to determine the best validator: a fully-connected neural network, a recurrent neural network, and an automatically-generated model using Apple's Create ML tool.

A fully-connected neural network (FCNN) is the most common type of machine learning model in which all the "nodes" in the network are connected to each other. Most fully-connected neural networks will assume that the input data provided is independent of other data and will try to create a generalized equation. For this experiment, I utilized the Keras and Tensorflow Python libraries to create a FCNN with an input layer with eight nodes (corresponding to the characters), a hidden layer with thirty-two nodes, and a single output layer with one node. To ensure I keep the output within the range of zero (invalid) to one (valid), I utilized the sigmoid activation function, a mathematical equation that transforms the output data.

Recurrent neural networks (RNN) extend from FCNNs, with some major differences. RNNs treat the input data will be a sequence; that is, each part of the input comes immediately after the next. An article from the International Business Machines (IBM) Cloud Learning Hub in 2020 notes that these types of networks are commonly used for natural language processing and speech recognition (IBM, para 1). For this experiment, I created a variation of the RNN known as the Long Short-Term Memory network (LSTM). Sepp Hochriter and Jürgen Schmidhuber researched and designed the network in 1997 to improve on the RNN model by adding in additional checks ("gates") and parameters to ensure that the network would learn properly (Hochriter and Schmidhuber, pp. 1-2). To create the LSTM, I used Keras again, specifying an input layer, a hidden LSTM layer, and an output layer; I used very similar parameters to the FCNN.

Finally, I used Apple's Create ML tool to generate a machine learning model, which I will refer to as the "Apple CoreML Model" or the "CoreML Model" for short. The Create ML tool is a developer tool included in the Xcode suite of developer tools, designed to let developers quickly make machine learning models that can be imported into apps for the iPhone, iPad, Apple Watch, Apple TV, and the Mac. When creating this model, I let the app automatically pick the best algorithm for the dataset and did not specify any parameters, unlike the previous networks. I would then download the model from the app and load it into the same playground as the other two networks.

After creating the models, I evaluated each of them by having them predict whether the words in the testing set were valid. During the process, I would record how accurate they were and how much they were failing (aka. "loss"); it is important to note that these two metrics are not directly related to each other. I would then take the results and display them graphically with a graph, the confusion matrix, that shows how many predictions were made in the following categories: true positive, true negative, false positive, and false negative. Finally, I would assess which model performed the best and use it to validate words that were randomly generated.

## Analysis

Figure 2 shows the confusion matrices for each of the machine learning models I designed, trained, and evaluated for five-hundred epochs (iterations). The RNN, despite being ideal for sequential data, performed very poorly, with an accuracy rate of 64% (see Figure 3) and reporting a lot of false negatives. The FCNN, however, performed much better, with an accuracy score of 82%. The Apple CoreML model scored the highest with an accuracy of 92.15% and reporting half as many false negatives and false positives as the FCNN.

![[output.png|Figure 2]]

> Figure 2: The confusion matrices for each of the different machine learning models. The top left box in each represents the number of correctly-predicted for true negatives, and the bottom right box represents the number of correctly-predicted true positives.

| Network      | Accuracy Rate | Loss Rate |
| -----------: | ------------- | --------- |
| FCNN         | 82.21%        | 39.53%    |
| RNN          | 64.28%        | -[^1]     |
| Apple CoreML | 92.15%        | 7.85%     |

> Figure 3: A table that shows the accuracy rates and loss rates for various machine learning models.

Upon inspecting the Apple CoreML model, I discovered that the app decided to use a logistic regression model, which assumed that the input was linear and that adding the probabilities of each letter together would determine the validity of the word. Logistic regression also works well with binary classification, which the validity problem falls under. Additionally, the network only needed to be trained for ten iterations before reaching its maximum accuracy rate. As a side note, on an initial test of filtering out invalid words from a small sample of sniglets, the Apple CoreML model filtered out nearly two-thirds of the list, keeping about 150 words total. Finally, some words generated when running the final test can be seen in Figure 4.

| Generated Words | Feasibility As Word |
| --------------: | ------------------- |
| kapuce          | Feasible            |
| gjzeigg         | Not feasible        |
| bosle           | Feasible            |
| teaz            | Feasible            |
| tuyzs           | Not feasible        |
| paziry          | Feasible            |
| ghjoitz         | Not feasible        |
| patni           | Feasible            |
| pain            | Is a real word      |
| fyevz           | Not feasible        |

> Figure 4. A list of words generated and validated by the Apple CoreML model. "Feasibility" derives from a personal analysis of the words.

## Conclusion

Despite the successes in this small experiment, however, there are some things I would've like to improve upon in the future. If I had more time on this project, I would've looked into ways of using these words to create phrases and establish syntactic rules for them. Additionally, I would've likely spent more time diagnosing the RNN, since it seemed to perform very poorly; I may have formatted the data in a way that made the RNN perform less optimally.

With that said, I conclude that, through this experiment, it is somewhat possible to make a machine learning model that can validate words to an extent. The Apple CoreML model can predict sniglets as possible words in the English and/or Japanese languages with 92% accuracy, and it was able to assist in creating a small corpus containing five-hundred sniglets by validating words a random string generator created. This model could be used to make a more natural spell checking system or help authors create new words in their creative writing. By no means will this network create a full language with all the complexities and nuances of rules that linguists discover and research on a daily basis, but it is a small step in creating something much larger.

## Works Cited

“Appendix:1000 Japanese Basic Words.” _Wiktionary_, 23 Aug. 2021. _Wiktionary_, https://en.wiktionary.org/w/index.php?title=Appendix:1000_Japanese_basic_words&oldid=63736536.

_Create ML_. 3.0 (78.6), Apple Inc., 2021, https://developer.apple.com/machine-learning/create-ml/.

_TensorFlow_. 2.6.0, Google Inc., 2021, https://tensorflow.org.

Vennerød, Christian Bakke, et al. “Long Short-Term Memory RNN.” _ArXiv:2105.06756 [Cs]_, May 2021. _arXiv.org_, http://arxiv.org/abs/2105.06756.

“What Are Recurrent Neural Networks?” _IBM Cloud Learning Hub_, IBM Cloud Education, 14 Sept. 2020, https://www.ibm.com/cloud/learn/recurrent-neural-networks.

[^1]: The loss rate for this network resulted in a non-numeric value, likely indicating it reached too high of a loss value.