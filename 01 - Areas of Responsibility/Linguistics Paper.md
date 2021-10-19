# Project Abysima and the Difficulties of Designing Generative Neural Networks for Natural Languages

```ad-note
title: Before You Begin: Work in Progress

The following paper is incomplete due to the ongoing research and experimentation for this particular project. Additionally, this document does not currently conform to MLA or APA guidelines, but this will be corrected in the final draft of this paper. The primary purpose of this draft is to outline the components necessary to make the piece work and to provide a starting point for when the research is complete. Additionally, transitions are virtually non-existent given that some paragraphs may be shuffled around for future revisions. Consider this a very, _very_ rough draft.

_Please do not "red-pen" this draft or note formatting errors, as these will be disregarded._
```

Language is one of the most complex and powerful tools mankind has designed and used for centuries. Being able to communicate ideas in a way that other have agreed upon using sounds and symbols is incredible. This incredibly powerful tool has let us discuss research and ideas for experimentation, leading us to new technologies like machine learning. Over the years, we've designed and engineered many machine learning algorithms that can redraw images in a particular style, create or extend music, and even write stories that can be used for video games. Given that we can create these generative networks, this begs the question, which I aim to answer: _can we use machine learning to generate a language the same way we do for art and music?_

## Methods

Creating a machine learning algorithm that attempts to define phonological rules seemed like a good start, and the initial proposal for this experiment attempted to make use of a recurrent neural network to create this kind of algorithm. According to an article from the IBM Cloud Learning Hub in 2020 describes a recurrent neural network as a type of neural network that uses sequential or time series data ("What are recurrent neural networks?", para. 1). IBM also states that these types of networks are commonly used for natural language processing and speech recognition (para 1). A common variant is the Long Short-Term Memory network, proposed and designed by Sepp Hochriter and Jürgen Schmidhuber in 1997; this recurrent neural network resolves common errors by "enforcing constant error flow through internal states of special units" (Hochriter and Schmidhuber, pp. 1-2). Ideally, this type of network could be used to generate a phonological rule based on examples found in other languages. However, this method proved to be difficult to both conceptualize and generate a dataset for training, so this method was discarded.

Thankfully, an alternate solution was proposed: creating a neural network that could predict whether a given word is close enough to other languages. While it is unlikely that the network will be able to detect nuances such as syllabic structure, this could give insight onto how to best encode words and other morphemes for generation purposes. To provide a list of valid words, Rachael Tatman's English Word Frequency dataset on Kaggle and Wiktionary's Japanese Basic Words list were combined and parsed accordingly. To provide incorrect and invalid examples, a random word generator script was used. 

The words were then encoded in a format that the neural network can comprehend and use for training accordingly. To make sure the sizes of the inputs were consistent, extra numbers were added at the end until it matched the length of the longest word. For instance, if the longest word was thirty characters long, and a word if five characters long, twenty-five zeros were added after the five encoded characters. Doing this ensured that the network would be trained regardless of word length. The dataset was then split into traning, validation, and testing sets to help prevent overcorrection of memorization of the data (overfitting).

Next, the model would be trained on the training set using a batch gradient descent algorithm. After every batch, the network would validate its accuracy against the validation set and re-run the algorithm. If the accuracy remained the same after five iterations of this process, the training would stop. The testing set was then used to validate the entire process before using a sample dictionary to filter out invalid words.

## Analysis

TODO, this section is heavily reliant on the experiment to be complete for this paragraph to be written.

## Conclusion
TODO, this section will rely on the analysis to provide a conclusion that opens academic discussion on the topic.

## Sources

“Appendix:1000 Japanese Basic Words.” _Wiktionary_, 23 Aug. 2021. _Wiktionary_, https://en.wiktionary.org/w/index.php?title=Appendix:1000_Japanese_basic_words&oldid=63736536.

Tatman, Rachael. “English Word Frequency.” _Kaggle_, 6 Sept. 2017, https://kaggle.com/rtatman/english-word-frequency.

Vennerød, Christian Bakke, et al. “Long Short-Term Memory RNN.” _ArXiv:2105.06756 [Cs]_, May 2021. _arXiv.org_, http://arxiv.org/abs/2105.06756.

“What Are Recurrent Neural Networks?” _IBM Cloud Learning Hub_, IBM Cloud Education, 14 Sept. 2020, https://www.ibm.com/cloud/learn/recurrent-neural-networks.