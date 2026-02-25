# PRISM Documentation

Documentation for the PRISM ecosystem within the Australian Future Hearing Initiative. This site is built using [Quarto](https://quarto.org/) and hosted on [GitHub Pages](https://miniature-carnival-v9nmwzn.pages.github.io/).


## Local Development
To preview the site locally:
```bash
git clone git@github.com:Australian-Future-Hearing-Initiative/prism-docs.git
cd prism-docs
quarto preview index.qmd --no-browser
```

Make changes in a branch and push to GitHub. The site will be automatically rendered and deployed to GitHub Pages (once pulled to the `main` branch).
```
git checkout -b new-changes
# make changes
git commit -am "new changes"
git push origin new-changes
```

## Repository structure

- `index.qmd`: The main homepage and entry point for the documentation website.
- `guide/`: Sub pages for the documentation website.
- `_quarto.yml`: Quarto project configuration file.
- `sync-docs.sh`: Script to link documentation from prism repositories.


## Initial Setup

### Prerequisites
- [Quarto](https://quarto.org/docs/get-started/) installed
- Git


### Automatic publishing to GitHub Pages

1. **Create `gh-pages` branch**:
   ```bash
   # quarto first needs a branch to publish to
   git checkout -b gh-pages
   git push origin gh-pages 
   quarto publish gh-pages
   # switch back to main (or your dev branch) and continue working
   git checkout main
   ```

2. **Enable GitHub Pages**:
   - Go to your repository settings on GitHub
   - Navigate to **Pages**
   - Set the source to **`gh-pages` branch**
   - Save changes

3. **Add GitHub Actions**:
   Create a file `.github/workflows/quarto-publish.yml` with the following content:
   ```yaml
   name: Quarto Publish

   on:
     push:
       branches: main

   permissions:
     contents: write
     
   jobs:
     build-deploy:
       runs-on: ubuntu-latest
       steps:
         - name: Check out repository
           uses: actions/checkout@v3

         - name: Set up Quarto
           uses: quarto-dev/quarto-actions/setup@v2
           with:
             tinytex: true

         - name: Publish to GitHub Pages (and render)
           uses: quarto-dev/quarto-actions/publish@v2
           with:
             target: gh-pages
             path: .
   ```

Now, any push to the `main` branch will automatically render and deploy the site to GitHub Pages.


## License
Code is licensed under the **MIT License** or **Apache 2.0** depending on the component. Please check individual `LICENCE` files in each repository.
