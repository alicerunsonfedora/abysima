# parse_jp.py
# (C) 2021 Marquis Kurt.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# This file will read the source of the 1000 Japanese basic words page from
# https://en.wiktionary.org/wiki/Appendix:1000_Japanese_basic_words and pull out the words written in Romaji, which
# will be written to a file for use in the neural network.

import re

with open('1000-Japanese-basic-words.wiki', 'r') as jp_file:
    lines = [line.strip() for line in jp_file.readlines() if line.startswith("*")]

pattern = re.compile(r"(''(\w+)'')")

words = []
for line in lines:
    dat = line.split(" – ")
    if len(dat) != 2: continue

    _, last = tuple(dat)
    results = pattern.findall(last)

    if len(results) < 1: continue
    _, word = results[0]

    # Replace long sounds here since ascii_lowercase doesn't contain them.
    words.append(
        word.replace("ō", "ou")
            .replace("ī", "ii")
            .replace("ā", "aa")
            .replace("ū", "uu")
            .replace("ē", "ee")
    )

with open("jp-romaji.txt", "w+") as jp_clean:
    jp_clean.writelines([w + "\n" for w in words])