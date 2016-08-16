# Scraping data from the USDA Agricultural Marketing Service

This repository contains scripts and helper functions for acquiring data from the USDA AMS interactive report generator.

Scripts that download data are prepended with `get_`, e.g., `R/get_cattle.R`, `R/get_hay.R`.
To acquire the cattle dataset, run the `R/get_cattle.R` script.
Data files are downloaded into the `~/Downloads` folder by default, and then renamed/moved into the `usda_scrape/data/` directory.

## Important:

In order for any of this to work, you have to make sure that Firefox will download text files by default rather than requiring you to interactively choose to download based on a pop-up dialogue box, see [https://support.mozilla.org/en-US/kb/change-firefox-behavior-when-open-file](https://support.mozilla.org/en-US/kb/change-firefox-behavior-when-open-file) to make sure that you're set up to download .txt files by default.

If that's not working, the workaround is to monitor the remotely driven webbrowser and choose to "Always save" when the first file is downloaded.
