# Crypto Command Center

A one-page command center for the crypto market and Sri Lanka's virtual-asset (VASP) regulation, built to follow the crypto market and policy news in one place.

▶ **[Open the live snapshot](https://naweenkavinda.github.io/crypto-command-center/)**. Source: [naweenkavinda/crypto-command-center](https://github.com/naweenkavinda/crypto-command-center).

> The portfolio copy is a **frozen snapshot** with the data as of October 2026. The live version runs as a claude.ai dashboard. Scheduled Claude web-search tasks refresh its 25 data sources on their own timetables, from hourly to daily. In this copy, the saved policy briefs are removed and the news thumbnails are left out.

## What it shows

**Markets**
- Prices for BTC, ETH, SOL, BNB and XRP, with sparklines, 24h high and low, 7-day change and market cap.
- Market overview, USDT dominance and top 24h movers.
- The Fear & Greed sentiment gauge.
- ETF and institutional flows.
- An events calendar and an airdrop tracker.
- Exchange and security news.

**Sri Lanka VASP regulation tracker**
- **Latest updates** from CBSL, the SEC, the FIU, ministries and Parliament, each tagged as an official source or a media report.
- **Legislative progress:** milestones from the FTR (Amendment) Act to the planned VASP law.
- **Consultations and deadlines,** plus change alerts with an unread-count bell.
- **Stakeholder map:** regulators, government, Parliament and international bodies, each with its role, latest public position, stance and source link.
- **Global benchmarks:** how other jurisdictions regulate VASPs.
- **Report generator:** writes a ready-to-send request for a policy brief on any item, with audience and length options.

**Layout**
- Drag, collapse and hide sections. Lock and save the layout, or copy it as a code.
- Turn animations on or off, and refresh each data tier separately (hourly, 3h, 6h, 12h, 24h) in the live version.

## Tech

- **HTML / CSS / JavaScript** with **d3.js** for charts and gauges.
- **claude.ai Dashboard runtime** with datasets refreshed by scheduled Claude tasks in the live version. The snapshot adds a small stand-in for that runtime, with all data bundled into the page.
- IBM Plex Sans and IBM Plex Mono fonts.
