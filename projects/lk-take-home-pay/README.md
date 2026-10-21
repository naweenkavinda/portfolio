# Sri Lanka Take-Home Pay

Salary calculator for Sri Lanka showing APIT, EPF and ETF, the employee's real take-home pay and the employer's true cost, with every formula tied to the law.

▶ **[Open it live](https://naweenkavinda.github.io/lk-take-home-pay/)**. Works on phones, tablets and computers. Source: [naweenkavinda/lk-take-home-pay](https://github.com/naweenkavinda/lk-take-home-pay).

## What it does

- **Employee page:** a payslip with APIT and EPF deducted, the take-home figure, EPF/ETF savings credited each month, a band-by-band tax breakdown, and a reverse solver that finds the basic salary for a target take-home.
- **Employer page:** the true monthly and annual cost of a hire, a split of where every rupee goes, the payments due to the EPF, the ETF Board and the Inland Revenue Department with legal deadlines, the gratuity liability by years of service, and a solver for the highest salary within a budget.
- **Tax rules:** follows the Inland Revenue Department's APIT tables, covering monthly pay, bonuses, non-resident foreign nationals and second jobs. Overtime, benefits in kind (car, housing, phone) and higher EPF rates are included.
- **Compliance checks:** national minimum wage, the overtime cap, the deduction limit and EPF coverage, each citing the Act and section it comes from.

## Notes and limits

- Rules are those in force from 1 April 2025, which still apply for 2026/27. Sources were checked in October 2026.
- It is an estimate, not tax or legal advice. Bonus tax assumes the same salary all year. Terminal benefits and reliefs claimed on the annual return are explained but not calculated.
- Runs entirely in the browser. Nothing is sent or stored.

## Tech

- Single-file HTML, CSS and JavaScript, no frameworks or libraries
- Mobile friendly: one column on phones, no sideways scrolling, light and dark themes
- Formulas verified against IRD worked examples (Table 01 and Table 02)
