# Cure Dolly `TeX`tbook: Development guide

As a reference to future me, when I inevitably put down the project and pick it
up months later.

## Tools

The TeX macro framework used in this project is [ConTeXt](https://wiki.contextgarden.net/).
The `context` executable is needed to compile the book from the source files.

Conversion of the documents from Markdown to ConTeXt was done via [Pandoc](https://pandoc.org/)
using the `scripts/convert.sh` script. Other one-off bulk transformations are
also preserved in the `scripts` directory.

Conversion of `.webp` images to PNG requires the `dwebp` executable, included in
the `webp` utilities package.

## Workflow tasks

Repeatable shortcuts are defined as [Just](https://just.systems/) recipes for
convenience.

- ```just compile <file.tex>```
  - Compile the given file to PDF and place all outputs in `out/` directory.
    (The file can be one component, or the whole book.)
- ```just clean```
  - Delete all files in the `out/` directory.
- ```just nextfigure <image-name>```
  - Convert the given image from WEBP to PNG and save as the next incremented
    figure number in the `media/` directory.

## Style conventions

- No hard line wrapping in source files (to more closely follow the original
  Markdown documents).
- Punctuation goes outside of quotation marks, unless part of the quotation.
- Use Oxford comma in lists of 3 or more items.
- <mark>Highlighting</mark> and `code` markup are replaced with the below text
  styles according to their purpose.
- Surround references to written characters (graphemes) with ⟨angle brackets⟩.
- Surround references to sounds (phonemes) with /slashes/.
- For phonetic transcriptions in...
  - **English:** use IPA symbols and surround in [square brackets].
  - **Japanese (in furigana)**: use hiragana only, regardless of kun' or on'
    reading.
  - **Japanese (in body text):** use hiragana for kun' readings; katakana for
    on' readings; no brackets.
- Use conventional kanji + kana spelling for Japanese words as found in the
  [WWJDIC](https://www.edrdg.org/cgi-bin/wwwjdic/wwwjdic?1C) server. Exceptions:
  Sakura's name; some words in the very first lessons.
  - Furigana appear on only the first occurrence of a kanji reading.
  - Use rōmaji only in the context of introducing glossary terms, and for
    Japanese loan words in English context. Exception: images (frames from the
    original videos) are left as-is. Long e &rarr; ⟨ei⟩; long o &rarr; ⟨ō⟩.

| Type       | Used for | Markup example |
|------------|----------|----------------|
| *Italic* | Object references; foreign words (non-Japanese); titles of works | `The subject is {\em Sakura}` |
| <small>SMALL CAPS</small> | Initialisms and acronyms; first usage of glossary terms | `\cap{CE}`<br />`\Cap{subject}` |
| **Boldface** | Emphasis | `Use {\bf sparingly} in examples` |
| Ellipsis ⟨&hellip;⟩ | Continuation | `To be continued\ldots{}` |
| 'Single quotes' | Translations and glosses | `\quote{walk}` |
| <q>Double quotes</q> | Scare quotes; direct quotations in English | `\quotation{eihongo}` |
| <ruby>Ru<rp>【</rp><rt>る</rt><rp>】</rp></ruby><ruby>by<rp>【</rp><rt>び</rt><rp>】</rp></ruby> annotations | Furigana | `\ruby{日本人}{に\|ほん\|じん}` |
| <blockquote>Blockquote</blockqote> | Longer quotations | `\startblockquote`<br />`This is a blockquote`<br />`\stopblockquote` |

| Symbol  | Used for  | Markup example |
|---------|-----------|----------------|
| ⟨Angle brackets⟩ | References to symbols or characters | (Define a custom delimited text macro) |
| [Square brackets] | English phonetic transcription | `{[}fənɛtɪks{]}` |
| Em dash ⟨&mdash;⟩ | English dash mark | `I used them---before AI did` |
| En dash ⟨&ndash;⟩ | Numerical ranges; linking relationships | `English--Japanese translation` |
| Empty set symbol ⟨&empty;⟩ | Null subject ("zero-ga") | `\varnothing` |

### Japanese punctuation

Japanese text in the book should use the appropriate Japanese Unicode symbols.
When referring to Japanese punctuation marks in English body text, use halfwidth
variants and surround with ⟨angle brackets⟩.

| Usage | Unicode name | Codepoint | Glyph |
|-------|--------------|-----------|-------|
| Open parenthesis | Left black lenticular bracket | `0x3010` | 【 |
| Close parenthesis | Right black lenticular bracket | `0x3011` | 】 |
| Period | Ideographic full stop | `0x3002` | 。 |
| Comma | Ideographic comma | `0x3001` | 、 |
| Open quote | Left corner bracket | `0x300C` | 「 |
| Close quote | Right corner bracket | `0x300D` | 」 |
| Dakuten | Katakana-hiragana voiced sound mark | `0x309B` | ゛ |
| Handakuten | Katakana-hiragana semi-voiced sound mark | `0x309C` | ゜ |
| Sokuon | Katakana-hiragana prolonged sound mark | `0x30FC` | ー |
| Spacer | Katakana middle dot | `0x30FB` | ・ |
