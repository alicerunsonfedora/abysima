# random_strings.py
# (C) 2021 Marquis Kurt.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

from random import randrange, choice
from string import ascii_lowercase
from time import perf_counter


def new_word(**kwargs) -> str:
    """Generates a random word in the Latin alphabet.
    
    Kwargs:
        min (int): The minimum number of characters the word must have. Defaults to 3.
        max (int): The maximum number of characters the word must have. Defaults to 12.
        syllable (str): A string of C's and V's that describes the syllabic structure of a word. Defaults to "CV"
            (consonant, vowel).

    Returns:
        A word ranging from the minimum to the maximum lengths with the specified structure.
    """
    min_length = kwargs.get("min", 3)
    max_length = kwargs.get("max", 12)
    syllabic_structure = kwargs.get("syllable", "CV")

    if len(syllabic_structure) > min_length:
        min_length = len(syllabic_structure)

    if len(syllabic_structure) > max_length:
        raise ValueError(
            f"Max length cannot be bigger than length of syllable ({len(syllabic_structure)})")

    vowels = "aeiouy"
    consonants = [c for c in ascii_lowercase if c not in vowels]
    word_length = randrange(min_length, max_length, 1)
    pattern = [0 if i == "C" else 1 for i in syllabic_structure]

    result = ""
    syllable_idx = 0
    for _ in range(word_length):
        result += choice(vowels) if pattern[syllable_idx] else choice(consonants)
        syllable_idx += 1
        if syllable_idx >= len(pattern):
            syllable_idx = 0
    return result


if __name__ == "__main__":
    _tick = perf_counter()
    syllables = ["CVCVCV", "CCCVVCCCC", "CVC", "CVVC", "CVVCC", "CCV"]
    dictionary = [
        new_word(min=4, syllable=syllables[i % len(syllables)]) + "\n" for i in range(500)
    ]
    with open("test_dict.txt", "w+") as dict_file:
        dict_file.writelines(dictionary)
    _tock = perf_counter()
    print(f"Written 500 words in {_tock - _tick:0.4f} seconds")
