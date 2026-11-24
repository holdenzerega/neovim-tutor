# Attribution

neovim-tutor is modelled on the `socratic-tutor` skill by Jane Street.

- Repository: https://github.com/janestreet/agent_skills
- Skill: `socratic-tutor`
- Upstream commit: `469868f`
- License: MIT

## What was adapted

The tutoring mechanics come from `socratic-tutor`: confirming intent before starting
a session, a diagnostic that places the learner, a skill map with levels 0 to 5,
strict evaluation, spaced review, a final assessment, and the learner commands
"show progress", "harder", "easier", "just tell me", "save state" and "resume from:".

## What is different

The text is rewritten and specialised for Neovim. The curriculum, the exercises,
the two scripts, and the rule that every attempt is judged by a check on the file
on disk are original to this repository.

## Upstream license

```text
The MIT License

Copyright (c) 2026 Jane Street Group, LLC <opensource-contacts@janestreet.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
