# Changho Park — profile page

**Live site: [rikiisworking.github.io](https://rikiisworking.github.io/)**

A static one-page profile (EN / 日本語). No build step is needed: `index.html` is the whole site.

## Publish on GitHub Pages

1. Create a repository named `rikiisworking.github.io`.
2. Push `index.html`, `og.png` (and this README) to the `main` branch.
3. In the repo, open **Settings → Pages**, set Source to *Deploy from a branch*, and pick `main` / `/ (root)`.
4. The site goes live at `https://rikiisworking.github.io/`.

## Editing

- Every piece of text appears twice, as `<span lang="en">…</span><span lang="ja">…</span>`. Edit both.
- Tech logos are [Simple Icons](https://simpleicons.org) v13.21.0 (`data-si="<slug>"`); AI-tool logos missing there (IBM, Cursor, xAI) come from [LobeHub Icons](https://lobehub.com/icons) v1.90.0 (`data-lh="<slug>"`); anything else (C#, SQL Server) uses [Devicon](https://devicon.dev) v2.16.0 plain variants (`data-dv="<name>/<name>-plain"`). Chips with no logo anywhere (SQL, REST, WebSocket, SSE, Protobuf, Supervisord) use the `chip txt` dot style.
- Career timeline bars use `data-from="YYYY.MM"` / `data-to="YYYY.MM"`. A bar with no `data-to` runs to today.
- Palette: warm paper `#F7F6F2`, ink `#15181D`, one accent `#00749C` (Go cyan, deepened). A dark variant follows the OS setting. All colours are tokens at the top of the `<style>` block.
- Light/dark follows the visitor's OS until they click the theme button; the choice is remembered in their browser.
- Printing or "Save as PDF" uses a dedicated A4 layout (always light, Bisonai details expanded).
- `og.png` (1200×630) is the link-preview image for LinkedIn, Slack, etc. If the domain changes, update the `og:url`, `og:image` and `canonical` tags in `<head>`.
- To change the preview image, edit the TEXT block at the top of `tools/og.swift`, then run `sh tools/make-og.sh` (macOS; downloads Noto Sans once into `tools/.cache/`).

## Maintenance

**Update flow:** edit, preview, then commit and push. Pages redeploys in about a minute.

```sh
python3 -m http.server 8000      # preview at http://localhost:8000 (check EN/JA, light/dark, mobile)
git commit -am "Update …" && git push
```

**Updates itself:** the current job's timeline bar (no `data-to`) and the footer year.

**Review when your role changes, or every ~6 months:**

- Career: current role; set `data-to="YYYY.MM"` on a finished job's timeline bar; add new jobs
- Intro: status line and summary
- Languages: "Studying for N1" badge
- Tech stack chips
- Impact numbers
- `og.png` if the role, location or metrics change (then refresh LinkedIn's cache with Post Inspector)

**Reference material:** `reference/` holds the résumé sources the page is based on (職務経歴書, 履歴書, English résumé, intro deck). It is **git-ignored on purpose**: the files contain your phone number, birth date and address, and this repo is public. When you update your résumé, replace the files there and sync the page to match.
