# phoneme_rules.py
# (C) 2021 Marquis Kurt.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

def parse_file(filepath: str) -> list:
    """Parses the custom IPA rules file into a list of rules. Comments or lines starting with '#' are ignored."""
    rules = []
    with open(filepath, 'r') as file:
        buffer = file.readlines()
    for line in buffer:
        if line.startswith("# "):
            continue
        parts = line.replace("[", "").replace("]", "").strip().split(" -> ")
        rules.append(tuple(parts))
    return rules


def rule_to_row(rule: tuple) -> list:
    """Converts a rule into a list of inputs, followed by the output."""
    input, output = rule
    return [c for c in input] + [output]


def read_rules_as_rows(filepath: str) -> list:
    """Parses an IPA rules file into a matrix of rules as rows."""
    rules = parse_file(filepath)
    return [rule_to_row(row) for row in rules]