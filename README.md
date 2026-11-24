# neovim-tutor

A Claude Code skill that coaches you to edit files directly in Neovim: open the right
file, move to the right place, change exactly what needs changing, save, and recover
from mistakes.

It is a Socratic tutor, in the spirit of Jane Street's `socratic-tutor`: no fixed
lesson plan and no answer key. You bring the edit you actually need to make in your
own code or config; when you have none, the tutor writes a short practice file on the
spot. One rule never bends: the tutor checks the file on disk. It snapshots the file
before you start, diffs it when you say "done", and never takes your word for what
you typed.

- 8 subskills, from "which mode am I in" to `:g` and recovering from mistakes
- Hints fade as you improve: numbered keystrokes, then command names, then only the
  goal, then the goal with a keystroke budget
- A level goes up only after two verified passes on different tasks, one of them an
  unannounced review
- A skill map, and `save state` / `resume from:` to carry progress between sessions

Written for the stock [LazyVim](https://www.lazyvim.org) config (tested on Neovim 0.12
on Omarchy Linux). Run Claude Code in one terminal and Neovim in another.

## A 30-second demo

```text
you     coach me through this edit in neovim: ~/work/settings.json line 27
        reads ,} and should be },

claude  $ scripts/snapshot.sh ~/work/settings.json

        Snapshot taken, so nothing you do in there is unrecoverable. In your other
        terminal:

          1. nvim ~/work/settings.json  Enter
          2. :27  Enter     jump to line 27
          3. cc             clear the line and enter INSERT; the indent is kept
          4. },             brace first, then the comma
          5. Esc
          6. :wq  Enter

        Say done when it is saved.

you     done

claude  $ scripts/compare.sh ~/work/settings.json
        snapshot: ~/nvim-dojo/snapshots/%home%you%work%settings.json.20261124-091502
        UNCHANGED

        FAIL. Nothing reached the disk. When you typed :27, which file name
        did the statusline at the bottom show?

you     it said "noice" or something. the message window was open. fixed, done

claude  $ scripts/compare.sh ~/work/settings.json
        snapshot: ~/nvim-dojo/snapshots/%home%you%work%settings.json.20261124-091502
        --- before
        +++ on disk
        @@ -24,7 +24,7 @@
             "confirmSync": false,
             "defaultBranch": "main",
             "pruneOnFetch": true
        -  ,}
        +  },
           "telemetry": {
             "enabled": false
           }
        CHANGED
        $ jq -e . ~/work/settings.json > /dev/null && echo valid
        valid

        PASS: exactly that change, and the file parses again.
```

## Install

Clone the repository and link it into your Claude Code skills folder:

```bash
git clone https://github.com/holdenzerega/neovim-tutor.git ~/Projects/neovim-tutor
ln -s ~/Projects/neovim-tutor ~/.claude/skills/neovim-tutor
```

Or with the [skills](https://github.com/vercel-labs/skills) CLI:

```bash
npx skills add holdenzerega/neovim-tutor
```

Then start a new Claude Code session and say "teach me neovim".

Requirements: Neovim with LazyVim (other configs work, but the hints assume
LazyVim's keys and quirks), `bash` and `diff`.

## Using it

Start a session with any of:

- "teach me neovim" or "neovim tutor"
- "coach me through this edit in neovim: <file> <what should change>"
- "drill me on vim motions"
- "help me get better at neovim"

During a session:

| Say | What happens |
|---|---|
| `done` | The tutor diffs the file against its snapshot and reports PASS or FAIL |
| `show progress` | The skill map |
| `harder` / `easier` | Fewer or more hints |
| `just tell me` | The keystrokes for the current task, which then does not count |
| `save state` | A short text block holding your levels and passes |
| `resume from:` plus that block | Continue in a new session |

A one-off question such as "what does dd do" gets a plain answer, not a session.

## How the check works

```text
scripts/snapshot.sh <file>   copies the file to ~/nvim-dojo/snapshots/ before you edit it
scripts/compare.sh <file>    diffs the latest snapshot against the file on disk; prints
                             CHANGED or UNCHANGED, and OPEN if Neovim still has the file
```

The tutor passes an attempt only when the diff is exactly the change you meant and,
where one applies, a validity check (`jq`, `bash -n`, your project's tests) passes.
If an edit goes badly wrong, the snapshot is the way back: the tutor offers to copy it
over the file and does so only if you agree. Practice files and snapshots live under
`~/nvim-dojo/`; delete that folder whenever you like.

## Evals

`evals/` holds one folder per test case in the layout `claude plugin eval` reads. From
the repository root:

```bash
claude plugin eval . --scaffold --allow-tools Bash
```

`--scaffold` lets six cases plant a file before the run. Each run is a real, billed
model call.

## License and credits

MIT, see [LICENSE](LICENSE). The tutoring mechanics are adapted from Jane Street's
`socratic-tutor` skill; see [ATTRIBUTION.md](ATTRIBUTION.md).
