# Portfolio Homepage

The homepage of this portfolio, drawn as a civil engineer's site plan: every project is a "plot", and line-art doodles wander across the sheet.

▶ **[Open the homepage](https://naweenkavinda.github.io/portfolio/)**. Source: [`index.html`](../../index.html).

## What it does

- **Site Plan design:** a concrete drafting grid, huge condensed lettering and safety-orange accents. Projects are plots of different sizes on a 12-column grid, each with its own line-drawn icon and a Live / Demo / Snapshot badge.
- **Elegant motion:**
  - the name rises into place and a dimension line draws itself;
  - plots sweep in as they scroll into view, with their icons drawing line by line;
  - hovering a plot lifts it with speed lines.
- **A welcome on every visit:** an engineer in a hard hat slides out from behind the name, pulls a "Welcome!" board out of his toolbox, puts it back, and walks off behind the letters again.
- **Line-art doodles at random:**
  - a spring-bodied dog that holds on to the page while you scroll and walks on when you stop;
  - flapping birds;
  - a propeller plane looping with a drawn trail;
  - a tape measure that measures a plot;
  - stick figures that peek, wave, cheer, high-five, jump out and run off.
- **Kind to visitors:** a Doodles on/off switch, everything still for anyone using reduced motion, the doodles pause in background tabs, clicks pass straight through the doodles, and every demo opens in a new tab.
- **Builds itself:** a GitHub Action regenerates the homepage plots and the README project table from the `projects/` folders on every push. A new project appears just by adding its folder.
- **Guards what gets published:** every push runs an automatic scan for personal data and private terms, plus a Claude privacy review of the exact commit, before anything leaves the computer. The same scan runs again on GitHub.

## Tech

- **HTML / CSS / JavaScript:** no framework. SVG line art, CSS keyframes and the Web Animations API.
- **PowerShell:** the page generator and the leak scanner.
- **GitHub Actions and GitHub Pages:** automatic rebuilds, checks and hosting.
- Big Shoulders Display, Archivo and Martian Mono fonts.
