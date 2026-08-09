# Development

`README.md` is the short GitHub profile. The website is built from `index.md`, `projects.md`, and `cv.md`.

## Setup

Use Ruby 4.0. `.ruby-version` pins the deployment version; local patch releases in the same series also work.

```sh
brew install prek
bundle config set --local path .bundle/gems
bundle install
prek install
```

## Preview

```sh
script/preview
```

Open [http://127.0.0.1:4000](http://127.0.0.1:4000). Jekyll rebuilds the website when source files change.

## Checks

```sh
prek run --all-files
```

This runs formatting and syntax checks, RuboCop, ShellCheck, Markdownlint, Actionlint, a zizmor security audit, and a
production site build. Run `script/check` directly when you only need the Jekyll build.

## Deploy

The workflow in `.github/workflows/pages.yml` checks pull requests and deploys pushes to `main`.

For the first deployment, open **Settings → Pages** on GitHub and change **Source** from **Deploy from a branch** to **GitHub Actions**. After that, edit the workflow file whenever the deployment process needs to change.

Keep `CNAME`; it records the custom domain in the deployed artifact.

## Repository map

- `README.md`: GitHub profile
- `index.md`: website homepage
- `projects.md`: project descriptions
- `cv.md`: CV content and source-only inactive entries
- `_bibliography/publications.bib`: CV publication data
- `_plugins/cv_bibliography.rb`: CV citation and bibliography renderer
- `_layouts/default.html`: shared page structure and navigation
- `_includes/project-figure.html`: shared project image markup
- `assets/css/style.scss`: website styles
- `assets/js/print-cv.js`: CV print action
- `script/preview`: local website server
- `script/check`: production site build
- `.pre-commit-config.yaml`: prek checks
- `.github/dependabot.yml`: dependency update schedule
- `.github/workflows/pages.yml`: CI and deployment
