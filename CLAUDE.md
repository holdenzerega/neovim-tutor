# CLAUDE.md

1. Keep the body of SKILL.md (everything after the frontmatter) under 1200 words; count it with `awk '/^---$/{n++; next} n>=2' SKILL.md | wc -w`.
2. Write SKILL.md without first person: no "I", "me", "we" or "our".
3. Every file, script and command that SKILL.md names must exist in this repository.
4. Before adding a keystroke claim to SKILL.md (including the LazyVim traps), reproduce it in a real Neovim with the LazyVim config.
5. Before pushing a change to what SKILL.md instructs or to what a script in scripts/ does, run `claude plugin eval . --scaffold --allow-tools Bash`; each run is billed, about $9 for the suite. Wording fixes that leave behaviour unchanged, and changes outside SKILL.md and scripts/, do not need it.
6. Read the trace before treating a failed eval as a skill bug: the LLM judge and the eval sandbox, where ~/nvim-dojo is read-only, both cause false failures.
