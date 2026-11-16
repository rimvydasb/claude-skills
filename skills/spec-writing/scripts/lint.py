#!/usr/bin/env python3
"""Checks Markdown documents against the mechanical rules of the spec-writing standard.

Usage: lint.py FILE.md [FILE.md ...]
Prints file:line, the rule, and the offending text for each finding.
Exit codes: 0 no findings, 1 at least one finding, 2 usage or file error.

The script checks the fact lane only. It skips fenced code blocks, Mermaid diagrams, table rows,
and the reasoning lane: quote blocks (`> Rationale:`, `> Assumption:`, ...) and the sections
`Design Decisions`, `Context and Gap`, `Open Questions`, and `Risks`. Placeholders are checked
everywhere. Form, precision, completeness, and scope rules need a review against the checklist.
"""
import re
import sys

MAX_SENTENCE_WORDS = 20  # Section 2: one sentence states one fact
MAX_REASON_SENTENCE_WORDS = 30  # Section 2: a fact with its reason
MAX_PARAGRAPH_SENTENCES = 2  # Section 2
REASON_CONNECTIVE = re.compile(r"\b(because|so that|therefore|which means|otherwise)\b", re.IGNORECASE)
REASONING_SECTION = re.compile(r"^(design decisions|context and gap|open questions|risks)\b", re.IGNORECASE)

VAGUE = r"basically|kind of|sort of|a little bit|somewhat|maybe|probably|things?|stuff|plumbing|glue|etc\.?"
PAST = r"previously|earlier|in the past|carried over|legacy|deprecated"
MODAL = r"should|could|might"
QUESTION_OPENER = re.compile(r"^(?:#+\s*)?(?:\*\*)?(when|how|why)\b", re.IGNORECASE)
PLACEHOLDER = re.compile(r"\bTODO\b|\bTBC\b|<!--")
LIST_ITEM = re.compile(r"^\s*(?:[-*+]|\d+\.)\s+(?:\[[ xX]\]\s+)?")
SENTENCE_END = re.compile(r"(?<=[.!?])\s+(?=[A-Z`*\"(])")


def blocks(lines):
    """Yields (kind, first_line_number, text) for headings, paragraphs, list items, and quotes."""
    in_fence = False
    current = None
    for number, line in enumerate(lines, start=1):
        stripped = line.strip()
        if stripped.startswith("```") or stripped.startswith("~~~"):
            in_fence = not in_fence
            if current:
                yield current
            current = None
            continue
        if in_fence or stripped.startswith("|"):
            if current:
                yield current
            current = None
            continue
        if not stripped:
            if current:
                yield current
            current = None
            continue
        if stripped.startswith("#"):
            if current:
                yield current
            yield ("heading", number, stripped.lstrip("#").strip())
            current = None
        elif LIST_ITEM.match(line) or stripped.startswith(">"):
            if current:
                yield current
            kind = "quote" if stripped.startswith(">") else "item"
            current = (kind, number, LIST_ITEM.sub("", stripped.lstrip("> ")))
        elif current:
            current = (current[0], current[1], current[2] + " " + stripped.lstrip("> "))
        else:
            current = ("paragraph", number, stripped)
    if current:
        yield current


def sentences(text):
    plain = re.sub(r"`[^`]*`", "CODE", text)
    plain = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", plain)
    return [s for s in SENTENCE_END.split(plain) if s.strip()]


def check(path):
    try:
        with open(path, encoding="utf-8") as handle:
            lines = handle.read().splitlines()
    except OSError as error:
        print(f"error: {error}", file=sys.stderr)
        sys.exit(2)

    findings = []

    def report(line, rule, text):
        findings.append(f"{path}:{line}: {rule}: {text[:100]}")

    exempt_level = None  # heading level of the reasoning-lane section we are inside, if any

    for kind, line, text in blocks(lines):
        code_free = re.sub(r"`[^`]*`", "", text)
        if PLACEHOLDER.search(text):
            report(line, "placeholder: use '> Todo:' or '## Open Questions' (Section 6)", text)
        if kind == "heading":
            level = len(lines[line - 1].strip()) - len(lines[line - 1].strip().lstrip("#"))
            if exempt_level is not None and level <= exempt_level:
                exempt_level = None
            if exempt_level is None and REASONING_SECTION.match(text):
                exempt_level = level
        # Reasoning lane (Section 5): labelled quote blocks and reasoning sections hold free prose.
        if kind == "quote" or exempt_level is not None:
            continue
        if QUESTION_OPENER.match(text):
            report(line, "starts with When/How/Why (Section 4)", text)
        for match in re.finditer(rf"\b({VAGUE})\b", code_free, re.IGNORECASE):
            report(line, f"vague word '{match.group(0)}' (Section 3)", text)
        for match in re.finditer(rf"\b({MODAL})\b", code_free):
            report(line, f"lowercase '{match.group(0)}': use present tense or RFC 2119 (Section 3)", text)
        for match in re.finditer(rf"\b({PAST})\b", code_free, re.IGNORECASE):
            report(line, f"past-state word '{match.group(0)}' (Section 5)", text)
        if kind == "heading":
            continue
        parts = sentences(text)
        for sentence in parts:
            words = len(sentence.split())
            limit = MAX_REASON_SENTENCE_WORDS if REASON_CONNECTIVE.search(sentence) else MAX_SENTENCE_WORDS
            if words > limit:
                report(line, f"sentence has {words} words, max {limit} (Section 2)", sentence)
        if kind == "paragraph" and len(parts) > MAX_PARAGRAPH_SENTENCES:
            report(line, f"paragraph has {len(parts)} sentences, max {MAX_PARAGRAPH_SENTENCES} (Section 2)", text)

    return findings


def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} FILE.md [FILE.md ...]", file=sys.stderr)
        sys.exit(2)
    findings = [finding for path in sys.argv[1:] for finding in check(path)]
    for finding in findings:
        print(finding)
    print(f"{len(findings)} finding(s)", file=sys.stderr)
    sys.exit(1 if findings else 0)


if __name__ == "__main__":
    main()
