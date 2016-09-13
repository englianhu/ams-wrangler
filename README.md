# USDA Agricultural Marketing Service data wrangler

This repository contains scripts and helper functions for acquiring data from the [USDA AMS interactive report generator](https://marketnews.usda.gov/mnp/ls-report-config).
Lots of data are available IF you have the patience to sit down and click buttons for hours on end.
This repository makes the computer do that work instead.

Scripts that download data are prepended with `get_`, e.g., `R/get_cattle.R`, `R/get_hay.R`.
To acquire the cattle dataset, run the `R/get_cattle.R` script.
Data files are downloaded into the `~/Downloads` folder by default, and then renamed/moved into the `data/` directory.

## Downloading text files by default

In order for any of this to work, you have to make sure that Firefox will download text files by default rather than requiring you to interactively choose to download based on a pop-up dialogue box, see [https://support.mozilla.org/en-US/kb/change-firefox-behavior-when-open-file](https://support.mozilla.org/en-US/kb/change-firefox-behavior-when-open-file) to make sure that you're set up to download .txt files by default.

If that's not working, the workaround is to monitor the remotely driven web browser and choose to "Always save" when the first file is downloaded.
