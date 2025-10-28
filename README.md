# Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis  
_A Systematic Review and Statistical Analysis (BMJ submission)_

This repository contains analysis code and figure/table generation scripts accompanying the manuscript **“Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis: A Systematic Review and Statistical Analysis.”**

> **Data access:** The analytic dataset is not public. Access can be requested (see **Data access** below). All code is included to ensure full reproducibility once data are available locally.

---

## Repository structure

```
.
├── figures/
│   ├── figure_S1/
│   │   ├── figure_S1.R        # Reproduces results for Figure S1
│   │   ├── figure_S1.tex      # Builds the figure / arranges subpanels
│   │   └── tex/               # LaTeX sources for sub-figures (panels)
│   ├── figure_2/
│   │   ├── figure_2.R
│   │   ├── figure_2.tex
│   │   └── tex/
│   ├── figure_3/              # Same structure as above
│   ├── figure_4/
│   ├── figure_5/
│   ├── figure_6/
│   └── figure_7/
│
├── tables/
│   ├── data_dictionary.pdf    # Variable definitions for all datasets
│   ├── data1.csv              # Concomitant IIM and MG
│   ├── data2.csv              # ICI-Induced IIM and/or MG
│   ├── data3.csv              # Isolated IIM with TET
│   ├── data4.csv              # Thymoma spontaneous regression
│   ├── table_1/               # R scripts for analyses using data1.csv
│   ├── table_2/               # R scripts for analyses using data2.csv
│   ├── table_3/               # R scripts for analyses using data3.csv
│   └── table_4/               # R scripts for analyses using data4.csv
│
├── README.md                  # You are here
└── (optional) renv/ or requirements files if present
```

---

## How to reproduce results

> You’ll need local copies of the data files (see **Data access**) in `tables/` with the exact filenames listed above.

### 1) Figures (Figure S1, Figures 2–7)
Each `figures/figure_*` folder contains:
- an **R script** (`figure_*.R`) that computes and saves the objects/outputs used in the figure;
- a **LaTeX wrapper** (`figure_*.tex`) that composes the final figure or arranges sub-figures into panels;
- a `tex/` **subfolder** with LaTeX sources for individual sub-figures.

**Typical workflow**
```bash
# From the repository root:
Rscript figures/figure_2/figure_2.R

# Then compile the corresponding LaTeX file (choose your engine):
cd figures/figure_2
pdflatex -interaction=nonstopmode figure_2.tex
# or: latexmk -pdf figure_2.tex
```

Repeat for `figure_S1`, `figure_3`, …, `figure_7`.

### 2) Tables (analyses for data1–data4)
Each `tables/table_k/` folder contains R code that reads the corresponding dataset and produces the statistics displayed in the manuscript tables.

**Typical workflow**
```bash
# Example for data1 (Concomitant IIM and MG)
Rscript tables/table_1/run_table_1.R

# Example for data2 (ICI-Induced IIM and/or MG)
Rscript tables/table_2/run_table_2.R
```

Consult in-file comments for any dataset-specific options or outputs (model summaries, CSV exports, TeX fragments, etc.).

### 3) Working directory setup

Before running any R script, make sure to set your working directory to the folder where both the data (e.g., `data1.csv`) and the script (e.g., `data1.R`) are located. This ensures the script can properly locate and read the input files.

```r
# Example for data1
setwd("/path/to/tables/table_1")
source("data1.R")
```

Replace `"/path/to/tables/table_1"` with the actual path on your computer.  
Alternatively, use RStudio’s “Session → Set Working Directory → To Source File Location” option.

---

## Software requirements

- **R** (version ≥ 4.x recommended)
- Standard R packages used by the scripts (see the `library(...)` calls at the top of each `.R` file).  
  If you use `renv` or another environment file present in the repo, restore with:
  ```r
  # inside R
  install.packages("renv")
  renv::restore()
  ```
- **LaTeX** distribution (e.g., TeX Live or MiKTeX) with `pdflatex` or `latexmk` to build figures from `.tex` sources.

---

## Data access

The dataset is **available upon request for research purposes**.

- **Data queries:** **luoj1129@gmail.com**  
- Please reference the manuscript title in your request and briefly describe your intended use.

> Note: Some scripts will not run to completion without the data files present at `tables/data1.csv`–`data4.csv`. The **data_dictionary.pdf** provides variable definitions and coding details.

---

## Questions & support

- **Code and reproducibility questions:** **jileil2@gwmail.gwu.edu**  
- **Data requests:** **luoj1129@gmail.com**

---

## Citation

If you use this code or build on the analyses, please cite the manuscript:

> **Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis: A Systematic Review and Statistical Analysis.** (Submitted to **BMJ**).

A formal citation will be added once the paper is accepted and bibliographic details are available.

---

## Disclaimer

This repository is provided for academic and research use. Results may change as the manuscript undergoes peer review and revisions.
