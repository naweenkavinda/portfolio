# Bitcoin Pelahara — Online Book Shop

A single-page order form for selling "බිට්කොයින් පෙළහර" (Bitcoin Pelahara), the Sinhala translation of Vijay Boyapati's "The Bullish Case for Bitcoin", translated by CeylonCash.

🛒 **[Live shop](https://comforting-gumption-b35bdf.netlify.app)**, the real store on Netlify.
▶ **[Portfolio demo](https://naweenkavinda.github.io/book-shop/)**. Source: [naweenkavinda/book-shop](https://github.com/naweenkavinda/book-shop).

> The portfolio copy runs in demo mode: the order form goes through the full flow but sends nothing. The order email and WhatsApp number are replaced with placeholders.

## What it does

- Product page with photo gallery (tap thumbnails to switch main image)
- Three fulfilment options: cash on delivery, card payment, or in-person pickup at Colombo 7
- Dynamic pricing that recalculates based on delivery method
- Order form sends submissions directly to email via FormSubmit.co (no backend needed)
- WhatsApp contact button (number hidden from page text for privacy)
- Mobile-responsive dark design

## Tech

- **HTML / CSS / JavaScript** — Single-page, no framework
- **FormSubmit.co** — Serverless form handling
- **Python / PIL / OpenCV / rembg** — Product photo processing (background removal, perspective correction, colour balancing)
- **Playwright** — Automated testing across desktop and mobile viewports
- **Netlify** — Static hosting via drag-and-drop deploy

## Photo Processing

Raw product photos were professionally cleaned:
- Background removal using rembg (isnet-general-use model)
- Perspective correction via OpenCV's getPerspectiveTransform
- White balance correction (92nd percentile normalisation per channel)
- Composited onto dark studio backgrounds with soft shadows
- Social share banner generated for Facebook/WhatsApp

## Business Rules

- Marked price: Rs. 1,600
- Card / COD price: Rs. 1,400 + Rs. 350 delivery
- In-person pickup: Rs. 1,400 (no delivery fee)
- Orders emailed to the seller; WhatsApp for customer enquiries
