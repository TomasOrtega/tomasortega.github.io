# Development

Edit `index.md`, `projects.md`, and `cv.md` for page content.
Edit `_bibliography/publications.bib` for publications.

## Setup

Use Ruby 4.0. See `.ruby-version` for the deployment version.
Use the Bundler version in `Gemfile.lock`.

```sh
brew install openssl@3 prek
gem install bundler --version 4.0.17 --no-document
bundle config set --local path .bundle/gems
bundle config set --local build.eventmachine "--with-ssl-dir=$(brew --prefix openssl@3)"
bundle install
prek install
```

## Preview

```sh
script/preview
```

Open [http://127.0.0.1:4000](http://127.0.0.1:4000). The browser reloads when you save changes.

## Checks

```sh
prek -a --quiet
```

This checks the files and builds the site. Use `script/check` to check the bibliography and build the site only.
