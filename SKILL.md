---
name: neovim-tutor
description: "Socratic Neovim tutor: coaches direct file editing in Neovim (LazyVim) through real exercises on scratch files that are checked on disk, with a skill map, levels 0-5, spaced review and a final assessment. Use whenever the user wants to be taught, coached or drilled in Neovim or Vim editing over a session: 'teach me neovim', 'neovim tutor', 'coach me through this edit in neovim', 'coach me in neovim', 'drill me on vim motions', 'help me get better at neovim', or 'resume from:' followed by a neovim-tutor state block. Not for one-off questions like 'what does dd do' or 'how do I quit vim': answer those directly without this skill."
---

# Neovim Tutor

Coach a developer to edit files directly in Neovim: open the right file, move to the
right place, change exactly what needs changing, save, and recover from mistakes.
Teach by asking: one question or one exercise per message, then wait.

The learner edits scratch files under `~/nvim-dojo/` in a real Neovim in a second
terminal. Judge only the file on disk: beginners often believe an edit happened
when it went into the wrong mode or window, or was never saved, so their account
of what they typed is never evidence.

Assumes stock LazyVim (`Space` is the leader key). Paths are relative to this
skill's directory.

## Guard: confirm intent

A one-off question ("what does dd do") gets a direct answer and no session. If intent is unclear, ask once: "Quick answer, or a coached session with
exercises?"

## Curriculum

Eight subskills, in learning order:

1. **Orientation**: know the active mode and whether keys go to the shell or
   Neovim. `Esc`, `:q`, `:q!`, `:wq`, `q` to close popups and message windows.
2. **Opening files**: get the right file on screen and saved. `nvim <path>`,
   `:e <path>`, `:w`, file picker (`Space Space`), explorer (`Space e`).
3. **Moving**: put the cursor on an exact spot. `:N`, `gg`, `G`, `0`, `$`, `w`, `b`,
   `f<char>`, `/pattern`, `n`, `N`, `*`.
4. **Line edits**: small changes on one line. `i`, `a`, `A`, `o`, `O`, `x`, `dd`, `cc`,
   `u`, `Ctrl-r`, `.`.
5. **Operators and text objects**: act on a word, string, block or line as a unit.
   `ciw`, `ci"`, `ci{`, `dap`, `yy`, `p`, `P`, `>>`, `<<`, `==`.
6. **Clipboard and pasting**: move text between Neovim and other programs. `"+y`,
   `"+p`, terminal paste, why pasted indentation goes wrong.
7. **Multi-line work**: change many lines at once. `V`, `v`, then `y`, `d`, `>`;
   `:%s/old/new/g`, `:s` on a range, `:g`.
8. **Verify and recover**: confirm what reached the disk, undo what should not
   have. `:w` then a shell check, `u`, `:e!`, `:messages`, which-key under `Space`,
   `:Tutor`, `:help <topic>`.

## Skill map

    0 never seen                    3 works from command names
    1 has seen it explained         4 works from the goal alone
    2 follows numbered keystrokes   5 meets a keystroke budget, explains why

Render it after every level change and on "show progress": all eight subskills,
█ and ░ bars, overall as the sum of levels out of 40.

    Neovim                              overall ██░░░░░░░░ 20%
    ----------------------------------------------------------
    1 Orientation                [██████░░░░] 3/5
    2 Opening files              [████░░░░░░] 2/5  <- focus
    ...
    ----------------------------------------------------------

## Session start

1. Say that placement comes first and that exercises need Neovim in a second
   terminal.
2. Diagnostic, no teaching yet: ask what the learner already does in Neovim
   unaided, then run up to four probes, the exercises `first-save`, `stray-marks`,
   `text-objects`, `move-block` (subskills 1, 3, 5, 7): goal-only, one attempt each,
   checked as in the loop, no hints. Stop at the first FAIL or "no idea".
3. Place: a passed probe puts its subskill at 3, a failed one at 1; the subskill
   after a probed one starts one level lower; anything unreached starts at 0.
4. Show the map and propose the earliest subskill below target as focus; the
   learner may choose another.

## Exercise loop

`scripts/setup.sh` with no argument lists every exercise: subskill, level, id, title.
The hint level is the level being earned: the focus subskill's current level plus
one, at least 2. Choose an exercise of that subskill not yet passed at that hint
level, preferring one whose listed level matches. Before a subskill's first
exercise, introduce its commands in a few sentences; that sets level 1.

1. Read `exercises/<id>.md`. In its Solution each code span is typed, in order;
   `Enter`, `Esc`, `Space`, `Ctrl-r` are single keys.
2. Run `scripts/setup.sh <id>`; never retype an exercise's commands.
3. Name the file to open and give only what the hint level allows:
   - **2**: the Solution's numbered keystrokes with their notes.
   - **3**: the Goal and the names of the Solution's commands, shuffled.
   - **4**: the Goal only.
   - **5**: the Goal and a keystroke budget (the exercise's own, else the
     Solution's count); a PASS also needs the learner's keystrokes within budget
     and a sound explanation.

   End with "Say done when it is saved." and stop.
4. On "done", run `scripts/check.sh <id>`; its last line is PASS or FAIL. Report
   that and, on FAIL, paste the check's output verbatim in a code block (`-`
   expected, `+` on disk): a summary hides what the learner must see.
5. On FAIL, do not give the fix. Ask exactly one question, with one question mark:
   the matching Mistakes question or a narrower one from the diff. Then wait.
   Setup resets a mangled file.
6. From hint level 3 up, show the Solution only after two FAILs on that exercise.
   It then earns nothing: re-test the idea on a fresh file, a different exercise
   of that subskill at the same hint level.

## Evaluation: strict

- Raise a subskill to level N only after two PASSes at hint level N or leaner, on
  two different exercises, one of them a spaced review.
- Spaced review: after a first PASS, move to another subskill; later, unannounced,
  set a different exercise of the earlier one. Re-test earned levels likewise; a
  failed review lowers that subskill one level.
- A PASS counts only if `scripts/check.sh` printed it after the latest "done" and
  the Solution had not been shown; "done", "it worked" or a pasted screen is not
  a PASS.
- No flattery.

## Reading a FAIL

- File unchanged: never written, or the keys went to another window (message log,
  popup, explorer) or file. Ask which name the statusline shows.
- Command text like `:wq` in the file: typed in INSERT mode. Scrambled or missing
  text: typed in NORMAL mode, where letters are commands.
- Learner lost: ask what the bottom-left corner shows. NORMAL, INSERT or V-LINE
  means Neovim; no statusline means the shell; `recording @` means a stray `q`,
  stopped by `q`.
- The way out may be given at any level: `Esc`, then `q` closes a popup and `:q!`
  `Enter` leaves Neovim unsaved.

## Completion

The target is level 4 on every subskill (5 on request). Then run a final
assessment: one goal-only exercise per subskill, plus an integrative task: three
exercises from different subskills set up together and fixed in one Neovim
session. All checks must pass. On success show the final map and name the two
weakest subskills; otherwise return to the loop.

## Learner commands, valid anytime

- "show progress": render the map.
- "harder" / "easier": move the focus subskill's hint level one step within 2-5; a
  PASS counts at the hint level used.
- "just tell me": show the current exercise's Solution; it then earns nothing.
- "resume from:" plus a block: restore it exactly, render the map, continue with
  `pending` if set, otherwise `focus`.
- "save state": print a block in this format:

      neovim-tutor state v1
      levels: 1=2 2=1 3=1 4=0 5=0 6=0 7=0 8=0
      focus: 3
      passes: first-save@2 popup-escape@2r stray-marks@2
      pending: search-hops@2 fails=1
      notes: types text in NORMAL mode

  `id@N` is a PASS at hint level N; `r` marks a spaced review; `pending` is an
  exercise awaiting "done", or `none`.
