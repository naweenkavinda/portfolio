# Work Command Center

A personal and team action-item board for running day-to-day work at a fintech company. Tasks are grouped by team and by category, and urgent items surface first.

▶ **[Try the live demo](https://naweenkavinda.github.io/work-command-center/)**. Source: [naweenkavinda/work-command-center](https://github.com/naweenkavinda/work-command-center).

> The portfolio copy is a demo: it starts with made-up sample tasks and generic categories, and saves your changes only in your own browser. The real board runs as a claude.ai artifact on a shared database, so the whole team sees the same items live.

## What it does

- **Kanban view:** tasks split into Urgent, In Progress and Done columns. The 15 most recent finished items stay visible.
- **Teams view:** the same tasks grouped by Business Development, Developers, Management and Marketing.
- **Category filters:** Finance, Legal, Partners, Security and Other.
- **My Work board:** your own items, plus any task you star from the team board. Tasks that mention you (`@me`) are picked up automatically.
- **Live stats:** active, urgent, finished in the last 7 days, and your own open items.
- **Fast capture:** add a task with team, priority, urgency, source, notes and a link (Google Docs and the like). Links show the site name on the card.
- **Light and dark themes,** with your choice remembered.
- **Works on phones:** columns stack vertically on narrow screens.

## Tech

- **HTML / CSS / JavaScript:** one file, no framework.
- **claude.ai artifact database:** shared, real-time task storage in the live version. The demo swaps in a small store kept in the browser.
- DM Sans and JetBrains Mono fonts.
