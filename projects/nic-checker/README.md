# NIC Checker

A single-page tool for Sri Lankan National Identity Card (NIC) numbers. It builds a NIC from a date of birth and serial, and checks, decodes and converts existing NICs in both the old and new formats.

**[▶ Open the live tool](https://naweenkavinda.github.io/portfolio/projects/nic-checker/)**

## What it does

**Build from birthday**
- Enter a date of birth (1900 to today), gender and serial
- Born 1999 or earlier: gives the old 10-character NIC (`YY DDD SSS C` + V/X) and its 12-digit equivalent
- Born 2000 or later: gives the 12-digit NIC only (`YYYY DDD SSSS C`)
- Shows the day number (with +500 for women) and the full check-digit working

**Check a NIC**
- Accepts either format and ignores spaces and dashes
- Reads the date of birth and gender
- Says whether the check digit is correct, and what it should be if not
- Converts between the old and new formats where possible
- Catches impossible years and day numbers

## How the check digit works

Both formats use a weighted sum and mod 11. Multiply each digit by its weight, add them up to get S, then:

```
C = 11 − (S mod 11)      (if that gives 10 or 11, C = 0)
```

| Format | Digits used | Weights |
|:--|:--|:--|
| Old (10 characters) | first 8: `YY DDD SSS` | `3 2 7 6 5 4 3 2` |
| New (12 digits) | first 11: `YYYY DDD SSSS` | `8 4 3 2 7 6 5 8 4 3 2` |

The new weights keep the old ones and add weights for the extra digits. For anyone born in the 1900s, the century digits `19` add 1×8 + 9×4 = 44, which is a multiple of 11. That's why a converted NIC (`19` + year + day + `0` + serial) keeps its old check digit.

Day numbers count February as 29 days in every year, and women's NICs add 500 to the day.

## Notes and limits

- The check-digit method isn't officially published. It was worked out by testing against known NICs: 1,000 old-format numbers and several real 12-digit numbers.
- The weight on the first serial digit of 12-digit NICs hasn't yet been tested on a real NIC with a serial of 1000 or higher.
- A correct check digit only means a number is well-formed. It doesn't confirm the NIC was ever issued. Official verification goes through the Department for Registration of Persons.

## Tech

- Single-file HTML, CSS and JavaScript, no frameworks
- Dark theme: B612 Mono for numbers and labels, Atkinson Hyperlegible for text
- Updates live as you type; copy buttons for each result
- Mobile friendly: one column on phones, large tap targets, no sideways scrolling
- Built as a claude.ai Artifact and also runs as a static page
