# Changho Park — profile page

A static one-page profile (EN / 日本語). No build step is needed: `index.html` is the whole site.

## Publish on GitHub Pages

1. Create a repository named `rikiisworking.github.io`.
2. Push `index.html`, `og.png` (and this README) to the `main` branch.
3. In the repo, open **Settings → Pages**, set Source to *Deploy from a branch*, and pick `main` / `/ (root)`.
4. The site goes live at `https://rikiisworking.github.io/`.

## Editing

- Every piece of text appears twice, as `<span lang="en">…</span><span lang="ja">…</span>`. Edit both.
- Tech logos are [Simple Icons](https://simpleicons.org) v13.21.0 (`data-si="<slug>"`); AI-tool logos missing there (IBM, Cursor, xAI) come from [LobeHub Icons](https://lobehub.com/icons) v1.90.0 (`data-lh="<slug>"`).
- Career timeline bars use `data-from="YYYY.MM"` / `data-to="YYYY.MM"`. A bar with no `data-to` runs to today.
- Palette: warm paper `#F7F6F2`, ink `#15181D`, one accent `#00749C` (Go cyan, deepened). A dark variant follows the OS setting. All colours are tokens at the top of the `<style>` block.
- Light/dark follows the visitor's OS until they click the theme button; the choice is remembered in their browser.
- Printing or "Save as PDF" uses a dedicated A4 layout (always light, Bisonai details expanded).
- `og.png` (1200×630) is the link-preview image for LinkedIn, Slack, etc. If the domain changes, update the `og:url`, `og:image` and `canonical` tags in `<head>`.
