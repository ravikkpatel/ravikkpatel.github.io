#!/usr/bin/env bash
set -euo pipefail

AUTHOR_NAME="${1:?Usage: $0 \"Author Name\" \"email@example.com\"}"
AUTHOR_EMAIL="${2:?Usage: $0 \"Author Name\" \"email@example.com\"}"

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

# wipe previous state
rm -rf .git index.html style.css projects.html .nojekyll README.md .gitignore

git init
git checkout -b main

commit_at() {
    local date_str="$1"
    shift
    GIT_AUTHOR_NAME="$AUTHOR_NAME" \
    GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL" \
    GIT_AUTHOR_DATE="$date_str" \
    GIT_COMMITTER_NAME="$AUTHOR_NAME" \
    GIT_COMMITTER_EMAIL="$AUTHOR_EMAIL" \
    GIT_COMMITTER_DATE="$date_str" \
    git commit "$@"
}

# ============================================================
# Commit 1: bare index.html
# ============================================================

cat > index.html << 'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Ravi Patel</title>
</head>
<body>
  <h1>Ravi Patel</h1>
  <p>Android &amp; backend developer.</p>
</body>
</html>
HTML

cat > .nojekyll << 'EOF'
EOF

cat > README.md << 'README'
# ravikkpatel.github.io

Personal site, served from GitHub Pages.
README

git add -A
commit_at "2026-02-14T10:30:00+05:30" -m "Initial site skeleton"

# ============================================================
# Commit 2: actual layout + stylesheet
# ============================================================

cat > index.html << 'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Ravi Patel</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Ravi Patel</h1>
    <p class="tagline">Android &amp; backend developer based in India.</p>
  </header>

  <main>
    <section>
      <h2>About</h2>
      <p>
        I build Android apps and the backends that feed them. Mostly Kotlin
        these days, on both sides of the wire.
      </p>
    </section>

    <section>
      <h2>Interests</h2>
      <ul>
        <li>Kotlin &amp; the JVM ecosystem</li>
        <li>Ktor and Spring Boot for backend APIs</li>
        <li>Jetpack Compose, Room, Hilt</li>
        <li>SQL and database design</li>
      </ul>
    </section>

    <section>
      <h2>Contact</h2>
      <p>GitHub: <a href="https://github.com/ravikkpatel">@ravikkpatel</a></p>
    </section>
  </main>

  <footer>
    <p>&copy; Ravi Patel</p>
  </footer>
</body>
</html>
HTML

cat > style.css << 'CSS'
:root {
  --fg: #1a1a1a;
  --bg: #fafafa;
  --accent: #2a6df4;
  --muted: #666;
}

* {
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  color: var(--fg);
  background: var(--bg);
  line-height: 1.6;
  max-width: 720px;
  margin: 0 auto;
  padding: 2rem 1.25rem;
}

header {
  border-bottom: 1px solid #e0e0e0;
  padding-bottom: 1rem;
  margin-bottom: 2rem;
}

header h1 {
  margin: 0 0 0.25rem;
  font-size: 2rem;
}

.tagline {
  color: var(--muted);
  margin: 0;
}

main section {
  margin-bottom: 2rem;
}

main h2 {
  font-size: 1.15rem;
  border-bottom: 1px solid #eee;
  padding-bottom: 0.25rem;
}

a {
  color: var(--accent);
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

footer {
  margin-top: 3rem;
  padding-top: 1rem;
  border-top: 1px solid #e0e0e0;
  color: var(--muted);
  font-size: 0.9rem;
}
CSS

git add -A
commit_at "2026-02-21T19:45:00+05:30" -m "Add real layout and stylesheet"

# ============================================================
# Commit 3: projects page
# ============================================================

cat > projects.html << 'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Projects — Ravi Patel</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Projects</h1>
    <p class="tagline"><a href="index.html">&larr; back</a></p>
  </header>

  <main>
    <section>
      <h2>cashpulse</h2>
      <p>
        Personal finance backend in Kotlin and Ktor. JWT auth, multiple
        accounts, monthly summaries, budgets per category.
      </p>
      <p><a href="https://github.com/ravikkpatel/cashpulse">github.com/ravikkpatel/cashpulse</a></p>
    </section>

    <section>
      <h2>kotlin-katas</h2>
      <p>
        Small Kotlin exercises I work on when I want to keep the basics
        sharp.
      </p>
      <p><a href="https://github.com/ravikkpatel/kotlin-katas">github.com/ravikkpatel/kotlin-katas</a></p>
    </section>
  </main>
</body>
</html>
HTML

# add a nav link from index to projects
cat > index.html << 'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Ravi Patel</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <h1>Ravi Patel</h1>
    <p class="tagline">Android &amp; backend developer based in India.</p>
    <nav>
      <a href="projects.html">projects</a>
    </nav>
  </header>

  <main>
    <section>
      <h2>About</h2>
      <p>
        I build Android apps and the backends that feed them. Mostly Kotlin
        these days, on both sides of the wire.
      </p>
    </section>

    <section>
      <h2>Interests</h2>
      <ul>
        <li>Kotlin &amp; the JVM ecosystem</li>
        <li>Ktor and Spring Boot for backend APIs</li>
        <li>Jetpack Compose, Room, Hilt</li>
        <li>SQL and database design</li>
      </ul>
    </section>

    <section>
      <h2>Contact</h2>
      <p>GitHub: <a href="https://github.com/ravikkpatel">@ravikkpatel</a></p>
    </section>
  </main>

  <footer>
    <p>&copy; Ravi Patel</p>
  </footer>
</body>
</html>
HTML

git add -A
commit_at "2026-03-08T15:20:00+05:30" -m "Add projects page and link from home"

# ============================================================
# Commit 4: small style tweaks
# ============================================================

cat > style.css << 'CSS'
:root {
  --fg: #1a1a1a;
  --bg: #fafafa;
  --accent: #2a6df4;
  --muted: #666;
}

* {
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  color: var(--fg);
  background: var(--bg);
  line-height: 1.6;
  max-width: 720px;
  margin: 0 auto;
  padding: 2rem 1.25rem;
}

header {
  border-bottom: 1px solid #e0e0e0;
  padding-bottom: 1rem;
  margin-bottom: 2rem;
}

header h1 {
  margin: 0 0 0.25rem;
  font-size: 2rem;
}

.tagline {
  color: var(--muted);
  margin: 0 0 0.5rem;
}

nav a {
  margin-right: 1rem;
  font-size: 0.95rem;
}

main section {
  margin-bottom: 2rem;
}

main h2 {
  font-size: 1.15rem;
  border-bottom: 1px solid #eee;
  padding-bottom: 0.25rem;
}

ul {
  padding-left: 1.25rem;
}

a {
  color: var(--accent);
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

code {
  background: #eee;
  padding: 0.1rem 0.35rem;
  border-radius: 3px;
  font-size: 0.9em;
}

footer {
  margin-top: 3rem;
  padding-top: 1rem;
  border-top: 1px solid #e0e0e0;
  color: var(--muted);
  font-size: 0.9rem;
}

@media (max-width: 480px) {
  body {
    padding: 1rem;
  }
  header h1 {
    font-size: 1.6rem;
  }
}
CSS

git add -A
commit_at "2026-03-22T21:00:00+05:30" -m "Tweak nav spacing and add mobile breakpoint"
