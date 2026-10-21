# Ali's Big Day

A 15-page interactive storybook for children aged 3–6. Kids help Ali, a baby elephant, travel across Sri Lanka to Grandma's Vesak lantern party. Each page has one hands-on activity that builds thinking skills or hand-eye coordination.

▶ **[Play it live](https://naweenkavinda.github.io/alis-big-day/)**. Works on phones, tablets and computers. You can add it to a phone's home screen to use it like an app.

The whole game is one self-contained file, [`index.html`](index.html), with no build step.

## Features

- **Book you can flip:** pages turn over the spine in 3D, and you see the paper back of each page as it turns.
- **Ali the elephant:** an animated SVG character who blinks, flaps his ears, swings his trunk, wags his tail, looks around, eats, sleeps and hops.
- **15 activities, each based on early-childhood research:**

| # | Page | Activity | Skill |
|---|------|----------|-------|
| 1 | Good morning, Ali! | Tap to wake Ali (age 5–6: only when the rooster crows) | Cause and effect, self-control |
| 2 | Bath-time bubbles | Pop moving bubbles (age 5–6: only the blue ones) | Hand-eye tracking |
| 3 | Where are Ali's things? | Find hidden objects | Picking things out of a busy picture |
| 4 | Breakfast for Ali | Drag the right fruit to Ali's mouth | Counting, controlled dragging |
| 5 | Mango market | How many? (age 5–6: quick look, then covered) | Recognising small numbers at a glance |
| 6 | Tuk-tuk ride | Trace the road with a finger | Pre-writing line control |
| 7 | Fix the tuk-tuk | Shape sorter (age 5–6: holes are turned) | Recognising shapes when they're turned |
| 8 | Ali says, stretch! | Ali Says movement game | Listening and stopping, movement break |
| 9 | Paddy-field patterns | What comes next? | Patterns, early maths |
| 10 | Train through the tea hills | Finger maze, new every time | Planning ahead |
| 11 | River friends | Memory cards | Working memory |
| 12 | Drawing in the sand | Watch, trace, then draw it yourself | Copying shapes |
| 13 | Sort the seashells | Sort by colour, then switch to shape | Flexible thinking |
| 14 | Build Grandma's lantern | Copy a coloured pattern | Spatial reasoning |
| 15 | The lantern party | Sticker sky, certificate, Ali falls asleep | Reward and a clear stopping point |

- **Two levels:** age 3–4 and age 5–6, chosen in a grown-ups area that young children can't open.
- **Made for pre-readers:**
  - Every instruction is spoken aloud.
  - Wrong moves never count as failing.
  - If the child gets stuck, a hint glows.
  - Every drag can also be done as "tap the item, then tap where it goes".
- **Rewards:** a sticker for each page, a spinning 3D star, confetti, and a big centred "Next page" button.
- **For parents:** an optional play timer with a gentle break screen, and a screen-free follow-up idea for every page.
- **Works on phones:** layouts adjust for portrait and landscape, and double-tap and pinch zoom are blocked.
- **Private:** no ads, no accounts and no data collection. Progress is saved only on the device.

## Research basis

The activities draw on:
- Preschool workbooks from Kumon, Gakken and Highlights, and Hervé Tullet's *Press Here*.
- Preschool apps such as Busy Shapes, Fiete, Endless Alphabet and Pok Pok.
- Harvard Center on the Developing Child's executive-function activities.
- Research on fine-motor and shape-copying milestones.
- Guidance on designing touchscreens for young children (Nielsen Norman Group, WHO and AAP screen-time guidance).

## Tech

HTML, CSS and plain JavaScript in a single file. It uses:
- SVG for the characters, road and maze.
- Canvas for the sand drawing.
- The Web Audio API for sound effects.
- The Web Speech API for narration.
- CSS 3D transforms and container queries for the layout and page turns.

Source code: [naweenkavinda/alis-big-day](https://github.com/naweenkavinda/alis-big-day)
