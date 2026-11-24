# neovim-tutor

A Claude Code skill that coaches you to edit files directly in Neovim: open the right
file, move to the right place, change exactly what needs changing, save, and recover
from mistakes.

It is a Socratic tutor with one firm rule: exercises happen in a real Neovim on real
files, and the tutor checks the file on disk. It never takes your word for what you
typed.

- 8 subskills, from "which mode am I in" to `:g` and recovering from mistakes
- 24 exercises, each a scratch file under `~/nvim-dojo/` with a planted problem
- Hints fade as you improve: numbered keystrokes, then command names, then only the
  goal, then the goal with a keystroke budget
- A level goes up only after two passes on different exercises, one of them an
  unannounced review
- A skill map, and `save state` / `resume from:` to carry progress between sessions

Written for the stock [LazyVim](https://www.lazyvim.org) config (tested on Neovim 0.12
on Omarchy Linux). Run Claude Code in one terminal and Neovim in another.

## A 30-second demo

An excerpt from the middle of a session, working on line edits at level 2:

```text
claude  Exercise json-comma is set up. Open the file in your other terminal and
        follow these keystrokes:

          1. nvim ~/nvim-dojo/json-comma.json  Enter
          2. :27  Enter     jump to line 27
          3. cc             clear the line and enter INSERT; the indent is kept
          4. },             brace first, then the comma
          5. Esc
          6. :wq  Enter

        Say done when it is saved.

you     done

claude  $ scripts/check.sh json-comma
        jq: parse error: Expected another key-value pair at line 27, column 4
        FAIL json-comma

        FAIL. The file does not parse as JSON, and the error points at line 27.
        What does a comma separate in JSON: does it belong before the closing
        brace, or between the brace and the next key?

you     between the brace and the next key. I typed ,} again. fixed it. done

claude  $ scripts/check.sh json-comma
        PASS json-comma

        PASS. That is one pass for line edits at level 2. The second has to come
        from a different exercise, later and unannounced. Next: moving.
```

## Install

Clone the repository and link it into your Claude Code skills folder:

```bash
git clone https://github.com/one4eyed2king/neovim-tutor.git ~/Projects/neovim-tutor
ln -s ~/Projects/neovim-tutor ~/.claude/skills/neovim-tutor
```

Or with the [skills](https://github.com/vercel-labs/skills) CLI:

```bash
npx skills add one4eyed2king/neovim-tutor
```

Then start a new Claude Code session and say "teach me neovim".

### Requirements

- Neovim with the LazyVim config. Other configs work for most exercises; `picker`
  relies on LazyVim's `Space Space` file picker.
- `bash`, `diff`, `sed` and `jq`.
- `wl-copy` and `wl-paste` (the `wl-clipboard` package, Wayland) for the three
  clipboard exercises: `clipboard-in`, `clipboard-out`, `paste-indent`.

## Using it

Say any of these to start a session:

- "teach me neovim" or "neovim tutor"
- "coach me through this edit in neovim"
- "drill me on vim motions"
- "help me get better at neovim"

During a session:

| Say | What happens |
|---|---|
| `done` | The tutor runs the check on the file and reports PASS or FAIL with the diff |
| `show progress` | The skill map |
| `harder` / `easier` | Fewer or more hints for the current subskill |
| `just tell me` | The solution for the current exercise, which then does not count |
| `save state` | A short text block holding your levels and passes |
| `resume from:` plus that block | Continue in a new session |

A one-off question such as "what does dd do" gets a plain answer, not a session.

## Layout

```text
SKILL.md        instructions the agent follows
exercises/      24 exercises, one markdown file each
scripts/        setup.sh <id> and check.sh <id> run an exercise's Setup or Check block
evals/          test cases for the skill's behaviour
```

Each exercise file has frontmatter (`id`, `subskill`, `level`, `title`) and five
sections: Setup, Goal, Check, Solution, Mistakes. To see the catalogue:

```bash
scripts/setup.sh
```

To try one by hand:

```bash
scripts/setup.sh first-save     # writes ~/nvim-dojo/first-save.txt
nvim ~/nvim-dojo/first-save.txt # make the edit described under Goal
scripts/check.sh first-save     # prints a diff, then PASS or FAIL
```

Everything the exercises write lives under `~/nvim-dojo/`. Delete that folder at any
time; setup recreates what it needs.

## Evals

`evals/` holds one folder per test case in the layout that `claude plugin eval` reads.
From the repository root:

```bash
claude plugin eval . --scaffold --allow-tools Bash
```

`--scaffold` lets four cases plant an exercise file before the run. Each run is a
real, billed model call.

## License and credits

MIT, see [LICENSE](LICENSE). The tutoring mechanics are adapted from Jane Street's
`socratic-tutor` skill; see [ATTRIBUTION.md](ATTRIBUTION.md).
