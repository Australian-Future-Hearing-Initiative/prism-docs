# PRISM Documentation

Documentation for the PRISM ecosystem. This site is built using [Quarto](https://quarto.org/) and hosted on GitHub Pages.

## 🛠️ Setup & Development

### Prerequisites
- [Quarto](https://quarto.org/docs/get-started/) installed
- Git

### Local Development
To preview the site locally:
```bash
# Render and serve the site
quarto preview index.qmd --no-browser
```

### Publishing to GitHub Pages

#### One-Time Setup
1. **Create `gh-pages` branch**:
   ```bash
   git checkout -b gh-pages
   quarto publish gh-pages
   git push origin gh-pages 
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
