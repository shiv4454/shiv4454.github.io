# Shiv Shankar — Portfolio

A single-page personal portfolio for **Shiv Shankar**, IT Infrastructure & Automation Professional.

Dark theme, one accent gradient (blue → violet), glassmorphism cards, no frameworks and no build
step. It is static HTML, CSS and vanilla JavaScript — it works from any static host.

---

## Files

| File | Purpose |
|---|---|
| `index.html` | The entire site. All CSS and JS are inline. |
| `404.html` | Themed not-found page. |
| `favicon.svg` | Gradient "SS" mark. |
| `site.webmanifest` | PWA manifest (name, colours, icon). |
| `robots.txt` | Search crawler rules. |
| `sitemap.xml` | Single-URL sitemap. |
| `.nojekyll` | Empty. Stops GitHub Pages running Jekyll on the build. |
| `.gitignore` | Ignores editor cruft. |

---

## Before you publish — fill in the placeholders

Every unknown detail is a visibly marked placeholder so nothing is invented on your behalf.
Search the repo for these strings and replace them:

| Placeholder | Where |
|---|---|
| ~~`[ADD YOUR SITE URL]`~~ | filled with `https://shiv4454.github.io` |
| ~~`[ADD YOUR OG IMAGE URL]`~~ | `og.png` rendered at 1200x630 and committed |
| `[Add your city]` | Hero card, contact panel |
| `[Add your profile URL]`, `[Add your CV link]`, `[Add social links]` | Contact panel, footer |
| `[Add years]` | About facts |
| `[Add employer]` | Career path steps 1–3 |
| `[Year]` | Career path steps 1–5 |
| `[Add if you hold any]` | Career path step 4 (certifications) |
| `[Add your stack]` / `[Add your tools]` / `[Add your specialisation]` / `[Add your frameworks]` | Skills cards |
| `[Add what you're studying — …]` | Currently exploring |
| `[Add link]`, `[Add case study link]` | Flagship project |
| `[Add project name]`, `[Add a short description…]` | Additional project cards |
| `[Add response time]`, `[Add notice period / timezone]`, `[Add role type …]` | Contact section |

You can find them all with:

```bash
grep -rn '\[Add' .
```

---

## The contact form

Submissions are posted to **FormSubmit**, which emails them to
`shivshankar4454@outlook.com`. The visitor's address becomes the `Reply-To`, so hitting Reply
goes straight back to them.

Configuration lives in one place in `index.html`:

```js
var recipient = "shivshankar4454@outlook.com";
var endpoint = "https://formsubmit.co/" + recipient;
```

The same address appears in three spots in the markup: the form `action`, the JSON payload, and
the contact panel. Change all of them if you swap addresses.

### Three things that will silently break it

1. **Opening the file directly (`file://`) does not work.** FormSubmit rejects requests with
   `Origin: null`, which every local file gets. Serve over HTTP or deploy first. The form now
   detects this and says so instead of reporting a false success.
2. **The endpoint needs one-time activation.** The first submission triggers a confirmation email
   from FormSubmit; click its link once or every later submission is dropped.
3. **There is no server.** A static page cannot send email by itself — this is why an external
   service is involved, and why the site is no longer fully self-contained.

If you would rather not depend on FormSubmit, swap `endpoint` for a Formspree URL
(`https://formspree.io/f/<id>`) — the response handling already understands JSON success and
failure, so only the one line changes.

---

## Deploying

### GitHub Pages

```bash
git remote add origin https://github.com/<YOU>/<REPO>.git
git push -u origin main
```

Then in the repo: **Settings → Pages → Source: deploy from a branch → `main` / `/ (root)` → Save.**

The site appears at `https://<YOU>.github.io/<REPO>/` within a minute or two.

### Netlify (drag and drop)

Open `app.netlify.com/drop` and drag this folder in. Note that Netlify Drop does **not** sync
later edits — re-upload for each change. For automatic deploys, connect the Git repo instead.

### Any other static host

Upload the folder as-is. No build command, no dependencies, no server-side runtime.

---

## Local preview

Any static server works. `python3 -m http.server` is enough:

```bash
cd /path/to/portfolio
python3 -m http.server 8000
# then open http://localhost:8000
```

Remember the form itself will not send from `localhost` — see the caveats above.

---

## Design and implementation notes

- **System font stack only.** No webfonts, no icon libraries — every glyph is inline SVG, so the
  page renders identically offline and loads nothing third-party.
- **Dark theme, one accent.** Blue `#3b82f6` → violet `#8b5cf6`, used for gradients, focus rings
  and highlights. Everything else is neutral.
- **Motion is progressive.** Scroll reveals, the scrolling skill marquee, the typewriter role
  rotator and smooth anchors all respect `prefers-reduced-motion`.
- **Accessible.** Skip link, visible focus rings, labelled fields, `aria-live` on the form status,
  and a print stylesheet that drops the UI chrome so the page prints as a readable CV.
- **SEO.** Canonical URL, Open Graph and Twitter card tags, and JSON-LD `Person` structured data
  (replace the `sameAs` placeholders with your real profiles).

### Browser support

Modern evergreen browsers. Uses `IntersectionObserver`, `fetch`, CSS custom properties and
`backdrop-filter`. Without `IntersectionObserver` the scroll reveals simply show immediately
rather than staying hidden.