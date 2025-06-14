# Open Defense Research Docs

This repository holds documentation built with [Quarto](https://quarto.org/).

Run `scripts/generate-readmes.sh` to collect README files from submodules into the `_readmes/` folder. Generated pages will automatically appear in the sidebar navigation.

The site is published automatically to GitHub Pages using the workflow in `.github/workflows/deploy.yml`. Every push to `main` rebuilds the docs and deploys the `_site` directory to the `gh-pages` branch.
